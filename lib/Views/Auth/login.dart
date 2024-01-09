import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Blocs/Send%20OTP/send_otp_cubit.dart';
import 'package:iskaanowner/Blocs/Unit%20Financials/unit_financials_cubit.dart';
import 'package:lottie/lottie.dart';

import '../../Notification/firebase_service.dart';
import '../../Notification/local_notification_service.dart';
import '../../Utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey();
    final bool showAppBar =
        ModalRoute.of(context)?.settings.arguments as bool? ?? false;
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: showAppBar
          ? BaseAppBar(
              title: "",
              backgroundColor: kTransparent,
              elevation: null,
              appBar: AppBar(),
              widgets: const [],
              appBarHeight: 50,
              automaticallyImplyLeading: true,
            )
          : null,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          loginHeaderImage(),
          loginUi(context, key),
        ],
      ),
    );
  }

  Widget loginHeaderImage() {
    return Image.asset(
      "assets/login_header.png",
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget loginUi(BuildContext context, GlobalKey<FormState> key) {
    final LoginCubit loginCubit = context.read<LoginCubit>();
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Form(
                key: key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/logo.png",
                      width: MediaQuery.of(context).size.height * 0.15,
                    ),
                    const CustomText(
                      text: "Owner's Login",
                      color: kGrey,
                      fontSize: 20,
                    ),
                    textFieldWithText(
                      context,
                      "Email",
                      hintText: "Enter the email",
                      prefix: Icon(
                        Icons.email_outlined,
                        color: context.read<AppThemeCubit>().state.primaryColor,
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is mandatory";
                        }
                        if (!value.contains("@")) {
                          return "Enter a Valid email";
                        }
                        return null;
                      },
                      onChanged: (email) => loginCubit.onChangeEmail(email),
                    ),
                    textFieldWithText(
                      context,
                      "Password",
                      hintText: "Enter password",
                      obscure: state.obscure,
                      prefix: Icon(
                        Icons.lock_outline,
                        color: context.read<AppThemeCubit>().state.primaryColor,
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          loginCubit.onChangeObscure(!state.obscure);
                        },
                        icon: Icon(
                          Icons.visibility_outlined,
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Field is mandatory";
                        }
                        return null;
                      },
                      onChanged: (password) =>
                          loginCubit.onChangePassword(password),
                    ),
                    if (Global.storageService.getLoginCreds() != null &&
                        context
                            .read<AuthenticationCubit>()
                            .isSupportedBiometrics)
                      Row(
                        children: [
                          const Expanded(child: Divider()),
                          const Gap(10),
                          CustomText(
                            text: "OR",
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                          ),
                          const Gap(10),
                          const Expanded(child: Divider())
                        ],
                      ),
                    if (Global.storageService.getLoginCreds() != null &&
                        context
                            .read<AuthenticationCubit>()
                            .isSupportedBiometrics)
                      const Gap(10),
                    if (Global.storageService.getLoginCreds() != null &&
                        context
                            .read<AuthenticationCubit>()
                            .isSupportedBiometrics)
                      CustomButton(
                          text: "Biometric Login",
                          textColor:
                              context.read<AppThemeCubit>().state.primaryColor,
                          invert: true,
                          icon: Builder(builder: (context) {
                            IconData icon = Icons.security_outlined;
                            if (context
                                    .read<AuthenticationCubit>()
                                    .getBiometricName(context) ==
                                "face") {
                              icon = Icons.face_outlined;
                            }
                            if (context
                                    .read<AuthenticationCubit>()
                                    .getBiometricName(context) ==
                                "fingerprint") {
                              icon = Icons.fingerprint_outlined;
                            }
                            return Icon(
                              icon,
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor,
                            );
                          }),
                          function: () {
                            if (context.read<LoginCubit>().state.loadingState ==
                                LoadingState.loading) {
                              return;
                            }
                            context.read<LoginCubit>().onChangeEmail(
                                Global.storageService.getLoginCreds()?[0]);
                            context.read<LoginCubit>().onChangePassword(
                                Global.storageService.getLoginCreds()?[1]);
                            context
                                .read<AuthenticationCubit>()
                                .authenticate(context, loginAuth: true);
                          }),
                    if (Global.storageService.getLoginCreds() != null &&
                        context
                            .read<AuthenticationCubit>()
                            .isSupportedBiometrics)
                      const Gap(10),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => forgotPasswordUi(context),
                        child: CustomText(
                          text: "Forgot password?",
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Builder(
                      builder: (context) {
                        if (state.loadingState == LoadingState.loading) {
                          return const SizedBox(
                              height: 50,
                              child:
                                  Center(child: CircularProgressIndicator()));
                        }
                        return CustomButton(
                            text: "Login",
                            function: () {
                              if (key.currentState?.validate() ?? false) {
                                loginCubit.loginUser(context);
                              }
                            });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget textFieldWithText(
    BuildContext context,
    String text, {
    String hintText = "",
    Widget? prefix,
    Widget? suffix,
    String? initialValue,
    bool obscure = false,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          color: const Color(0xffB2B1B1),
          fontSize: MediaQuery.of(context).size.width * 0.032,
        ),
        const Gap(10),
        CustomTextField(
            initialValue: initialValue,
            prefix: prefix,
            hintText: hintText,
            validator: validator,
            suffix: suffix,
            onChanged: onChanged,
            obscureText: obscure),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void forgotPasswordUi(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: key,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Gap(50),
                          CustomText(
                            text: "Forgot Password?",
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                            fontSize: 20,
                          ),
                          const Gap(20),
                          LottieBuilder.asset(
                            "assets/forgot.json",
                            repeat: false,
                            width: 200,
                          ),
                          const Gap(20),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: CustomText(
                              text:
                                  "Enter your email address to receive instructions on how to reset your password.",
                              textAlign: TextAlign.left,
                            ),
                          ),
                          const Gap(20),
                          CustomTextField(
                            fillColor: kGrey.shade200,
                            prefix: Icon(
                              Icons.email_outlined,
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor,
                            ),
                            onChanged: (value) => context
                                .read<SendOtpCubit>()
                                .onChangeEmail(value),
                            hintText: "Enter Email",
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Field is empty";
                              }
                              if (!value.contains("@")) {
                                return "Invalid email address";
                              }
                              return null;
                            },
                          ),
                          const Gap(20),
                          BlocBuilder<SendOtpCubit, SendOtpState>(
                            builder: (context, state) {
                              if (state.loadingState == LoadingState.loading) {
                                return const SizedBox(
                                    height: 50,
                                    child: Center(
                                        child: CircularProgressIndicator()));
                              }
                              return CustomButton(
                                  text: "Send",
                                  function: () {
                                    if (key.currentState?.validate() ?? false) {
                                      context
                                          .read<SendOtpCubit>()
                                          .sendOTP(context);
                                    }
                                  });
                            },
                          ),
                          const Gap(20),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: CustomButton(
                    text: "Go back",
                    icon: Icon(
                      Icons.arrow_circle_left_outlined,
                      color: context.read<AppThemeCubit>().state.primaryColor,
                    ),
                    textColor: context.read<AppThemeCubit>().state.primaryColor,
                    invert: true,
                    function: () {
                      Navigator.pop(context);
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  void initialCalls(BuildContext context) {
    LocalNotificationService(context).initialize();
    FirebaseNotificationService().handleTokenStatus(context,
        context.read<LoginCubit>().state.loginModel?.accessToken ?? "");
    FirebaseNotificationService().makeFirebaseTokenRequest(context,
        context.read<LoginCubit>().state.loginModel?.accessToken ?? "");
    FirebaseNotificationService().handleOnTapBackground(context);
    FirebaseNotificationService().handleOnMessage();
    FirebaseNotificationService().handleAppOpened(context);
    context.read<CommunitiesCubit>().getCommunities(context);
    context.read<DropdownCommunitiesCubit>().getCommunities(context);
    context.read<RequestsFiltersCubit>().getRequestsFilters(context);
    context.read<NotificationsCubit>().getNotifications(context);
    context.read<LedgerTypesCubit>().getLedgerTypes(context);
    context.read<UnitFinancialsCubit>().getUnitFinancials(context);
    context.read<LedgerCubit>().onChangeLedgerType(context
        .read<LedgerTypesCubit>()
        .state
        .ledgerTypesModel
        ?.record
        ?.ledgers
        ?.first);
  }
}
