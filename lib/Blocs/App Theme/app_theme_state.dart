part of 'app_theme_cubit.dart';

class AppThemeState {
  final Color primaryColor;
  const AppThemeState({required this.primaryColor});
  AppThemeState copyWith(Color? primaryColor) {
    return AppThemeState(
      primaryColor: primaryColor ?? this.primaryColor,
    );
  }
}
