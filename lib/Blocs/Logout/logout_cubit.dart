import '../../Repo/user.dart';
import '../../Utils/utils.dart';
import '../App Theme/app_theme_cubit.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(const LogoutState());

  Future<bool> logout(BuildContext context) async {
    emit(state.copyWith(loadingState: LoadingState.loading));
    return await UserService.logout(context).then((value) {
      if (value is Success) {
        Fluttertoast.showToast(msg: "logged out successfully !!");
        Global.storageService.removeUser();
        Navigator.pushReplacementNamed(
          context,
          AppRoutes.login,
        );
        context.read<AppThemeCubit>().onChangeAppTheme(const Color(0xff751b50));
        emit(state.copyWith(
          loadingState: LoadingState.success,
        ));
        return true;
      }
      value as Failure;
      Fluttertoast.showToast(
          msg: value.errorResponse as String? ?? "Unable to get profile");
      emit(state.copyWith(loadingState: LoadingState.error));
      return false;
    });
  }
}