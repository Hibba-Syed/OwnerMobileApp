import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:iskaanowner/Blocs/Logout/logout_cubit.dart';
import 'package:iskaanowner/Widgets/image_builder.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
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
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kWhite,
                  ),
                  child: ImageBuilder(
                    url: profileModel?.record?.company?.logoUrl ?? "",
                    height: 95,
                    width: 95,
                    isFit: true,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  text: profileModel?.record?.firstName ?? "Unknown",
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
                      function: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            String? userList = Global.storageService
                                .getAuthenticationModelString();
                            List<dynamic> users = jsonDecode(userList ?? "[]");
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Gap(10),
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
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 2,
                                  child: GridView.builder(
                                    padding: const EdgeInsets.all(5),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 10,
                                      crossAxisSpacing: 10,
                                    ),
                                    itemCount: users.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      LoginModel loginModel =
                                          LoginModel.fromJson(users[index]);
                                      return InkWell(
                                        onTap: () async => await onProfileTap(
                                            context, users, index),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.all(
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.05),
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: kWhite),
                                                  child: ImageBuilder(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                    url: loginModel
                                                            .owner
                                                            ?.company
                                                            ?.logoUrl ??
                                                        "",
                                                    isFit: true,
                                                  ),
                                                ),
                                                if (index == 0)
                                                  Positioned(
                                                    right: 0,
                                                    top: 0,
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              5),
                                                      decoration:
                                                          const BoxDecoration(
                                                              shape: BoxShape
                                                                  .circle,
                                                              color:
                                                                  Colors.green),
                                                      child: const Icon(
                                                        Icons.done,
                                                        color: kWhite,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  )
                                              ],
                                            ),
                                            CustomText(
                                              text:
                                                  "${loginModel.owner?.firstName ?? " -- "} ${loginModel.owner?.lastName ?? " -- "} ",
                                              textAlign: TextAlign.center,
                                              maxLines: 2,
                                            ),
                                            CustomText(
                                              text: loginModel
                                                      .owner?.company?.name ??
                                                  "",
                                              fontsize: 12,
                                              color: kGrey,
                                              maxLines: 2,
                                              textAlign: TextAlign.center,
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Divider(
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: CustomButton(
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
                                            isScrollControlled: true,
                                            builder: (context) => addNewAccount(
                                                context, key, loginCubit));
                                      }),
                                )
                              ],
                            );
                          })),
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
            context
                .read<HappinessCenterCubit>()
                .onChangeComplaintType("select");
            context.read<HappinessCenterCubit>().onChangeCommunityId(0);
            context.read<HappinessCenterCubit>().onChangeUnitId(0);
            context.read<HappinessCenterCubit>().onChangeService("");
            context.read<HappinessCenterCubit>().onChangeMessage("");
            context.read<HappinessCenterCubit>().onChangeFiles([]);
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

  Widget addNewAccount(
      BuildContext context, GlobalKey<FormState> key, LoginCubit loginCubit) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              return Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Form(
                          key: key,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Gap(20),
                              CustomText(
                                text: "Add Account",
                                fontWeight: FontWeight.bold,
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                                fontsize: 20,
                              ),
                              const Gap(10),
                              const LoginPage().textFieldWithText(
                                context,
                                "Email",
                                hintText: "Enter the email",
                                prefex: Icon(
                                  Icons.email_outlined,
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
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
                                onChanged: (email) =>
                                    loginCubit.onChangeEmail(email),
                              ),
                              const LoginPage().textFieldWithText(
                                context,
                                "Password",
                                hintText: "Enter password",
                                obscure: state.obsure,
                                prefex: Icon(
                                  Icons.lock_outline,
                                  color: context
                                      .read<AppThemeCubit>()
                                      .state
                                      .primaryColor,
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
                                  if (context.read<LoginCubit>().state.email ==
                                          context
                                              .read<LoginCubit>()
                                              .state
                                              .loginModel
                                              ?.owner
                                              ?.email &&
                                      value ==
                                          Global.storageService
                                              .getLoginCreds()?[1]) {
                                    return "Already logged in with this email";
                                  }
                                  return null;
                                },
                                onChanged: (password) =>
                                    loginCubit.onChangePassword(password),
                              ),
                              const Gap(10),
                              Builder(
                                builder: (context) {
                                  if (state.loadingState ==
                                      LoadingState.loading) {
                                    return const SizedBox(
                                        height: 50,
                                        child: Center(
                                            child:
                                                CircularProgressIndicator()));
                                  }
                                  return CustomButton(
                                      text: "Login",
                                      function: () {
                                        if (key.currentState?.validate() ??
                                            false) {
                                          loginCubit.loginUser(context,
                                              newUser: true);
                                        }
                                      });
                                },
                              ),
                              const Gap(20),
                              Container(
                                margin: const EdgeInsets.all(10),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kGrey.shade200,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const CustomText(
                                      text: "Note : ",
                                      color: kBlack,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text:
                                                "If you see (Already Logged in with this email)",
                                            color: kGrey.shade900,
                                            fontsize: 12,
                                          ),
                                          CustomText(
                                            text:
                                                "This means the email is already used and synced",
                                            fontsize: 12,
                                            color: kGrey.shade700,
                                          ),
                                          const Gap(10),
                                          CustomText(
                                            text:
                                                "Syncing new profiles guide :",
                                            fontsize: 12,
                                            color: kGrey.shade900,
                                          ),
                                          const Gap(10),
                                          CustomText(
                                            text:
                                                "If you want to add new profiles using same credentials. Please logout and login again.",
                                            fontsize: 12,
                                            color: kGrey.shade700,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
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
                          color:
                              context.read<AppThemeCubit>().state.primaryColor,
                        ),
                        textColor:
                            context.read<AppThemeCubit>().state.primaryColor,
                        invert: true,
                        function: () {
                          Navigator.pop(context);
                        }),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> onProfileTap(BuildContext context, List users, int index) async {
    if (users[0] == users[index]) {
      Fluttertoast.showToast(msg: "Already logged In");
      return;
    }
    Global.storageService.setAuthenticationModelString(
      LoginModel.fromJson(users[index]),
      addItInFront: true,
      index: index,
    );
    CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        lottieAsset: "assets/profile.json",
        text: "Switching profile ... ");
    String? jsonAuthModel =
        Global.storageService.getAuthenticationModelString();
    if (jsonAuthModel != null) {
      context
          .read<LoginCubit>()
          .onChangeLoginModel(LoginModel.fromJson(users[index]));
      const LoginPage().initialCalls(context);
      await context.read<ProfileCubit>().getProfile(context).then((value) {
        context
            .read<AuthenticationCubit>()
            .isDeviceSupported(context)
            .then((value) {
          context.read<AppThemeCubit>().onChangeAppTheme(const ProfilePage()
              .parseHexColor(LoginModel.fromJson(users[index])
                      .owner
                      ?.company
                      ?.themeColor ??
                  "#751b50"));
          if (value == true) {
            return Navigator.pushReplacementNamed(
                context, AppRoutes.authorization);
          }
          return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
        });
      });
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }
}
