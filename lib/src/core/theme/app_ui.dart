import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:smooth_sheets/smooth_sheets.dart';

class AppHelpers {
  static double deviceScaleFac = 1;
  static double referenceDevicePixelRatio = 0;

  static const double borderRadiusValue = 10;
  static const BorderRadius borderRadius = BorderRadius.all(Radius.circular(borderRadiusValue));

  static const Duration animationDuration = Duration(milliseconds: 160);
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  static double smallPhoneHeight = 700;

  static Size deviceSize = Size.zero;
  static double devicePixelRatio = 0;
  static MediaQueryData deviceMediaData = const MediaQueryData();
  static EdgeInsets deviceSafeArea = EdgeInsets.zero;
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  static double textScaleFactor = 1;

  static double iconSize = 24;
  static double iconSizeSmall = 19;
  static double iconSizeLarge = 60;

  static double padding = 20;
  static double smallPadding = padding * 0.4;
  static EdgeInsets pageInsetsLTRB = EdgeInsets.fromLTRB(padding, padding, padding, padding);
  static EdgeInsets pageInsetsLTR = EdgeInsets.fromLTRB(padding, padding, padding, 0);
  static EdgeInsets pageInsetsLR = EdgeInsets.symmetric(horizontal: padding);
  static EdgeInsets pageInsetsLRB = EdgeInsets.fromLTRB(padding, 0, padding, padding);
  static EdgeInsets topPadding = EdgeInsets.only(top: padding);
  static EdgeInsets bottomPadding = EdgeInsets.only(bottom: padding);
  static EdgeInsets rightPadding = EdgeInsets.only(right: padding);
  static EdgeInsets leftPadding = EdgeInsets.only(left: padding);
  static EdgeInsets smallBottomPadding = EdgeInsets.only(bottom: smallPadding);
  static EdgeInsets smallRightPadding = EdgeInsets.only(right: padding * 0.2);
  static EdgeInsets smallLeftPadding = EdgeInsets.only(left: padding * 0.2);
  static EdgeInsets smallTopPadding = EdgeInsets.only(top: smallPadding);
  static EdgeInsets verticalPadding = EdgeInsets.symmetric(vertical: padding);
  static EdgeInsets smallVerticalPadding = EdgeInsets.symmetric(vertical: smallPadding);
  static EdgeInsets horizontalPadding = EdgeInsets.symmetric(horizontal: padding);

  static double widthWithoutPadding = screenWidth - (padding * 2) - (25 * 2);

  static const String fontFamily = 'Roboto';
  static const String fontFamilyPackageName = 'powerjames_ui_elements';
  static const String euroPlateFontFamily = 'EuroPlate';
  static const TextOverflow textOverflow = TextOverflow.ellipsis;

  static const double opacity = 0.15;

  //static String languageCode = Intl.shortLocale(Platform.localeName);
  static String timeZone = DateTime.now().timeZoneName;

  static String dateFormatDDMMYYY = 'dd.MM.yyyy';
  static String dateFormatTimeAndDate = 'HH:mm, dd.MM.yyyy';

  // static String dayLabel(int index) => DateFormat.E(Platform.localeName).dateSymbols.WEEKDAYS[index];

  // static Future<bool> init(BuildContext context) async {
  //   final mediaData = MediaQuery.of(context);
  //   deviceMediaData = mediaData;
  //   deviceSize = mediaData.size;
  //   devicePixelRatio = mediaData.devicePixelRatio;
  //   deviceSafeArea = mediaData.padding;
  //   blockSizeHorizontal = screenWidth / 100;
  //   blockSizeVertical = screenHeight / 100;
  //   screenWidth = deviceSize.width;
  //   screenHeight = deviceSize.height;
  //   textScaleFactor = mediaData.textScaleFactor.clamp(1.0, 1.8);

  //   print("deviceSize: $deviceSize");
  //   print("deviceSafeArea: $deviceSafeArea");

  //   final days = DateFormat().dateSymbols.WEEKDAYS.sublist(1);
  //   days.add(DateFormat().dateSymbols.WEEKDAYS[0]);

  //   return deviceSize.width != 0;
  // }

  static void showOverlay(BuildContext context, OverlayEntry overlayEntry) {
    OverlayState? overlayState = Overlay.of(context);
    overlayState.insert(overlayEntry);
  }

  static void unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  static void showSubPage(BuildContext context, Widget widget) {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => widget,
      ),
    );
  }

  static Future<void> showBottomSheet(
    BuildContext context, {
    //required Widget Function(BuildContext context, Widget? child) builder,
    required Widget child,
    List<Widget>? bottomWidgets,
    Color? backgroundColor,
    bool isFullScreen = false,
    bool isDismissible = true,
    bool bounce = false,
    bool enableDrag = true,
  }) async {
    // Use ModalSheetRoute to show a modal sheet with imperative Navigator API.
    // It works with any *Sheet provided by this package!
    final modalRoute = CupertinoModalSheetRoute(
      // Enable the swipe-to-dismiss behavior.
      swipeDismissible: enableDrag && isDismissible,
      // Use `SwipeDismissSensitivity` to tweak the sensitivity of the swipe-to-dismiss behavior.
      swipeDismissSensitivity: const SwipeDismissSensitivity(
        minFlingVelocityRatio: 2.0,
        dismissalOffset: SheetOffset.proportionalToViewport(0.4),
      ),
      builder: (context) => child,
    );

    Navigator.push(context, modalRoute);
  }

  static void closeModalPage(BuildContext context) {
    final rootContext = context.findRootAncestorStateOfType<NavigatorState>()?.context ?? context;
    Navigator.of(rootContext, rootNavigator: true).pop();
  }

  static NavigatorState getRootNavigator(BuildContext context) {
    final rootContext = context.findRootAncestorStateOfType<NavigatorState>()?.context ?? context;
    return Navigator.of(rootContext);
  }

  // static void setSystemUIOverlayStyle() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     systemNavigationBarColor: Palette.colors.standardBackground, // Navigation bar color
  //     systemNavigationBarIconBrightness: Palette.colors.paletteType == Brightness.dark ? Brightness.light : Brightness.dark, // Navigation bar icon brightness
  //   ));
  // }
}
