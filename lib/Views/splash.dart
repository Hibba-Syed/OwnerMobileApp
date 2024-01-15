import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';

import '../Utils/utils.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthenticationCubit>().isDeviceSupported(context);
    context.read<AuthenticationCubit>().getAvailableBiometric(context);

    String? jsonAuthModel =
        Global.storageService.getAuthenticationModelString();
    if (jsonAuthModel != null) {
      context.read<LoginCubit>().onChangeLoginModel(
          LoginModel.fromJson(jsonDecode(jsonAuthModel)[0]));
       LoginPage().initialCalls(context);
      context.read<ProfileCubit>().getProfile(context).then((value) {
        context
            .read<AuthenticationCubit>()
            .isDeviceSupported(context)
            .then((value) {
          context.read<AppThemeCubit>().onChangeAppTheme(const ProfilePage()
              .parseHexColor(context
                      .read<ProfileCubit>()
                      .state
                      .profileModel
                      ?.record
                      ?.company
                      ?.themeColor ??
                  "#751b50"));
          Future.delayed(3.seconds, () {
            if (value == true) {
              return Navigator.pushReplacementNamed(
                  context, AppRoutes.authorization);
            }
            return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          });
        });
      });
    } else {
      Future.delayed(4.seconds, () {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity, 
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/login_header.png"),
                  fit: BoxFit.cover, 
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
