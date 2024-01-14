class LanguageUtil {
  static String getPaletteName(String name) {
    switch (name) {
      case 'sweet_spring_day':
        return '달콤한 봄날';
      case 'city_light':
        return '도시의 빛';
      case 'summer_ocean':
        return '여름 바다';
      default:
        return '';
    }
  }

  static String getDayName(String day) {
    switch (day.toLowerCase()) {
      case 'monday':
        return '월요일';
      case 'tuesday':
        return '화요일';
      case 'wednesday':
        return '수요일';
      case 'thursday':
        return '목요일';
      case 'friday':
        return '금요일';
      case 'saturday':
        return '토요일';
      case 'sunday':
        return '일요일';
      default:
        return '월요일';
    }
  }
}
