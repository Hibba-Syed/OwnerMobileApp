import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../../Utils/utils.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());
  final LocalAuthentication auth = LocalAuthentication();
  Future<bool> isDeviceSupported(BuildContext context) async {
    return await auth.isDeviceSupported().then(
          (bool isSupported) => isSupported,
        );
  }

  void authenticate(BuildContext context) {
    try {
      emit(state.copyWith(isAuthenticating: true));
      auth
          .authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      )
          .then((value) {
        emit(state.copyWith(isAuthenticating: false));
        if (value == true) {
          return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
        }
        Fluttertoast.showToast(msg: "Unable to authenticate");
      });
    } on PlatformException {
      emit(state.copyWith(isAuthenticating: false));
      CoolAlert.show(
          context: context,
          type: CoolAlertType.info,
          text: "Set a password on your phone from settings");
    } catch (e) {
      emit(state.copyWith(isAuthenticating: false));
    }
  }
}
