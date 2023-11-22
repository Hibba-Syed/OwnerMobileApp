import 'package:flutter_animate/flutter_animate.dart';

import '../Utils/utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(3.seconds, () async {
      String? jsonAuthModel =
          Global.storageService.getAuthenticationModelString();
      if (jsonAuthModel != null) {
        context
            .read<LoginCubit>()
            .onChangeLoginModel(loginModelFromJson(jsonAuthModel));
        const LoginPage().initialCalls(context);
        await context.read<ProfileCubit>().getProfile(context).then((value) {
          context
              .read<AuthenticationCubit>()
              .isDeviceSupported(context)
              .then((value) {
            if (value == true) {
              return Navigator.pushReplacementNamed(
                  context, AppRoutes.authorization);
            }
            return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          });
        });
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      }
    });
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login_header.png"),
                  alignment: Alignment.topCenter),
            ),
          ),
          Center(
            child: Image.asset(
              "assets/logo.png",
              width: MediaQuery.of(context).size.height * 0.15,
            )
                .animate()
                .fade(duration: 2.seconds)
                .slideY(begin: 3, end: 0, duration: 2.seconds),
          ),
        ],
      ),
    );
  }
}
