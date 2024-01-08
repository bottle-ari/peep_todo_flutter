import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:peep_todo_flutter/app/controllers/data/category_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/palette_controller.dart';
import 'package:peep_todo_flutter/app/controllers/data/routine_controller.dart';
import 'package:peep_todo_flutter/app/controllers/widget/peep_mini_calendar_controller.dart';
import 'package:peep_todo_flutter/app/data/enums/todo_enum.dart';
import 'package:peep_todo_flutter/app/data/model/category/category_model.dart';
import 'package:peep_todo_flutter/app/data/model/enum/page_state.dart';
import 'package:peep_todo_flutter/app/data/model/routine/routine_model.dart';
import 'package:peep_todo_flutter/app/data/model/todo/todo_model.dart';
import 'package:uuid/uuid.dart';

import '../../core/base/base_controller.dart';
import '../../utils/peep_calendar_util.dart';
import '../../utils/routine_util.dart';
import '../data/pref_controller.dart';
import '../data/todo_controller.dart';
import '../main/main_controller.dart';

class SelectedTodoController extends BaseController with PrefController {
  final PaletteController _paletteController = Get.find();
  final MainController mainController = Get.find();
  final CategoryController _categoryController = Get.find();
  final TodoController _todoController = Get.find();
  final PeepMiniCalendarController _peepMiniCalendarController = Get.find();
  final RoutineController _routineController = Get.find();

  // Data
  final RxMap<String, List<dynamic>> selectedTodoMap =
      <String, List<dynamic>>{}.obs;

  // Variables
  Map<String, Map<String, List<int>>> categoryIndexMap =
      <String, Map<String, List<int>>>{};
  RxMap<String, bool> categoryFoldMap = <String, bool>{}.obs;

  //pageController
  late final Rx<PageController> pageController;
  bool isPageChange = false;

  TodoModel? newTodo;
  String? newTodoCategoryId;

  final TextEditingController textFieldController = TextEditingController();
  final Rx<FocusNode> focusNode = FocusNode().obs;
  final RxBool isInputMode = false.obs;

  final isFirstTimeAccess = false.obs;

  SelectedTodoController() {
    pageController =
        PageController(initialPage: mainController.pageIndex.value).obs;
  }

  @override
  void onInit() async {
    super.onInit();

    focusNode.value.addListener(_focusNodeListener);

    // 투두 데이터 변경 감지
    ever(_todoController.todoMap, (callback) async {
      updatePageState(PageState.LOADING);
      await updateSelectedTodoList();
      updatePageState(PageState.SUCCESS);
    });

    // 선택된 날짜 변경 감지
    ever(_todoController.selectedDate, (callback) async {
      log("selected Date Observer : ${_todoController.selectedDate.value}");
      //onMoveDate();
    });

    // 카테고리 데이터 변경 감지
    ever(_categoryController.categoryList, (callback) async {
      updatePageState(PageState.LOADING);
      await updateSelectedTodoList();
      updatePageState(PageState.SUCCESS);
    });

    // 루틴 데이터 변경 감지
    ever(_routineController.routineList, (callback) async {
      updatePageState(PageState.LOADING);
      await updateSelectedTodoList();
      updatePageState(PageState.SUCCESS);
    });

    await updateSelectedTodoList();
    loadIsFirstTimeAccess();
    updatePageState(PageState.SUCCESS);
  }

  @override
  void onClose() {
    focusNode.value.removeListener(_focusNodeListener);
    focusNode.value.dispose();
    super.onClose();
  }

  void _focusNodeListener() {
    if (!focusNode.value.hasFocus) {
      addNewTodoConfirm();
    }
  }

  /*
    Init Functions
   */
  void loadIsFirstTimeAccess() async {
    var key = 'isFirstTimeAccess';

    final value = getInt(key);
    if (value == null) {
      saveInt(key, 1);
      isFirstTimeAccess.value = true;
    } else if (value == 1) {
      isFirstTimeAccess.value = true;
    } else {
      isFirstTimeAccess.value = false;
    }
  }

