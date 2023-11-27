import 'dart:convert';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Blocs/Companies/companies_cubit.dart';

import '../Utils/utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(3.seconds, () async {
      String? jsonAuthModel =
          Global.storageService.getAuthenticationModelString();
      if (jsonAuthModel != null) {
        context.read<LoginCubit>().onChangeLoginModel(
            loginModelFromJson(jsonEncode(jsonDecode(jsonAuthModel)[0])));
        const LoginPage().initialCalls(context);
        await context.read<ProfileCubit>().getProfile(context).then((value) {
          context
              .read<AuthenticationCubit>()
              .isDeviceSupported(context)
              .then((value) {
            context.read<AppThemeCubit>().onChangeAppTheme(parseHexColor(context
                    .read<ProfileCubit>()
                    .state
                    .profileModel
                    ?.record
                    ?.company
                    ?.themeColor ??
                " #751b50"));
            if (value == true) {
              return Navigator.pushReplacementNamed(
                  context, AppRoutes.authorization);
            }
            return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          });
        });
      } else {
        context.read<CompaniesCubit>().getCommunities(context);
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

  Color parseHexColor(String hexColor) {
    hexColor = hexColor.replaceAll("#", "");
    int hexValue = int.parse(hexColor, radix: 16);

    return Color(hexValue)
        .withAlpha(0xFF); // Ensure full opacity (alpha value of 0xFF)
  }
}
