import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import '../../Utils/utils.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit() : super(const AuthenticationState());
  final LocalAuthentication auth = LocalAuthentication();
  List availableBiometrics = [];
  bool isSupportedBiometrcs = false;
  Future<bool> isDeviceSupported(BuildContext context) async {
    isSupportedBiometrcs = await auth.isDeviceSupported().then(
          (bool isSupported) => isSupported,
        );
    return isSupportedBiometrcs;
  }

  Future<void> getAvailableBiometric(BuildContext context) async {
    availableBiometrics = await auth.getAvailableBiometrics();
  }

  String? getBiometricName(BuildContext context) {
    if (availableBiometrics.contains(BiometricType.face)) {
      return "face";
    }
    if (availableBiometrics.contains(BiometricType.fingerprint)) {
      return "fingerprint";
    }
    return null;
  }

  void authenticate(BuildContext context, {bool loginAuth = false}) {
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
        if (loginAuth) {
          return context.read<LoginCubit>().loginUser(context);
        }
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
