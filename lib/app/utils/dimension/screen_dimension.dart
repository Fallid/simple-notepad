import 'package:responsive_framework/responsive_framework.dart';

class ScreenDimension {
  static List<Breakpoint> breakpoint = [
    const Breakpoint(start: 0, end: 450, name: MOBILE),
    const Breakpoint(start: 451, end: 800, name: TABLET),
    const Breakpoint(start: 801, end: 1920, name: DESKTOP),
    const Breakpoint(start: 1921, end: double.infinity, name: '4K')
  ];

  static List<Breakpoint> breakpointsLandscape = [
    Breakpoint(start: 0, end: 480, name: MOBILE),
    Breakpoint(start: 481, end: 900, name: TABLET),
    Breakpoint(start: 901, end: 1400, name: DESKTOP),
    Breakpoint(start: 1401, end: double.infinity, name: '4K'),
  ];
}
