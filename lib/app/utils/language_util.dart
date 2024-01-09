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
}