  /*
    선택된 날짜의 todoList 업데이트
   */
  Future<void> updateSelectedTodoList() async {
    // 만약 입력 중인 새로운 투두가 있다면 Confirm
    addNewTodoConfirm();

    // 활성 카테고리만 가져오기
    List<dynamic> newScheduledTodoList = List<dynamic>.from(_categoryController
        .categoryList
        .where((element) => element.isActive == true));

    Map<String, List<dynamic>> newScheduledTodoMap = <String, List<dynamic>>{};

    // 카테고리부터 넣기
    for (DateTime dateTime = _todoController.selectedStartDate.value;
        dateTime.isBefore(_todoController.selectedEndDate.value) ||
            dateTime.isAtSameMomentAs(_todoController.selectedEndDate.value);
        dateTime = dateTime.add(const Duration(days: 1))) {
      String date = DateFormat('yyyyMMdd').format(dateTime);
      newScheduledTodoMap[date] = List.from(newScheduledTodoList);
    }

    // 카테고리 indexMap 초기 세팅
    initCategoryIndexMap(newScheduledTodoMap);

    /// todoMap에 저장된 key만큼 반복 생성
    for (DateTime dateTime = _todoController.selectedStartDate.value;
        dateTime.isBefore(_todoController.selectedEndDate.value) ||
            dateTime.isAtSameMomentAs(_todoController.selectedEndDate.value);
        dateTime = dateTime.add(const Duration(days: 1))) {
      String date = DateFormat('yyyyMMdd').format(dateTime);

      if (categoryIndexMap[date] == null) {
        categoryIndexMap[date] = {};
      }

      // matchedRoutineList 구성
      List<RoutineModel> matchedRoutineList = [];
      var routineList = _routineController.routineList;

      for (var routine in routineList) {
        // 0. 루틴이 속한 카테고리가 scheduled 인지 확인
        if (getTodoTypeByCategory(categoryId: routine.categoryId) ==
            TodoType.constant) {
          continue;
        }

        // 1. 루틴이 속한 카테고리가 활성화 되어있는지 확인
        if (categoryIndexMap[date]![routine.categoryId] == null) continue;

        // 2. 루틴 활성화 여부 확인
        if (routine.isActive == false) continue;

        // 3. 해당 날짜와, 루틴의 조건이 일치하는지 확인
        bool matched =
            isMatchToRepeatCondition(dateTime, routine.repeatCondition);
        if (matched == false) continue;

        // 4. 해당 루틴이, 해당 날짜에 이미 todo로 변경되었는지 확인 from pref
        if (isRoutineConverted(dateTime, routine.id)) {
          continue;
        }

        matchedRoutineList.add(routine);
      }

      // selectedDate 와 현재 날짜를 비교하여, 오늘 이라면,
      if (isToday(dateTime)) {
        for (var matchedRoutine in matchedRoutineList) {
          // 조건을 달성한 루틴들을, todo로 변경
          convertRoutineToTodo(date, matchedRoutine);
          // 해당 루틴이, 해당 날짜에 todo로 변경되었음을 pref에 저장
          saveRoutineConverted(dateTime, matchedRoutine.id);
        }
      }

      final constantList = _todoController.todoMap['constant'] ?? [];
      constantList.sort((a, b) => a.pos - b.pos);

      final scheduledList = _todoController.todoMap[date] ?? [];
      scheduledList.sort((a, b) => a.pos - b.pos);

      // Constant 투두 부터 넣기
      for (var todo in constantList) {
        if (categoryIndexMap[date]![todo.categoryId] == null) continue;

        // todo가 추가될 index
        var inx = categoryIndexMap[date]![todo.categoryId]![1];

        // 해당 위치(inx)에 투두 추가
        if (inx >= newScheduledTodoMap[date]!.length) {
          newScheduledTodoMap[date]!.add(todo);
        } else {
          newScheduledTodoMap[date]!.insert(inx, todo);
        }

        updateCategoryIndexMap(date, inx);
        categoryIndexMap[date]![todo.categoryId]?[1]++;
      }

      // Scheduled 투두 넣기
      for (var todo in scheduledList) {
        if (categoryIndexMap[date]![todo.categoryId] == null) continue;

        // todo가 추가될 index
        var inx = categoryIndexMap[date]![todo.categoryId]![1];

        // 해당 위치(inx)에 투두 추가
        if (inx >= newScheduledTodoMap[date]!.length) {
          newScheduledTodoMap[date]!.add(todo);
        } else {
          newScheduledTodoMap[date]!.insert(inx, todo);
        }

        updateCategoryIndexMap(date, inx);
        categoryIndexMap[date]![todo.categoryId]?[1]++;
      }

      // Matched Routine 넣기
      for (var matchedRoutine in matchedRoutineList) {
        if (categoryIndexMap[date]![matchedRoutine.categoryId] == null) {
          continue;
        }

        // routine가 추가될 index
        var inx = categoryIndexMap[date]![matchedRoutine.categoryId]![1];

        // 해당 위치(inx)에 투두 추가
        if (inx >= newScheduledTodoMap[date]!.length) {
          newScheduledTodoMap[date]!.add(matchedRoutine);
        } else {
          newScheduledTodoMap[date]!.insert(inx, matchedRoutine);
        }

        updateCategoryIndexMap(date, inx);
        categoryIndexMap[date]![matchedRoutine.categoryId]?[1]++;
      }
    }

    // 전체 투두 리스트 저장 및 변경
    selectedTodoMap.value = newScheduledTodoMap;
    initCategoryFoldMap();
  }

