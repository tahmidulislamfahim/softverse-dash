import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:softverse_dash/core/models/response_data.dart';
import 'package:softverse_dash/core/services/storage_service.dart';
import 'package:softverse_dash/core/utils/responsive.dart';
import 'package:softverse_dash/features/dashboard/controller/dashboard_controller.dart';
import 'package:softverse_dash/features/dashboard/data/dashboard_repository.dart';
import 'package:softverse_dash/features/dashboard/views/screens/dashboard_screen.dart';
import 'package:softverse_dash/features/dashboard/widgets/dashboard_bottom_nav.dart';
import 'package:softverse_dash/features/dashboard/widgets/debt_tab_view.dart';
import 'package:softverse_dash/features/dashboard/widgets/inventory_tab_view.dart';
import 'package:softverse_dash/features/dashboard/widgets/settings_tab_view.dart';

class _FakeRepo implements DashboardRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => Future.value(ResponseData(
    isSuccess: true,
    statusCode: 200,
    errorMessage: '',
    responseData: {},
  ));

  @override
  Future<ResponseData> fetchStores() async => ResponseData(
    isSuccess: true,
    statusCode: 200,
    errorMessage: '',
    responseData: {'stores': []},
  );

  @override
  Future<ResponseData> fetchOverview(DateTime from, DateTime to, {String? storeId}) async =>
      ResponseData(
        isSuccess: true,
        statusCode: 200,
        errorMessage: '',
        responseData: {
          'cards': {
            'transactionCount': 10,
            'netSales': 1500,
            'averageSale': 150,
          },
          'chart': [
            {'label': '10:00', 'value': 100},
            {'label': '12:00', 'value': 200},
          ],
          'items': [],
          'categories': [],
          'employees': [],
        },
      );

  @override
  Future<ResponseData> fetchTaxes(DateTime from, DateTime to, {String? storeId}) async =>
      ResponseData(
        isSuccess: true,
        statusCode: 200,
        errorMessage: '',
        responseData: {'totals': {'amountTaxed': 0}, 'rows': []},
      );

  @override
  Future<ResponseData> fetchCategories({String? storeId}) async =>
      ResponseData(
        isSuccess: true,
        statusCode: 200,
        errorMessage: '',
        responseData: {'categories': []},
      );

  @override
  Future<ResponseData> fetchInventory({
    String? storeId,
    String? categoryId,
    String? stockStatus,
    String? expirationStatus,
    int? expiringSoonDays,
    String? search,
  }) async =>
      ResponseData(
        isSuccess: true,
        statusCode: 200,
        errorMessage: '',
        responseData: {
          'products': [
            {
              'id': '1',
              'name': 'Sample Product 1',
              'sku': 'SKU-001',
              'stock': 15,
              'price': 120,
              'imageUrl': null,
            },
            {
              'id': '2',
              'name': 'Sample Product 2',
              'sku': 'SKU-002',
              'stock': 4,
              'price': 250,
              'imageUrl': null,
            },
          ],
        },
      );

  @override
  Future<ResponseData> fetchDueInvoices({String? storeId, int limit = 20, int offset = 0}) async =>
      ResponseData(
        isSuccess: true,
        statusCode: 200,
        errorMessage: '',
        responseData: {
          'total': 1,
          'totals': {'dueInvoices': 1, 'amountDue': 500},
          'rows': [
            {
              'id': 'inv-1',
              'customerName': 'John Doe',
              'orderNumber': 'ORD-101',
              'amountDue': 500,
              'amountReceived': 200,
              'totalAmount': 700,
              'date': '2026-10-24T10:00:00Z',
              'storeName': 'Main Branch',
              'employeeName': 'Cashier',
            },
          ],
        },
      );
}

void main() {
  group('DashboardScreen Responsiveness', () {
    late DashboardController controller;

    setUp(() async {
      SharedPreferences.setMockInitialValues({'email': 'test@softverse.com'});
      await StorageService.init();
      Get.reset();
      controller = DashboardController(dashboardRepository: _FakeRepo());
      Get.put(controller);
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
            home: DashboardScreen(),
          ),
        ),
      );
    }

    testWidgets('Dashboard renders in mobile portrait without overflow', (tester) async {
      const size = Size(390, 844);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.byType(DashboardBottomNav), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Dashboard renders in landscape phone without overflow', (tester) async {
      const size = Size(844, 390);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      expect(find.byType(DashboardScreen), findsOneWidget);
      expect(find.byType(DashboardBottomNav), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('Dashboard tabs (Inventory, Debt, Settings) render cleanly on 15.6" POS', (tester) async {
      const size = Size(1920, 1080);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      // Switch to Inventory tab
      controller.selectNavIndex(DashboardController.inventoryTab);
      await tester.pumpAndSettle();
      expect(find.byType(InventoryTabView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Switch to Debt tab
      controller.selectNavIndex(DashboardController.debtTab);
      await tester.pumpAndSettle();
      expect(find.byType(DebtTabView), findsOneWidget);
      expect(tester.takeException(), isNull);

      // Switch to Settings tab
      controller.selectNavIndex(DashboardController.settingsTab);
      await tester.pumpAndSettle();
      expect(find.byType(SettingsTabView), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('InventoryTabView floating buttons are visible and unobstructed', (tester) async {
      const size = Size(844, 390);
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(createTestApp(size));
      await tester.pumpAndSettle();

      controller.selectNavIndex(DashboardController.inventoryTab);
      await tester.pumpAndSettle();

      expect(find.byType(InventoryTabView), findsOneWidget);
      expect(find.byTooltip('Search inventory'), findsOneWidget);
      expect(find.byTooltip('Scan item barcode'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('DashboardBottomNav handles large bottom insets (iPhone home indicator) without overflow', (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      tester.view.padding = const FakeViewPadding(bottom: 34.0);
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
        tester.view.resetPadding();
      });

      await tester.pumpWidget(createTestApp(const Size(390, 844)));
      await tester.pumpAndSettle();

      expect(find.byType(DashboardBottomNav), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  });
}
