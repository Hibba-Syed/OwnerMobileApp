import 'package:iskaanowner/Blocs/Verify%20Otp/verify_otp_cubit.dart';
import 'package:pinput/pinput.dart';

import '../../Utils/utils.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? email = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "OTP Verification",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: BlocBuilder<VerifyOtpCubit, VerifyOtpState>(
          builder: (context, state) {
            if (state.loadingState == LoadingState.loading) {
              return const SizedBox(
                height: 50,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            return CustomButton(
                text: "Verify",
                function: () {
                  context
                      .read<VerifyOtpCubit>()
                      .verifyOTP(context, email ?? "");
                });
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const CustomText(
                  text: "OTP sent to Mail",
                  fontWeight: FontWeight.bold,
                  fontsize: 20,
                ),
                const Gap(20),
                const CustomText(
                    text:
                        "A Six digit OTP message has been sent to the mail you provided earlier"),
                const Gap(20),
                Pinput(
                  length: 6,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  onChanged: (value) {
                    context.read<VerifyOtpCubit>().onChangeOtp(value);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
