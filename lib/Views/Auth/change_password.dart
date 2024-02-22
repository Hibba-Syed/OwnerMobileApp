import 'package:flutter_animate/flutter_animate.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const DashboardPage().appBar(
                  context,
                  text: "Change Password",
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child:
                          BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: kWhite,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                LoginPage().textFieldWithText(
                                    context, "Current Password",
                                    hintText: "Enter Current Password",
                                    readOnly: state.loadingState ==
                                            LoadingState.loading
                                        ? true
                                        : false,
                                    onChanged: (value) => context
                                        .read<ChangePasswordCubit>()
                                        .onChangeOldPassword(value),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Field is Mandatory";
                                      }
                                      return null;
                                    },
                                    obscure: state.oldObscure,
                                    suffix: IconButton(
                                      onPressed: () {
                                        context
                                            .read<ChangePasswordCubit>()
                                            .onChangeOldObscure(
                                                !state.oldObscure);
                                      },
                                      icon: Icon(
                                        state.oldObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(0.8),
                                      ),
                                    )),
                                LoginPage().textFieldWithText(
                                    context, "New Password",
                                    obscure: state.newObscure,
                                    hintText: "Enter New Password",
                                    readOnly: state.loadingState ==
                                            LoadingState.loading
                                        ? true
                                        : false,
                                    onChanged: (value) => context
                                        .read<ChangePasswordCubit>()
                                        .onChangeNewPassword(value),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Field is Mandatory";
                                      }
                                      if (value.length < 6) {
                                        return "Password must be at least 6 characters";
                                      }
                                      return null;
                                    },
                                    suffix: IconButton(
                                      onPressed: () {
                                        context
                                            .read<ChangePasswordCubit>()
                                            .onChangeNewObscure(
                                                !state.newObscure);
                                      },
                                      icon: Icon(
                                        state.newObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(0.8),
                                      ),
                                    )),
                                LoginPage().textFieldWithText(
                                    context, "Confirm New Password",
                                    obscure: state.confirmObscure,
                                    readOnly: state.loadingState ==
                                            LoadingState.loading
                                        ? true
                                        : false,
                                    hintText: "Confirm New Password",
                                    validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Field is Mandatory";
                                  }
                                  if (value != state.newPassword) {
                                    return "Passwords don't match";
                                  }
                                  return null;
                                },
                                    suffix: IconButton(
                                      onPressed: () {
                                        context
                                            .read<ChangePasswordCubit>()
                                            .onChangeConfirmObscure(
                                                !state.confirmObscure);
                                      },
                                      icon: Icon(
                                        state.confirmObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor
                                            .withOpacity(0.8),
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Builder(
                                  builder: (context) {
                                    if (state.loadingState ==
                                        LoadingState.loading) {
                                      return const SizedBox(
                                          height: 50, child: CustomLoader());
                                    }
                                    return CustomButton(
                                      text: "Update Password",
                                      buttonColor: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor
                                          .withOpacity(0.8),
                                      function: () {
                                        if (_formKey.currentState?.validate() ??
                                            false) {
                                          context
                                              .read<ChangePasswordCubit>()
                                              .changePassword(context);
                                        }
                                      },
                                    );
                                  },
                                ),
                              ].animate(interval: 100.ms).fade(),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