  void initCategoryFoldMap() {
    if (_categoryController.categoryList.isEmpty) return;

    var key = 'categoryFoldMap';

    final value = getString(key);
    if (value == null) {
      for (var category in _categoryController.categoryList) {
        categoryFoldMap[category.id] = false;
      }
    } else {
      Map<String, dynamic> tempMap = jsonDecode(value);

      Map<String, bool> storedCategoryFoldMap =
          tempMap.map((key, value) => MapEntry(key, value as bool));

      for (var category in _categoryController.categoryList) {
        categoryFoldMap[category.id] =
            storedCategoryFoldMap[category.id] ?? false;
      }
    }

    String categoryFoldMapString = jsonEncode(categoryFoldMap);
    saveString(key, categoryFoldMapString);
  }

  void initCategoryIndexMap(Map<String, List<dynamic>> todoMap) {
    Map<String, Map<String, List<int>>> newCategoryIndexMap = {};

    for (DateTime dateTime = _todoController.selectedStartDate.value;
        dateTime.isBefore(_todoController.selectedEndDate.value) ||
            dateTime.isAtSameMomentAs(_todoController.selectedEndDate.value);
        dateTime = dateTime.add(const Duration(days: 1))) {
      String date = DateFormat('yyyyMMdd').format(dateTime);

      newCategoryIndexMap[date] = {};
      for (int i = 0; i < todoMap[date]!.length; i++) {
        if (todoMap[date]![i] is CategoryModel) {
          newCategoryIndexMap[date]![todoMap[date]![i].id] = [i, i + 1];
        } else {
          newCategoryIndexMap[date]![todoMap[date]![i].categoryId]?[1]++;
        }
      }
    }

    categoryIndexMap = newCategoryIndexMap;
  }

  void updateCategoryIndexMap(String date, int index) {
    Map<String, List<int>> newCategoryIndexMap = {};

    if (categoryIndexMap[date] == null) return;

    for (var key in categoryIndexMap[date]!.keys) {
      if (categoryIndexMap[date]![key] == null) {
        throw Exception('error in updateCategoryIndexMap');
      }

      if (categoryIndexMap[date]![key]![0] >= index) {
        newCategoryIndexMap[key] = [
          categoryIndexMap[date]![key]![0] + 1,
          categoryIndexMap[date]![key]![1] + 1
        ];
      } else {
        newCategoryIndexMap[key] = [
          categoryIndexMap[date]![key]![0],
          categoryIndexMap[date]![key]![1]
        ];
      }
    }

    categoryIndexMap[date] = newCategoryIndexMap;
  }

  /*
    Create Function
   */
  void addNewTodo({required String categoryId}) {
    if (isFirstTimeAccess.value) {
      saveInt('isFirstTimeAccess', 0);
      isFirstTimeAccess.value = false;
    }

    if (isInputMode.value) {
      if (newTodoCategoryId == categoryId) {
        return;
      } else {
        addNewTodoConfirm();
      }
    }
    focusNode.value = FocusNode();
    newTodoCategoryId = categoryId;
    isInputMode.value = true;

    final newTodoPos =
        categoryIndexMap[_todoController.getSelectedTodoKey()]![categoryId]![1];

    var uuid = const Uuid();
    var newTodoId = uuid.v4();
    newTodo = TodoModel(
        id: newTodoId,
        categoryId: categoryId,
        reminderId: null,
        name: '',
        date: _todoController.selectedDate.value,
        priority: 0,
        memo: '',
        isChecked: false,
        checkTime: null,
        pos: newTodoPos);

    Map<String, List<dynamic>> newScheduledTodoMap = Map.from(selectedTodoMap);

    newScheduledTodoMap[_todoController.getSelectedTodoKey()]!
        .insert(newTodoPos, newTodo);

    initCategoryIndexMap(newScheduledTodoMap);
    selectedTodoMap.value = newScheduledTodoMap;
  }

