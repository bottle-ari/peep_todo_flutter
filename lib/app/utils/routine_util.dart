import 'package:table_calendar/table_calendar.dart';

/*
    요일 숫자에 대응되는 String 반환하는 함수
 */

String getWeekDayString(int weekDayInt) {
  switch (weekDayInt) {
    case 0:
      return "월";
    case 1:
      return "화";
    case 2:
      return "수";
    case 3:
      return "목";
    case 4:
      return "금";
    case 5:
      return "토";
    case 6:
      return "일";
    default:
      return "";
  }
}

/*
    subRepeatCondition to description
 */
String subRepeatConditionToDescription(String subRepeatCondition) {
  String description = "";

  List<String> splitSubConditions = subRepeatCondition.split('-');

  switch (splitSubConditions[0]) {
    case '0':
      // daily : "0(daily)-1(일 간격)"
      if (splitSubConditions[1] == '1') {
        description = "매일";
      } else {
        description = "${splitSubConditions[1]}일 간격";
      }
      break;

    case '1':
      // weekly : "1(매주)-02(일,화)-1(주 간격)"
      if (splitSubConditions[2] == '1') {
        description = "매주";
      } else {
        description = "${splitSubConditions[2]}주 간격";
      }

      String weekDays = getWeekDayString(int.parse(splitSubConditions[1][0]));
      for (int i = 1; i < splitSubConditions[1].length; i++) {
        weekDays =
            "$weekDays,${getWeekDayString(int.parse(splitSubConditions[1][i]))}";
      }

      description = "$description $weekDays";
      break;

    case '2':
      // monthly : "2(매월)-0(요일로 반복)-1(번째주)-02(일,화)" || "2(매월)-1(상세히 반복)-10(일에)"
      description = "매월";
      // 요일로 반복
      if (splitSubConditions[1] == '0') {
        description = "$description ${splitSubConditions[2]}번째";

        String weekDays = getWeekDayString(int.parse(splitSubConditions[3][0]));
        for (int i = 1; i < splitSubConditions[3].length; i++) {
          weekDays =
              "$weekDays,${getWeekDayString(int.parse(splitSubConditions[3][i]))}";
        }

        description = "$description $weekDays";
      }
      // 상세히 반복
      else {
        description = "$description ${splitSubConditions[2]}일에";
      }
      break;

    case '3':
      // yearly : "3(매년)-12/21(에)"
      description = "매년";
      description = "$description ${splitSubConditions[1]}에";
      break;

    default:
      break;
  }

  return description;
}

/*
    repeatCondition to description
 */
String repeatConditionToDescription(String repeatCondition){
  String subRepeatCondition = repeatCondition.split(' ')[0];
  return subRepeatConditionToDescription(subRepeatCondition);
}

/*
    repeatCondition 과 특정 날짜가 주어질 때,
    해당 날짜가 해당 repeatCondition 에 일치하는 날짜인지 확인하는 함수
 */
bool isMatchToRepeatCondition(DateTime specificDate, String repeatCondition) {
  List<String> splitConditions =  repeatCondition.split(' ');

  String subRepeatCondition = splitConditions[0];
  DateTime startDate = convertToDateTime(splitConditions[1]);

  // endDate가 존재하면, specificDate와 비교
  if(splitConditions[2].isNotEmpty){
    DateTime endDate = convertToDateTime(splitConditions[2]);
    // specificDate 가 endDate 이후라면 false
    if(specificDate.isAfter(endDate)){
      return false;
    }
  }

  // subRepeatCondition 과의 비교
  List<String> splitSubConditions = subRepeatCondition.split('-');

  switch (splitSubConditions[0]) {
    case '0':
    // daily : "0(daily)-1(일 간격)"
      DateTime routineDate = startDate;
      int dayInterval = int.parse(splitSubConditions[1]);

      while(routineDate.isBefore(specificDate)){
        if(isSameDay(routineDate, specificDate)){
          return true;
        }
        routineDate = routineDate.add(Duration(days: dayInterval));
      }
      break;

    case '1':
    // weekly : "1(매주)-02(일,화)-1(주 간격)"
      List<DateTime> routineDateList = [];
      int weekInterval = int.parse(splitSubConditions[2]);

      for (int i = 0; i < splitSubConditions[1].length; i++) {
        int weekDayValue = int.parse(splitSubConditions[1][i]) + 1;
        int duration = weekDayValue - (startDate.weekday);
        routineDateList.add(startDate.add(Duration(days: duration)));
      }

      while(routineDateList[0].isBefore(specificDate)){
        for(int i=0;i<routineDateList.length;i++){
          if(isSameDay(routineDateList[i], specificDate)){
            return true;
          }
        }

        for(int i=0;i<routineDateList.length;i++){
          routineDateList[i] = routineDateList[i].add(Duration(days: 7*weekInterval));
        }
      }
      break;

    case '2':
    // monthly : "2(매월)-0(요일로 반복)-1(번째주)-02(일,화)" || "2(매월)-1(상세히 반복)-10(일에)"

      // 요일로 반복
      if (splitSubConditions[1] == '0') {
        int xWeek = int.parse(splitSubConditions[2]);

        for (int i = 0; i < splitSubConditions[3].length; i++) {
          int yWeekday = int.parse(splitSubConditions[3][i]) + 1;

          if(isSpecificDateInWeekday(xWeek, yWeekday, specificDate)){
            return true;
          }
        }
      }
      // 상세히 반복
      else {
        int repeatDay = int.parse(splitSubConditions[2]);

        if(specificDate.day == repeatDay){
          return true;
        }
      }
      break;

    case '3':
    // yearly : "3(매년)-12/21(에)"
      List<String> parts = splitSubConditions[1].split('/');
      int repeatMonth = int.parse(parts[0]);
      int repeatDay = int.parse(parts[1]);
      if(specificDate.month == repeatMonth && specificDate.day == repeatDay){
        return true;
      }
      break;

    default:
      break;
  }

  return false;
}

/*
    특정 날짜가 x번째 주, y요일에 해당하는지 확인하는 함수
 */
bool isSpecificDateInWeekday(int xWeek, int yWeekday, DateTime specificDate) {
  // Ensure xWeek is a valid week number (1 to 5)
  if (xWeek < 1 || xWeek > 5) {
    throw ArgumentError('Invalid week number. Should be between 1 and 5.');
  }

  // Ensure yWeekday is a valid weekday number (1 to 7, where 1 is Monday and 7 is Sunday)
  if (yWeekday < 1 || yWeekday > 7) {
    throw ArgumentError('Invalid weekday number. Should be between 1 and 7.');
  }

  // Check if the specificDate matches the criteria
  return specificDate.weekday == yWeekday &&
      (specificDate.day - 1) ~/ 7 + 1 == xWeek;
}


/*
    "yyyy/mm/dd" 형식의 문자열을 DateTime으로 변환
 */
DateTime convertToDateTime(String dateString){
  List<String> parts = dateString.split('/');
  int year = int.parse(parts[0]);
  int month = int.parse(parts[1]);
  int day = int.parse(parts[2]);
  return DateTime(year, month, day);
}