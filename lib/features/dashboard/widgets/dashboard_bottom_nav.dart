import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../core/common/styles/global_text_style.dart';
import '../../../core/utils/constants/colors.dart';
import '../../../core/utils/responsive.dart';
import '../controller/dashboard_controller.dart';

class DashboardBottomNav extends StatelessWidget {
  final DashboardController controller;

  const DashboardBottomNav({super.key, required this.controller});

  static const _tabs = [
    (icon: Iconsax.chart_2, label: 'Sales'),
    (icon: Iconsax.hierarchy_square, label: 'Inventory'),
    (icon: Iconsax.money_time, label: 'Debt'),
    (icon: Iconsax.setting_2, label: 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final isCompact = AppResponsive.isLandscape(context) &&
        MediaQuery.sizeOf(context).height < 600;
    final navHeight = isCompact ? 54.0 : 76.0;
    final iconSize = isCompact ? 20.0 : 24.0;
    final fontSize = isCompact ? 11.0 : 13.0;
    final gap = isCompact ? 2.0 : 4.0;
    final bottomPadding = MediaQuery.paddingOf(context).bottom;

    return Obx(
      () => Container(
        height: navHeight + bottomPadding,
        padding: EdgeInsets.only(bottom: bottomPadding),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(color: AppColors.authFieldDivider),
          ),
        ),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: SizedBox(
              height: navHeight,
              child: Row(
                children: [
                  for (int i = 0; i < _tabs.length; i++)
                    Expanded(
                      child: InkWell(
                        onTap: () => controller.selectNavIndex(i),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _tabs[i].icon,
                              size: iconSize,
                              color: controller.selectedNavIndex.value == i
                                  ? AppColors.dashboardAccentBlue
                                  : AppColors.dashboardNavInactive,
                            ),
                            SizedBox(height: gap),
                            Text(
                              _tabs[i].label,
                              style: getTextStyle(
                                fontSize: fontSize,
                                fontWeight: controller.selectedNavIndex.value == i
                                    ? FontWeight.w500
                                    : FontWeight.w400,
                                color: controller.selectedNavIndex.value == i
                                    ? AppColors.dashboardAccentBlue
                                    : AppColors.dashboardNavInactive,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
