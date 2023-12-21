/*
    요일 숫자에 대응되는 String 반환하는 함수
 */
String getWeekDayString(int weekDayInt) {
  switch (weekDayInt) {
    case 0:
      return "일";
    case 1:
      return "월";
    case 2:
      return "화";
    case 3:
      return "수";
    case 4:
      return "목";
    case 5:
      return "금";
    case 6:
      return "토";
    default:
      return "";
  }
}

/*
    subRepeatCondition to description
 */
String subRepeatConditionToDescription(String subRepeatCondition) {
  String condition = subRepeatCondition;
  String description = "";

  List<String> subConditions = condition.split('-');

  switch (subConditions[0]) {
    case '0':
      // daily : "0(daily)-1(일 간격)"
      if (subConditions[1] == '1') {
        description = "매일";
      } else {
        description = "${subConditions[1]}일 간격";
      }
      break;

    case '1':
      // weekly : "1(매주)-02(일,화)-1(주 간격)"
      if (subConditions[2] == '1') {
        description = "매주";
      } else {
        description = "${subConditions[2]}주 간격";
      }

      String weekDays = getWeekDayString(int.parse(subConditions[1][0]));
      for (int i = 1; i < subConditions[1].length; i++) {
        weekDays =
            "$weekDays,${getWeekDayString(int.parse(subConditions[1][i]))}";
      }

      description = "$description $weekDays";
      break;

    case '2':
      // monthly : "2(매월)-0(요일로 반복)-1(번째주)-02(일,화)" || "2(매월)-1(상세히 반복)-10(일에)"
      description = "매월";
      // 요일로 반복
      if (subConditions[1] == '0') {
        description = "$description ${subConditions[2]}번째";

        String weekDays = getWeekDayString(int.parse(subConditions[3][0]));
        for (int i = 1; i < subConditions[3].length; i++) {
          weekDays =
              "$weekDays,${getWeekDayString(int.parse(subConditions[3][i]))}";
        }

        description = "$description $weekDays";
      }
      // 상세히 반복
      else {
        description = "$description ${subConditions[2]}일에";
      }
      break;

    case '3':
      // yearly : "3(매년)-12/21(에)"
      description = "매년";
      description = "$description ${subConditions[1]}에";
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