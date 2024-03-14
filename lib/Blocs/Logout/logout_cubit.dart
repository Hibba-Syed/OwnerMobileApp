import '../../Repo/user.dart';
import '../../Utils/utils.dart';
import '../App Theme/app_theme_cubit.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(const LogoutState());

  Future<bool> logout(BuildContext context, {bool shouldPop = false}) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    return await UserService.logout(
      context,
    ).then((value) {
      if (value is Success) {
        if (shouldPop) {
          Navigator.pop(context);
        }
        Fluttertoast.showToast(msg: "logged out successfully !!");
        Global.storageService.removeUser();
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        );
        String? theme = Global.storageService.getAppTheme();
        context.read<AppThemeCubit>().onChangeAppTheme(
            const ProfilePage().parseHexColor(theme ?? "#751b50"));
        emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
        return true;
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to logout user");
      emit(state.copyWith(loadingState: LoadingState.error));
      return false;
    });
  }
}
