import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Utils/utils.dart';
import 'package:lottie/lottie.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Authentication",
          appBar: AppBar(),
          widgets: [
            IconButton(
                onPressed: () async {
                  Global.storageService.removeUser().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, AppRoutes.login, (route) => false));
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: context.read<AppThemeCubit>().state.primaryColor,
                ))
          ],
          appBarHeight: 50),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LottieBuilder.asset(
            "assets/auth.json",
          ),
          BlocBuilder<AuthenticationCubit, AuthenticationState>(
            builder: (context, state) {
              return CustomButton(
                  buttonColor: context.read<AppThemeCubit>().state.primaryColor,
                  textColor: kWhite,
                  text: state.isAuthenticating
                      ? "Authenticating"
                      : "Authenticate",
                  width: MediaQuery.of(context).size.width / 2,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  function: () {
                    context.read<AuthenticationCubit>().authenticate(context);
                  });
            },
          )
        ],
      ),
    );
  }
}
