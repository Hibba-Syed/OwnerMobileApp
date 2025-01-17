import 'package:iskaanowner/Utils/constants.dart';
import 'package:lottie/lottie.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Blocs/Send OTP/send_otp_cubit.dart';
import '../../Utils/utils.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        body: Center(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const DashboardPage().appBar(
                    context,
                    text: "Forgot Password",
                    enableTrailing: false,
                  ),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: customMaxWidth,
                        minWidth: 0,
                      ),
                      child: Center(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Form(
                              key: _formKey,
                              child: BlocBuilder<SendOtpCubit, SendOtpState>(
                                builder: (context, state) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                        fillColor: kTransparent,
                                        prefix: Icon(
                                          Icons.email_outlined,
                                          color: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                        ),
                                        readOnly: state.loadingState ==
                                                LoadingState.loading
                                            ? true
                                            : false,
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
                                      Builder(
                                        builder: (context) {
                                          if (state.loadingState ==
                                              LoadingState.loading) {
                                            return const SizedBox(
                                                height: 50,
                                                child: CustomLoader());
                                          }
                                          return CustomButton(
                                              text: "Send",
                                              function: () {
                                                if (_formKey.currentState
                                                        ?.validate() ??
                                                    false) {
                                                  context
                                                      .read<SendOtpCubit>()
                                                      .sendOTP(context);
                                                }
                                              });
                                        },
                                      ),
                                      const Gap(20),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
