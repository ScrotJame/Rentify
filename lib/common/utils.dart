import 'package:rentify/common/enum/screen_size.dart';

ScreenSize calculateScreenSize(double width) {
  if (width < 600) return ScreenSize.Small;
  if (width < 900) return ScreenSize.Medium;
  return ScreenSize.Large;
}
