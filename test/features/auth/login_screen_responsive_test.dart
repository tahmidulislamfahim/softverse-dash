import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:softverse_dash/core/utils/responsive.dart';
import 'package:softverse_dash/features/auth/controller/auth_controller.dart';
import 'package:softverse_dash/features/auth/views/screens/login_screen.dart';

void main() {
  group('LoginScreen Responsiveness', () {
    setUp(() {
      Get.reset();
      Get.put(AuthController());
    });

    tearDown(() {
      Get.reset();
    });

    Widget createTestApp(Size size) {
      return MediaQuery(
        data: MediaQueryData(size: size),
        child: ScreenUtilInit(
          designSize: AppResponsive.getDesignSize(size),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => const GetMaterialApp(
            home: LoginScreen(),
          ),
        ),
      );
    }

    testWidgets('renders cleanly in mobile portrait without overflow', (tester) async {
      const size = Size(390, 844);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders side-by-side in landscape phone without overflow', (tester) async {
      const size = Size(844, 390);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders cleanly on unfolded foldable (780x808)', (tester) async {
      const size = Size(780, 808);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('renders cleanly on 15.6" POS terminal (1920x1080)', (tester) async {
      const size = Size(1920, 1080);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text('Sign in'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
