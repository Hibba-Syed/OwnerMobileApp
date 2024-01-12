import 'package:iskaanowner/Blocs/Companies/companies_cubit.dart';
import 'package:iskaanowner/Blocs/Reset%20Password/reset_password_cubit.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Models/companies.dart';
import '../../Utils/utils.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey();
    String? email = ModalRoute.of(context)?.settings.arguments as String?;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(
                context,
                text: "Reset Password",
                enableTrailing: false,
              ),
            ),
            Expanded(
              child: BlocBuilder<CompaniesCubit, CompaniesState>(
                builder: (context, companiesState) {
                  if (companiesState.loadingState == LoadingState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Form(
                      key: formKey,
                      child:
                          BlocBuilder<ResetPasswordCubit, ResetPasswordState>(
                        builder: (context, state) {
                          return Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kWhite,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: "Company",
                                  color: const Color(0xffB2B1B1),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.032,
                                ),
                                const Gap(10),
                                DropdownMenu<CompaniesRecord>(
                                  hintText: "All Companies",
                                  onSelected: (CompaniesRecord? value) {
                                    context
                                        .read<ResetPasswordCubit>()
                                        .onChangeCompaniesRecord(value);
                                  },
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                          border: UnderlineInputBorder()),
                                  expandedInsets: EdgeInsets.zero,
                                  dropdownMenuEntries: companiesState
                                          .companiesModel?.record
                                          ?.map<
                                                  DropdownMenuEntry<
                                                      CompaniesRecord>>(
                                              (CompaniesRecord value) {
                                        return DropdownMenuEntry<
                                                CompaniesRecord>(
                                            value: value,
                                            label: value.name ?? " -- ");
                                      }).toList() ??
                                      [],
                                ),
                                const Gap(10),
                                const LoginPage().textFieldWithText(
                                    context, "New Password",
                                    prefix: Icon(
                                      Icons.lock_outline,
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor,
                                    ),
                                    obscure: state.newPasswordObscure,
                                    hintText: "Enter New Password",
                                    onChanged: (value) => context
                                        .read<ResetPasswordCubit>()
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
                                            .read<ResetPasswordCubit>()
                                            .onChangeNewPasswordObscure(
                                                !state.newPasswordObscure);
                                      },
                                      icon: Icon(
                                        state.newPasswordObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                      ),
                                    )),
                                const LoginPage().textFieldWithText(
                                    context, "Confirm New Password",
                                    prefix: Icon(
                                      Icons.lock_outline,
                                      color: context
                                          .read<AppThemeCubit>()
                                          .state
                                          .primaryColor,
                                    ),
                                    obscure: state.confirmPasswordObscure,
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
                                            .read<ResetPasswordCubit>()
                                            .onChangeConfirmPasswordObscure(
                                                !state.confirmPasswordObscure);
                                      },
                                      icon: Icon(
                                        state.confirmPasswordObscure
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 20,
                                ),
                                Builder(builder: (context) {
                                  if (state.loadingState ==
                                      LoadingState.loading) {
                                    return const SizedBox(
                                      height: 50,
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }
                                  return CustomButton(
                                      text: "Reset Password",
                                      function: () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          context
                                              .read<ResetPasswordCubit>()
                                              .resetPassword(
                                                  context, email ?? "");
                                        }
                                      });
                                }),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
