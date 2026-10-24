import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/responsive.dart';
import '../controller/dashboard_controller.dart';
import 'inventory_category_tabs.dart';
import 'inventory_product_card.dart';
import 'inventory_stock_filter_chips.dart';

/// The Inventory tab body: stock filter chips, category tabs, the scrollable
/// product list and the floating search/scan action buttons.
class InventoryTabView extends StatelessWidget {
  final DashboardController controller;

  const InventoryTabView({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ResponsiveCenter(
      maxWidth: AppResponsive.maxContentWidth,
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InventoryStockFilterChips(controller: controller),
                SizedBox(height: 16.h),
                InventoryCategoryTabs(controller: controller),
                SizedBox(height: 16.h),
                Expanded(
                  child: Obx(() {
                    final products = controller.filteredInventoryProducts;
                    if (controller.isInventoryLoading.value && products.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (controller.inventoryError.value != null &&
                        products.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: controller.refreshInventory,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(height: 180.h),
                            Center(child: Text(controller.inventoryError.value!)),
                          ],
                        ),
                      );
                    }
                    if (products.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: controller.refreshInventory,
                        child: ListView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(height: 180.h),
                            Center(
                              child: Text(
                                'No items found',
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: controller.refreshInventory,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final crossAxisCount = constraints.maxWidth >= 1000
                              ? 3
                              : (constraints.maxWidth >= 640 ? 2 : 1);

                          if (crossAxisCount > 1) {
                            return GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              padding: EdgeInsets.only(bottom: 140.h),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                mainAxisSpacing: 10.h,
                                crossAxisSpacing: 12.w,
                                mainAxisExtent: 108,
                              ),
                              itemCount: products.length,
                              itemBuilder: (_, i) => InventoryProductCard(
                                product: products[i],
                                onTap: () =>
                                    controller.openInventoryProduct(products[i]),
                              ),
                            );
                          }

                          return ListView.separated(
                            physics: const AlwaysScrollableScrollPhysics(),
                            padding: EdgeInsets.only(bottom: 140.h),
                            itemCount: products.length,
                            separatorBuilder: (_, _) => SizedBox(height: 8.h),
                            itemBuilder: (_, i) => InventoryProductCard(
                              product: products[i],
                              onTap: () =>
                                  controller.openInventoryProduct(products[i]),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16.w,
            bottom: 16.h,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FloatingIconButton(
                  icon: Iconsax.search_normal,
                  backgroundColor: AppColors.inventoryChipBg,
                  iconColor: AppColors.dashboardAccentBlue,
                  tooltip: 'Search inventory',
                  onTap: controller.openInventorySearch,
                ),
                SizedBox(height: 12.h),
                _FloatingIconButton(
                  icon: Iconsax.scan_barcode,
                  backgroundColor: AppColors.dashboardAccentBlue,
                  iconColor: Colors.white,
                  tooltip: 'Scan item barcode',
                  onTap: controller.openInventoryScanner,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FloatingIconButton extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconColor;
  final VoidCallback onTap;
  final String tooltip;

  const _FloatingIconButton({
    required this.icon,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
    required this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: tooltip,
      child: Tooltip(
        message: tooltip,
        child: Material(
          color: backgroundColor,
          shape: const CircleBorder(),
          child: InkWell(
            onTap: onTap,
            customBorder: const CircleBorder(),
            child: SizedBox(
              width: 52.w,
              height: 52.w,
              child: Icon(icon, color: iconColor, size: 22.w),
            ),
          ),
        ),
      ),
    );
  }
}
