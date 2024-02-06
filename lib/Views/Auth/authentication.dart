import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Utils/utils.dart';
import 'package:lottie/lottie.dart';

import '../../Blocs/Logout/logout_cubit.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  @override
  void initState() {
    context.read<AuthenticationCubit>().authenticate(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                onTap: () {},
                enableLeading: false,
                text: "Authentication",
                trailingIcon: BlocBuilder<LogoutCubit, LogoutState>(
                  builder: (context, state) {
                    if (state.loadingState == LoadingState.loading) {
                      return const SizedBox(
                        height: 50,
                        child: CustomLoader(),
                      );
                    }
                    return IconButton(
                      onPressed: () async {
                        context.read<LogoutCubit>().logout(context);
                      },
                      icon: Icon(
                        Icons.logout_outlined,
                        color: context
                            .read<AppThemeCubit>()
                            .state
                            .primaryColor
                            .withOpacity(0.8),
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: Center(
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
                            buttonColor: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor
                                .withOpacity(0.8),
                            textColor: kWhite,
                            text: state.isAuthenticating
                                ? "Authenticating"
                                : "Authenticate",
                            width: MediaQuery.of(context).size.width / 2,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            function: () {
                              context
                                  .read<AuthenticationCubit>()
                                  .authenticate(context);
                            });
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
