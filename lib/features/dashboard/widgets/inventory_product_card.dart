import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../core/common/styles/global_text_style.dart';
import '../../../core/common/widgets/app_network_image.dart';
import '../../../core/utils/constants/colors.dart';
import '../models/inventory_product_model.dart';
import '../controller/dashboard_controller.dart';

/// A single inventory row: product image, name/SKU, and a stock-status
/// badge above the price.
class InventoryProductCard extends StatelessWidget {
  final InventoryProductModel product;
  final VoidCallback? onTap;

  const InventoryProductCard({super.key, required this.product, this.onTap});

  static final _wholeAmount = NumberFormat('#,##0');

  Color get _statusColor {
    if (product.stockCount <= 0) return AppColors.dangerRed;
    if (product.stockCount < 10) return AppColors.stockLow;
    return AppColors.stockHigh;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _statusColor;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.dashboardCardBorder),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: AppNetworkImage(
                url: product.imageUrl,
                width: 60.w,
                height: 60.w,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.dashboardTextDark,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    product.sku,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: getTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: AppColors.dashboardAccentBlue,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 8.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 3.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    '${product.stockCount} In Stock',
                    style: getTextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: statusColor,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                if (product.expirationDate != null) ...[
                  Text(
                    '${product.expirationStatus == "expired" ? "Expired" : "Expires"} ${DateFormat("dd MMM yyyy").format(product.expirationDate!.toLocal())}',
                    style: getTextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: product.expirationStatus == 'expired'
                          ? AppColors.dangerRed
                          : AppColors.stockLow,
                    ),
                  ),
                  SizedBox(height: 4.h),
                ],
                Text(
                  '${Get.find<DashboardController>().currencySymbol}${_wholeAmount.format(product.price)}',
                  style: getTextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    color: AppColors.dashboardAccentBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
