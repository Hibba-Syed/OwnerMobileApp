import 'package:iskaanowner/Blocs/Communities/comunities_cubit.dart';
import 'package:iskaanowner/Blocs/Dropdown%20Communities/dropdown_communities_cubit.dart';
import 'package:iskaanowner/Blocs/Ledger%20Types/ledger_types_cubit.dart';
import 'package:iskaanowner/Blocs/Ledger/ledger_cubit.dart';
import 'package:iskaanowner/Blocs/Request%20Filters/request_filters_cubit.dart';

import '../Utils/utils.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> key = GlobalKey();
    return Scaffold(
      body: Stack(
        children: [
          loginHeaderImage(),
          loginUi(context, key),
        ],
      ),
    );
  }

  Widget loginHeaderImage() {
    return Image.asset("assets/login_header.png");
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
                      fontsize: 20,
                    ),
                    textFieldWithText(
                      "Email",
                      hintText: "Enter the email",
                      initialValue: "imhammadahmad94@gmail.com",
                      prefex: const Icon(
                        Icons.email_outlined,
                        color: primaryColor,
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
                      "Password",
                      hintText: "Enter password",
                      initialValue: "hammad123",
                      obsure: state.obsure,
                      prefex: const Icon(
                        Icons.lock_outline,
                        color: primaryColor,
                      ),
                      suffix: IconButton(
                        onPressed: () {
                          loginCubit.onChangeObsure(!state.obsure);
                        },
                        icon: const Icon(
                          Icons.visibility_outlined,
                          color: primaryColor,
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
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () => forgotPasswordUi(context),
                        child: const CustomText(
                          text: "Forgot password?",
                          color: primaryColor,
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
                    )
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
    String text, {
    String hintText = "",
    Widget? prefex,
    Widget? suffix,
    String? initialValue,
    bool obsure = false,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: text,
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(
          height: 10,
        ),
        CustomTextField(
            initialValue: initialValue,
            fillColor: kGrey.shade200,
            prefix: prefex,
            hintText: hintText,
            validator: validator,
            suffix: suffix,
            onChanged: onChanged,
            obsureText: obsure),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  void forgotPasswordUi(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomText(
              text: "Forgot Password?",
              color: primaryColor,
              fontsize: 20,
            ),
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.centerLeft,
              child: CustomText(
                text:
                    "Enter your email address to receive instructions on how to reset your password.",
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const CustomTextField(
              prefix: Icon(
                Icons.email_outlined,
                color: primaryColor,
              ),
              hintText: "Enter Email",
            ),
            const SizedBox(
              height: 10,
            ),
            CustomButton(text: "Send", function: () {})
          ],
        ),
      ),
    );
  }

  void initialCalls(BuildContext context) {
    context.read<CommunitiesCubit>().getCommunities(context);
    context.read<DropdownCommunitiesCubit>().getCommunities(context);

    context.read<RequestsFiltersCubit>().getRequestsFilters(context);
    context.read<LedgerTypesCubit>().getLedgerTypes(context).then((value) =>
        context.read<LedgerCubit>().onChangeLedgerType(context
            .read<LedgerTypesCubit>()
            .state
            .ledgerTypesModel
            ?.record
            ?.ledgers
            ?.first));
  }
}
