import '../../Utils/utils.dart';

part 'app_theme_state.dart';

class AppThemeCubit extends Cubit<AppThemeState> {
  AppThemeCubit() : super(const AppThemeState(primaryColor: Color(0xff751b50)));
  void onChangeAppTheme(Color? primaryColor) {
    emit(state.copyWith(primaryColor));
  }
}
