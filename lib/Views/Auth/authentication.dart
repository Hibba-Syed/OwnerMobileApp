import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Utils/utils.dart';
import 'package:lottie/lottie.dart';

import '../../Blocs/Logout/logout_cubit.dart';

class AuthenticationPage extends StatelessWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
          title: "Authentication",
          appBar: AppBar(),
          widgets: [
            BlocBuilder<LogoutCubit, LogoutState>(
              builder: (context, state) {
                if (state.loadingState == LoadingState.loading) {
                  return const SizedBox(
                    height: 50,
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return IconButton(
                    onPressed: () async {
                      context.read<LogoutCubit>().logout(context);
                    },
                    icon: Icon(
                      Icons.logout_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ));
              },
            )
          ],
          appBarHeight: 50),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            LottieBuilder.asset(
              "assets/auth.json",
              width: 200,
            ),
            const Gap(20),
            BlocBuilder<AuthenticationCubit, AuthenticationState>(
              builder: (context, state) {
                return CustomButton(
                    buttonColor:
                        context.read<AppThemeCubit>().state.primaryColor,
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
      ),
    );
  }
}