  void addNewTodoConfirm({bool isContinued = false}) {
    if (!isInputMode.value) return;

    if (newTodo == null) return;

    if (textFieldController.text != '') {
      final bool isScheduledTodoType = _categoryController
              .getCategoryById(categoryId: newTodo!.categoryId)
              .type ==
          TodoType.scheduled;
      if (isScheduledTodoType) {
        _todoController.addTodo(
          todo: TodoModel(
              id: newTodo!.id,
              categoryId: newTodo!.categoryId,
              reminderId: null,
              name: textFieldController.text,
              date: newTodo!.date,
              priority: 0,
              memo: '',
              isChecked: false,
              checkTime: null,
              pos: newTodo!.pos),
        );
      } else {
        _todoController.addTodo(
          todo: TodoModel(
              id: newTodo!.id,
              categoryId: newTodo!.categoryId,
              reminderId: null,
              name: textFieldController.text,
              date: null,
              priority: 0,
              memo: '',
              isChecked: false,
              checkTime: null,
              pos: newTodo!.pos),
        );
      }

      textFieldController.clear();
    }

    focusNode.value.unfocus();
    newTodo = null;
    newTodoCategoryId = null;
    isInputMode.value = false;

    updateSelectedTodoList();

    update();
  }

  /*
    Read Function
   */
  Color getColorByCategory({required String categoryId}) {
    CategoryModel category =
        _categoryController.getCategoryById(categoryId: categoryId);

    return _paletteController.getDefaultPalette()[category.color].color;
  }

  DateTime getSelectedDate() {
    return _todoController.selectedDate.value;
  }

  TodoType getTodoTypeByCategory({required String categoryId}) {
    CategoryModel category =
        _categoryController.getCategoryById(categoryId: categoryId);

    return category.type;
  }

  /*
    Update Function
   */
  void onMoveDate() {
    int newInx = calculatePageIndex(_todoController.selectedDate.value);

    log('====================');
    log(pageController.value.hasClients.toString());
    log(isPageChange.toString());
    log('date ${DateFormat('yyyyMMdd').format(_todoController.selectedDate.value)}');
    log('newInx $newInx');
    log('====================');

    if(!isPageChange) {
      if (pageController.value.hasClients) {
        pageController.value.jumpToPage(newInx);
        log("Jump To Page");
      } else {
        pageController.value = PageController(initialPage: newInx);
      }
    } else {
      isPageChange = false;
    }

    mainController.pageIndex.value =
        calculatePageIndex(_todoController.selectedDate.value);
  }

  void onPageChange(DateTime date) {
    isPageChange = true;
    log("PAGE : ${pageController.value.page?.round() ?? 'null'}");
    _todoController.selectedDate.value = date;
    _todoController.focusedDate.value = date;
  }

  void reorderTodoList(String date, int oldIndex, int newIndex) {
    if (newIndex == 0 || oldIndex == newIndex) return;
    if (selectedTodoMap[date] == null) return;
    if (selectedTodoMap[date]![oldIndex] is CategoryModel) return;

    var list = selectedTodoMap[date]!;

    final TodoModel todoItem = list.removeAt(oldIndex);

    String oldCategoryId = todoItem.categoryId;
    String newCategoryId = '';

    // 1. newCategoryId 구하기
    if (oldIndex > newIndex) {
      for (var key in categoryIndexMap[date]!.keys) {
        if (categoryIndexMap[date]![key]![0] < newIndex &&
            categoryIndexMap[date]![key]![1] >= newIndex) {
          newCategoryId = key;
          break;
        }
      }
    } else {
      for (var key in categoryIndexMap[date]!.keys) {
        if (categoryIndexMap[date]![key]![0] <= newIndex &&
            categoryIndexMap[date]![key]![1] > newIndex) {
          newCategoryId = key;
          break;
        }
      }
    }

    final todoType = _categoryController
        .getCategoryById(categoryId: todoItem.categoryId)
        .type;
    final newTodoType =
        _categoryController.getCategoryById(categoryId: newCategoryId).type;

    // 카테고리 id 변경
    todoItem.categoryId = newCategoryId;

    // 타입이 변했다면 date 수정
    if (todoType != newTodoType) {
      if (!todoItem.isChecked) {
        if (newTodoType == TodoType.constant) {
          todoItem.date = null;
        } else {
          todoItem.date = parseDate(date);
        }
      }
    }

    // 리스트 내에서 오더 변경
    var map = selectedTodoMap;
    map[date]!.insert(newIndex, todoItem);
    selectedTodoMap.value = Map.from(map);

    // 카테고리 indexMap 초기화
    initCategoryIndexMap(selectedTodoMap);

    _reorderAndSaveTodoList(date, oldCategoryId, newCategoryId, newIndex);

    update();
  }

