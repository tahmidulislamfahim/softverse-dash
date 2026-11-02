import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Brand palette: deep teal/emerald, deliberately distinct from the POS app's
  // blue so the two companion apps are easy to tell apart at a glance.

  static const Color primary = Color(0xFF0F766E);
  static const Color secondary = Color(0xFFFEC601);

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  static const Color backgroundLight = Color(0xFFF6F7F8);
  static const Color backgroundDark = Color(0xFF121212);

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFA726);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF29B6F6);

  // Auth (login/signup) screens
  static const Color authBackground = Color(0xFF0D9488);
  static const Color authGradientStart = Color(0xFF14B8A6);
  static const Color authGradientEnd = Color(0xFF0F766E);
  static const Color authLink = Color(0xFF0F766E);
  static const Color authTextDark = Color(0xFF2B353D);
  static const Color authFieldDivider = Color(0xFFE2E8F0);

  // Dashboard screen
  static const Color dashboardHeaderGradientStart = Color(0xFF0D9488);
  static const Color dashboardHeaderGradientEnd = Color(0xFF134E4A);
  static const Color dashboardDateBarBg = Color(0xFFCCF2EC);
  static const Color dashboardTextDark = Color(0xFF2B353D);
  // Name kept for compatibility; now the teal brand accent.
  static const Color dashboardAccentBlue = Color(0xFF0F766E);
  static const Color dashboardAxisGrey = Color(0xFF64748B);
  static const Color dashboardCardGradientStart = Color(0xFFFFFFFF);
  static const Color dashboardCardGradientEnd = Color(0xFFE6F6F3);
  static const Color dashboardNavInactive = Color(0xFF8188A2);
  static const Color dashboardCardBorder = Color(0xFFEBEDF3);
  static const Color dashboardRowDivider = Color(0xFFBDBEC4);

  // Inventory tab
  static const Color inventoryChipBg = Color(0xFFF0FBF9);
  static const Color inventoryChipBorder = Color(0xFF0D9488);
  static const Color stockHigh = Color(0xFF169E3B);
  static const Color stockLow = Color(0xFFF7A305);
  static const Color dangerRed = Color(0xFFDA4352);

  static const Color gaugeYellowTrack = Color(0xFFFFF9DA);
  static const Color gaugeYellowStart = Color(0xFFF9DE73);
  static const Color gaugeYellowEnd = Color(0xFFFFA536);

  static const Color gaugeGreenTrack = Color(0xFFE0F0DF);
  static const Color gaugeGreenStart = Color(0xFF47D89E);
  static const Color gaugeGreenEnd = Color(0xFF0DD825);

  static const Color gaugePurpleTrack = Color(0xFFE9E7F9);
  static const Color gaugePurpleStart = Color(0xFF7985FF);
  static const Color gaugePurpleEnd = Color(0xFF4238C9);
}
