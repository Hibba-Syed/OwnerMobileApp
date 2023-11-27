import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:iskaanowner/Blocs/Logout/logout_cubit.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Blocs/Companies/companies_cubit.dart';
import '../Models/companies.dart';
import '../Models/profile.dart';
import '../Utils/utils.dart';

class SideDrawerPage extends StatelessWidget {
  const SideDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileModel? profileModel =
        context.read<ProfileCubit>().state.profileModel;
    return Column(
      children: [
        Container(
          width: double.infinity,
          color:
              context.read<AppThemeCubit>().state.primaryColor.withOpacity(0.1),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const UnitsPage().roundedContainer(
                  context,
                  const Icon(
                    Icons.person_outline,
                    size: 25,
                    color: kWhite,
                  ),
                  padding: const EdgeInsets.all(20),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: profileModel?.record?.fullName ?? "Unkown",
                  fontsize: 14,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                    text:
                        "Owner ID : ${profileModel?.record?.ownerNumber ?? " -- "}"),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: CustomButton(
                    text: "Switch Accoount",
                    icon: const Icon(
                      Icons.contacts_outlined,
                      color: kWhite,
                    ),
                    function: () => showDialog(
                      context: context,
                      builder: (context) {
                        String? userList = Global.storageService
                            .getAuthenticationModelString();
                        List<dynamic> users = jsonDecode(userList ?? "[]");
                        return AlertDialog(
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomText(
                                text: "Select a Profile",
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                                fontsize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              const Gap(10),
                              Column(
                                children: List.generate(users.length, (index) {
                                  LoginModel loginModel = loginModelFromJson(
                                      jsonEncode(users[index]));
                                  return Stack(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: kWhite,
                                        ),
                                        child: ListTile(
                                          onTap: () async {
                                            if (users[0] == users[index]) {
                                              Fluttertoast.showToast(
                                                  msg: "Already logged In");
                                              return;
                                            }
                                            Global.storageService
                                                .setAuthenticationModelString(
                                              loginModelFromJson(
                                                  jsonEncode(users[index])),
                                              addItInFront: true,
                                              index: index,
                                            );
                                            // Navigator.pushNamed(
                                            //     context, AppRoutes.splash);
                                            CoolAlert.show(
                                                context: context,
                                                type: CoolAlertType.loading,
                                                lottieAsset:
                                                    "assets/profile.json",
                                                text: "Switching profile ... ");
                                            String? jsonAuthModel = Global
                                                .storageService
                                                .getAuthenticationModelString();
                                            if (jsonAuthModel != null) {
                                              context
                                                  .read<LoginCubit>()
                                                  .onChangeLoginModel(
                                                      loginModelFromJson(
                                                          jsonEncode(jsonDecode(
                                                                  jsonAuthModel)[
                                                              0])));
                                              const LoginPage()
                                                  .initialCalls(context);
                                              await context
                                                  .read<ProfileCubit>()
                                                  .getProfile(context)
                                                  .then((value) {
                                                context
                                                    .read<AuthenticationCubit>()
                                                    .isDeviceSupported(context)
                                                    .then((value) {
                                                  context
                                                      .read<AppThemeCubit>()
                                                      .onChangeAppTheme(const SplashPage()
                                                          .parseHexColor(context
                                                                  .read<
                                                                      ProfileCubit>()
                                                                  .state
                                                                  .profileModel
                                                                  ?.record
                                                                  ?.company
                                                                  ?.themeColor ??
                                                              " 0xff751b50"));
                                                  if (value == true) {
                                                    return Navigator
                                                        .pushReplacementNamed(
                                                            context,
                                                            AppRoutes
                                                                .authorization);
                                                  }
                                                  return Navigator
                                                      .pushReplacementNamed(
                                                          context,
                                                          AppRoutes.dashboard);
                                                });
                                              });
                                            } else {
                                              context
                                                  .read<CompaniesCubit>()
                                                  .getCommunities(context);
                                              Navigator.pushReplacementNamed(
                                                  context, AppRoutes.login);
                                            }
                                          },
                                          leading: Container(
                                              padding: const EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor),
                                              child: const Icon(
                                                Icons.person_outline,
                                                color: kWhite,
                                              )),
                                          title: CustomText(
                                              text:
                                                  loginModel.owner?.fullName ??
                                                      ""),
                                          trailing: index == 0
                                              ? Icon(
                                                  Icons.done,
                                                  color: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor,
                                                )
                                              : const Icon(
                                                  Icons
                                                      .arrow_forward_ios_outlined,
                                                  size: 15,
                                                ),
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: const SplashPage()
                                                .parseHexColor(loginModel.owner
                                                        ?.company?.themeColor ??
                                                    "#751b50"),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: CustomText(
                                            text: loginModel.owner?.company
                                                    ?.shortName ??
                                                "",
                                            color: kWhite,
                                            fontsize: 12,
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }),
                              ),
                              const Gap(10),
                              Divider(
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                              ),
                              const Gap(10),
                              CustomButton(
                                  text: "Add Account",
                                  icon: const Icon(
                                    Icons.add,
                                    color: kWhite,
                                  ),
                                  function: () {
                                    final GlobalKey<FormState> key =
                                        GlobalKey();
                                    final LoginCubit loginCubit =
                                        context.read<LoginCubit>();
                                    showModalBottomSheet(
                                        context: context,
                                        builder: (context) =>
                                            addNewAccount(key, loginCubit));
                                  })
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.profile);
          },
          leading: Icon(
            Icons.person_2_outlined,
            color: context.read<AppThemeCubit>().state.primaryColor,
          ),
          title: const CustomText(
            text: "Profile",
            textAlign: TextAlign.left,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: context.read<AppThemeCubit>().state.primaryColor,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.happinessCenter);
          },
          leading: Icon(
            Icons.emoji_people_outlined,
            color: context.read<AppThemeCubit>().state.primaryColor,
          ),
          title: const CustomText(
            text: "Happiness Center",
            textAlign: TextAlign.left,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: context.read<AppThemeCubit>().state.primaryColor,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.changePassword);
          },
          leading: Icon(
            Icons.password_outlined,
            color: context.read<AppThemeCubit>().state.primaryColor,
          ),
          title: const CustomText(
            text: "Change Password",
            textAlign: TextAlign.left,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: context.read<AppThemeCubit>().state.primaryColor,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<LogoutCubit, LogoutState>(
            builder: (context, state) {
              if (state.loadingState == LoadingState.loading) {
                return const SizedBox(
                  height: 50,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              return CustomButton(
                text: "Logout",
                function: () {
                  context.read<CompaniesCubit>().getCommunities(context);
                  context.read<LogoutCubit>().logout(context);
                },
                icon: const Icon(
                  Icons.logout_outlined,
                  color: kWhite,
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget addNewAccount(GlobalKey<FormState> key, LoginCubit loginCubit) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return SingleChildScrollView(
                child: Form(
                  key: key,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(10),
                      CustomText(
                        text: "Add Account",
                        fontWeight: FontWeight.bold,
                        color: context.read<AppThemeCubit>().state.primaryColor,
                        fontsize: 20,
                      ),
                      const Gap(10),
                      const LoginPage().textFieldWithText(
                        context,
                        "Email",
                        hintText: "Enter the email",
                        prefex: Icon(
                          Icons.email_outlined,
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
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
                      const LoginPage().textFieldWithText(
                        context,
                        "Password",
                        hintText: "Enter password",
                        obscure: state.obsure,
                        prefex: Icon(
                          Icons.lock_outline,
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        suffix: IconButton(
                          onPressed: () {
                            loginCubit.onChangeObsure(!state.obsure);
                          },
                          icon: Icon(
                            Icons.visibility_outlined,
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
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
                      const SizedBox(
                        height: 10,
                      ),
                      BlocBuilder<CompaniesCubit, CompaniesState>(
                        builder: (context, state) {
                          if (state.loadingState == LoadingState.loading) {
                            return const CircularProgressIndicator();
                          }
                          return DropdownMenu<Companies>(
                            initialSelection:
                                state.companiesModel?.companies?.first,
                            expandedInsets: const EdgeInsets.all(0),
                            onSelected: (value) {
                              context.read<LoginCubit>().onChangeCompanyId(
                                  (value?.id ?? 0).toString());
                            },
                            enabled: state.loadingState == LoadingState.loading
                                ? false
                                : true,
                            inputDecorationTheme: InputDecorationTheme(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                ),
                              ),
                            ),
                            trailingIcon: Builder(builder: (context) {
                              if (state.loadingState == LoadingState.loading) {
                                return const SizedBox(
                                  width: 30,
                                  height: 30,
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              }
                              return const Icon(Icons.arrow_drop_down);
                            }),
                            dropdownMenuEntries: state.companiesModel?.companies
                                    ?.map<DropdownMenuEntry<Companies>>(
                                        (Companies value) {
                                  return DropdownMenuEntry<Companies>(
                                      value: value,
                                      label: value.companiesName ?? "");
                                }).toList() ??
                                [],
                          );
                        },
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
