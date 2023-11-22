import '../Utils/utils.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    return Scaffold(
      appBar: BaseAppBar(
        title: "Change Password",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formKey,
          child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
            builder: (context, state) {
              return Column(
                children: [
                  const LoginPage().textFieldWithText("Current Password",
                      prefex: const Icon(
                        Icons.lock_outline,
                        color: primaryColor,
                      ),
                      hintText: "Enter Current Password",
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
                              .onChangeOldObsure(!state.oldObscure);
                        },
                        icon: Icon(
                          state.oldObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: primaryColor,
                        ),
                      )),
                  const LoginPage().textFieldWithText("New Password",
                      prefex: const Icon(
                        Icons.lock_outline,
                        color: primaryColor,
                      ),
                      obscure: state.newObscure,
                      hintText: "Enter New Password",
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
                              .onChangeNewObsure(!state.newObscure);
                        },
                        icon: Icon(
                          state.newObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: primaryColor,
                        ),
                      )),
                  const LoginPage().textFieldWithText("Confirm New Password",
                      prefex: const Icon(
                        Icons.lock_outline,
                        color: primaryColor,
                      ),
                      obscure: state.confirmObscure,
                      hintText: "Confirm New Password", validator: (value) {
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
                              .onChangeConfirmObsure(!state.confirmObscure);
                        },
                        icon: Icon(
                          state.confirmObscure
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: primaryColor,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    if (state.loadingState == LoadingState.loading) {
                      return const SizedBox(
                        height: 50,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    return CustomButton(
                        text: "Update Password",
                        function: () {
                          if (formKey.currentState?.validate() ?? false) {
                            context
                                .read<ChangePasswordCubit>()
                                .changePassword(context);
                          }
                        });
                  }),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