  void _reorderAndSaveTodoList(
      String date, String oldCategoryId, String newCategoryId, int newIndex) {
    // 2. oldCategory pos 변경 후 저장
    var first = categoryIndexMap[date]![oldCategoryId]![0];
    var last = categoryIndexMap[date]![oldCategoryId]![1];

    int newPos = 0;
    for (int i = first + 1; i < last; i++) {
      selectedTodoMap[date]![i].pos = newPos;
      newPos++;
    }

    _todoController.updateTodos(
        todoList:
            selectedTodoMap[date]!.sublist(first + 1, last).cast<TodoModel>());

    // newCategory pos 변경 후 저장
    if (newCategoryId != oldCategoryId) {
      first = categoryIndexMap[date]![newCategoryId]![0];
      last = categoryIndexMap[date]![newCategoryId]![1];

      newPos = 0;
      for (int i = first + 1; i < last; i++) {
        selectedTodoMap[date]![i].pos = newPos;
        newPos++;
      }

      _todoController.updateTodos(
          todoList: selectedTodoMap[date]!
              .sublist(first + 1, last)
              .cast<TodoModel>());
    }
  }

  void isCategoryFold(String id) async {
    var key = 'categoryFoldMap';

    categoryFoldMap[id] = !categoryFoldMap[id]!;

    String categoryFoldMapString = jsonEncode(categoryFoldMap);
    saveString(key, categoryFoldMapString);
  }

  void onMoveToday() {
    _peepMiniCalendarController.onMoveToday();
  }

  /*
    특정 날짜에, 특정 루틴이 투두로 변경되었는지 확인하는 함수
    Todo: 만약 과거인 pref가 남아있다면, 제거시켜야 함
  */
  bool isRoutineConverted(DateTime selectedDate, String routineId) {
    String selectedDateString = DateFormat('yyyyMMdd').format(selectedDate);
    String? convertedRoutineListString =
        getString("converted_routine_list_$selectedDateString");

    if (convertedRoutineListString != null) {
      List<String> convertedRoutineList = convertedRoutineListString.split(' ');

      for (String convertedRoutineId in convertedRoutineList) {
        if (routineId == convertedRoutineId) {
          return true;
        }
      }
    }

    return false;
  }

  /*
    해당 루틴이, 해당 날짜에 todo로 변경되었음을 pref에 저장하는 함수
  */
  // Todo 문제점 : 이 정보가 계속 쌓이기만 하고, 지워지는 일이 없음..? 언제 어떻게 지워야 하지?
  void saveRoutineConverted(DateTime selectedDate, String routineId) {
    String selectedDateString = DateFormat('yyyyMMdd').format(selectedDate);
    String? convertedRoutineListString =
        getString("converted_routine_list_$selectedDateString");

    if (convertedRoutineListString != null) {
      saveString("converted_routine_list_$selectedDateString",
          "$convertedRoutineListString $routineId");
    } else {
      saveString("converted_routine_list_$selectedDateString", routineId);
    }
  }

  /*
    routine 을 통해 todo를 생성하는 함수
   */
  void convertRoutineToTodo(String date, RoutineModel routine) {
    var uuid = const Uuid();
    var newTodoId = uuid.v4();

    final newTodoPos = categoryIndexMap[date]![routine.categoryId]![1];

    TodoModel newTodo = TodoModel(
        id: newTodoId,
        categoryId: routine.categoryId,
        reminderId: routine.reminderId,
        name: routine.name,
        date: _todoController.selectedDate.value,
        priority: routine.priority,
        memo: '',
        isChecked: false,
        checkTime: null,
        pos: newTodoPos);

    // Map<String, List<dynamic>> newScheduledTodoList = Map.from(selectedTodoMap);
    // newScheduledTodoList[date]!.insert(newTodoPos, newTodo);
    _todoController.addTodo(todo: newTodo);
  }
}
