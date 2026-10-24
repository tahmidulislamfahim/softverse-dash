import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../core/common/styles/global_text_style.dart';
import '../../../../core/common/widgets/app_button.dart';
import '../../../../core/utils/constants/colors.dart';
import '../../../../core/utils/responsive.dart';
import '../../controller/auth_controller.dart';
import '../../widgets/login_form_fields.dart';

class LoginScreen extends GetView<AuthController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isWide = AppResponsive.isWide(context);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: isWide ? _buildWideLayout(context) : _buildPortraitLayout(context),
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Container(
            color: AppColors.authBackground,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 320, maxHeight: 260),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Image.asset(
                    'assets/icons/Logo-white.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 6,
          child: Container(
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: AppResponsive.maxFormWidth),
                  child: _buildForm(context),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final headerHeight = (constraints.maxHeight * 0.42).clamp(180.0, 380.0);

        return Column(
          children: [
            Container(
              width: double.infinity,
              color: AppColors.authBackground,
              child: SafeArea(
                bottom: false,
                child: SizedBox(
                  height: headerHeight,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 24.h),
                      child: Image.asset(
                        'assets/icons/Logo-white.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: Center(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 28.h),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: AppResponsive.maxFormWidth),
                      child: _buildForm(context),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildForm(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          LoginFormFields(controller: controller),
          SizedBox(height: 12.h),
          Text(
            'Forgot password',
            style: getTextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.authLink,
            ),
          ),
          SizedBox(height: 32.h),
          Obx(
            () => AppButton(
              label: 'Sign in',
              isLoading: controller.isLoggingIn.value,
              onPressed: controller.login,
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.authGradientStart,
                  AppColors.authGradientEnd,
                ],
              ),
            ),
          ),
          SizedBox(height: 22.h),
          SizedBox(
            width: double.infinity,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: "Don't have account ? ",
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.authTextDark,
                    ),
                  ),
                  TextSpan(
                    text: 'Register Now',
                    style: getTextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.authLink,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
