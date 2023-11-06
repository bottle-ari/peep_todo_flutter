import '../../../theme/icons.dart';
import '../enum/menu_state.dart';

class BottomNavigationItem {
  final String iconName;
  final MenuState menuState;
  final String label;

  const BottomNavigationItem({
    required this.iconName,
    required this.menuState,
    required this.label,
  });
}