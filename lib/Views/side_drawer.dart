import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Repo/user.dart';
import 'package:slideable/slideable.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/profile.dart';
import '../Utils/utils.dart';
import '../Widgets/notification_badge.dart';

class SideDrawerPage extends StatelessWidget {
  const SideDrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileModel? profileModel =
        context.read<ProfileCubit>().state.profileModel;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: kBackgroundColor,
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Hero(
                    tag: "company-logo",
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: CircleAvatar(
                        radius: MediaQuery.of(context).size.width * 0.15,
                        backgroundColor: kWhite,
                        child: CircleAvatar(
                          backgroundColor: kWhite,
                          radius: MediaQuery.of(context).size.width * 0.13,
                          backgroundImage: NetworkImage(
                              profileModel?.record?.company?.faviconUrl ?? ""),
                          onBackgroundImageError: (exception, stackTrace) =>
                              const AssetImage("assets/placeHolder.png"),
                        ),
                      ),
                    ),
                  ),
                  const Gap(10),
                  CustomText(
                    text: "${profileModel?.record?.fullName ?? ""} ",
                    fontWeight: FontWeight.bold,
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                  ),
                  CustomText(
                    text:
                        "Owner ID : ${profileModel?.record?.ownerNumber ?? " -- "}",
                    color: context.read<AppThemeCubit>().state.primaryColor,
                    fontSize: MediaQuery.of(context).size.width * 0.035,
                  ),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        child: CustomButton(
                          text: "Switch Account",
                          invert: true,
                          icon: Image.asset(
                            "assets/switch_account.png",
                            width: MediaQuery.of(context).size.width * 0.06,
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor
                                .withOpacity(0.8),
                          ),
                          textColor: context
                              .read<AppThemeCubit>()
                              .state
                              .primaryColor
                              .withOpacity(0.8),
                          function: () => showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (context) {
                              return selectProfile(context);
                            },
                          ),
                        ),
                      ),
                      Builder(builder: (context) {
                        String? userList = Global.storageService
                            .getAuthenticationModelString();
                        List<LoginModel>? users = [];
                        if (userList != null) {
                          users = loginModelFromJson(userList);
                        }
                        int count = 0;
                        for (LoginModel element in users) {
                          count += (element.unreadNotifications ?? 0);
                        }
                        if (count == 0) {
                          return const SizedBox.shrink();
                        }
                        return const Positioned(
                            top: 18, right: 38, child: NotificationBadge());
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: kWhite,
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.profile);
                    },
                    leading: Image.asset(
                      "assets/profile.png",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    title: const CustomText(
                      text: "Profile",
                      textAlign: TextAlign.left,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     context
                  //         .read<HappinessCenterCubit>()
                  //         .onChangeCommunityId(0);
                  //     context.read<HappinessCenterCubit>().onChangeUnitId(0);
                  //     context.read<HappinessCenterCubit>().onChangeService("");
                  //     context.read<HappinessCenterCubit>().onChangeMessage("");
                  //     context.read<HappinessCenterCubit>().onChangeFiles([]);
                  //     Navigator.pushNamed(context, AppRoutes.happinessCenter);
                  //   },
                  //   leading: Image.asset(
                  //     "assets/happiness_centre.png",
                  //     color: context.read<AppThemeCubit>().state.primaryColor,
                  //     width: MediaQuery.of(context).size.width * 0.06,
                  //   ),
                  //   title: const CustomText(
                  //     text: "Happiness Center",
                  //     textAlign: TextAlign.left,
                  //   ),
                  //   trailing: const Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 15,
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.changePassword);
                    },
                    leading: Image.asset(
                      "assets/change_password.png",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    title: const CustomText(
                      text: "Change Password",
                      textAlign: TextAlign.left,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                  ListTile(
                    onTap: () async {
                      Navigator.pushNamed(context, AppRoutes.myDownloads);
                    },
                    leading: Image.asset(
                      "assets/my_downloads.png",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    title: const CustomText(
                      text: "My Downloads",
                      textAlign: TextAlign.left,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.changeIcon);
                    },
                    leading: Image.asset(
                      "assets/icon.png",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      width: MediaQuery.of(context).size.width * 0.06,
                    ),
                    title: const CustomText(
                      text: "Brand your App",
                      textAlign: TextAlign.left,
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 15,
                    ),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, AppRoutes.verifyDocuments);
                  //   },
                  //   leading: Image.asset(
                  //     "assets/change_password.png",
                  //     color: context.read<AppThemeCubit>().state.primaryColor,
                  //     width: MediaQuery.of(context).size.width * 0.06,
                  //   ),
                  //   title: const CustomText(
                  //     text: "verify documents",
                  //     textAlign: TextAlign.left,
                  //   ),
                  //   trailing: const Icon(
                  //     Icons.arrow_forward_ios,
                  //     size: 15,
                  //   ),
                  // ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget addNewAccount(BuildContext context, GlobalKey<FormState> formKey,
      LoginCubit loginCubit) {
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Gap(50),
                            CustomText(
                              text: "Add Account",
                              fontWeight: FontWeight.bold,
                              color: context
                                  .read<AppThemeCubit>()
                                  .state
                                  .primaryColor
                                  .withOpacity(0.8),
                              fontSize: 20,
                            ),
                            const Gap(10),
                            LoginPage().textFieldWithText(
                              context,
                              "Email",
                              hintText: "Enter the email",
                              fillColor: kBackgroundColor,
                              readOnly:
                                  state.loadingState == LoadingState.loading
                                      ? true
                                      : false,
                              prefix: Icon(
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
                            LoginPage().textFieldWithText(
                              context,
                              "Password",
                              hintText: "Enter password",
                              readOnly:
                                  state.loadingState == LoadingState.loading
                                      ? true
                                      : false,
                              obscure: state.obscure,
                              fillColor: kBackgroundColor,
                              prefix: Icon(
                                Icons.lock_outline,
                                color: context
                                    .read<AppThemeCubit>()
                                    .state
                                    .primaryColor,
                              ),
                              suffix: IconButton(
                                onPressed: () {
                                  loginCubit.onChangeObscure(!state.obscure);
                                },
                                icon: Icon(
                                  state.obscure
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
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
                            const Gap(10),
                            Builder(
                              builder: (context) {
                                if (state.loadingState ==
                                    LoadingState.loading) {
                                  return const SizedBox(
                                      height: 50, child: CustomLoader());
                                }
                                return CustomButton(
                                    text: "Login",
                                    buttonColor: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor
                                        .withOpacity(0.8),
                                    function: () {
                                      if (formKey.currentState?.validate() ??
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
                                          fontSize: 12,
                                        ),
                                        CustomText(
                                          text:
                                              "This means the email is already used and synced",
                                          fontSize: 12,
                                          color: kGrey.shade700,
                                        ),
                                        const Gap(10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                          ].animate(interval: 50.ms).fade(),
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

  Widget selectProfile(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Gap(50),
            CustomText(
              text: "Select a Profile",
              fontWeight: FontWeight.bold,
              color: context
                  .read<AppThemeCubit>()
                  .state
                  .primaryColor
                  .withOpacity(0.8),
              fontSize: 20,
            ),
            const Gap(10),
            Expanded(
              child: StatefulBuilder(builder: (context, changeState) {
                String? userList =
                    Global.storageService.getAuthenticationModelString();
                List<LoginModel>? users = [];
                if (userList != null) {
                  users = loginModelFromJson(userList);
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(10),
                  itemCount: users.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Gap(10);
                  },
                  itemBuilder: (BuildContext context, int index) {
                    LoginModel? loginModel = users?[index];
                    return Slideable(
                      items: [
                        ActionItems(
                          icon: Icon(
                            Icons.delete_outline,
                            color: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                          ),
                          onPress: () async {
                            CoolAlert.show(
                                context: context,
                                type: CoolAlertType.loading,
                                lottieAsset: "assets/loader.json",
                                text: "Removing profile ... !",
                                barrierDismissible: false);
                            await UserService.singleLogout(
                                    context, loginModel?.accessToken)
                                .then((value) async {
                              if (value is Success) {
                                changeState(() {
                                  Global.storageService
                                      .removeAuthenticationModelString(
                                          index: index);
                                });
                                users?.removeAt(index);
                                Navigator.pop(context);
                                Fluttertoast.showToast(
                                    msg: "Profile deleted successfully");
                                if (index == 0) {
                                  if ((users?.length ?? 0) <= 0) {
                                    Fluttertoast.showToast(
                                        msg: "logged out successfully !!");
                                    Global.storageService.removeUser();
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.login,
                                    );
                                    String? theme =
                                        Global.storageService.getAppTheme();
                                    context
                                        .read<AppThemeCubit>()
                                        .onChangeAppTheme(const ProfilePage()
                                            .parseHexColor(theme ?? "#751b50"));
                                  } else {
                                    onProfileTap(context, users ?? [], index,
                                        checkFirst: false);
                                  }
                                }
                                return;
                              }
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                  msg: "Unable to delete the profile");
                            });
                          },
                          backgroundColor: Colors.transparent,
                        ),
                      ],
                      child: GestureDetector(
                        onTap: () => onProfileTap(context, users ?? [], index),
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: kWhite),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    height: MediaQuery.of(context).size.width *
                                        0.25,
                                    width: MediaQuery.of(context).size.width *
                                        0.25,
                                    decoration: BoxDecoration(
                                      color: const Color(0xffF2F2F2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ImageBuilder(
                                      url: loginModel
                                              ?.owner?.company?.faviconUrl ??
                                          "",
                                      isFit: true,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.1,
                                      width: MediaQuery.of(context).size.width *
                                          0.1,
                                    ),
                                  ),
                                  const Gap(10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomText(
                                          text:
                                              loginModel?.owner?.fullName ?? '',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.045,
                                          fontWeight: FontWeight.bold,
                                          color: kBlack,
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                        const Gap(5),
                                        CustomText(
                                          text: 'Managed By',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          fontWeight: FontWeight.w500,
                                          color: const Color(0xFFB2B1B1),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                        const Gap(5),
                                        CustomText(
                                          text: loginModel
                                                  ?.owner?.company?.name ??
                                              '',
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.03,
                                          fontWeight: FontWeight.bold,
                                          color: const Color(0xFFB2B1B1),
                                          maxLines: 3,
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (index == 0) const Gap(5),
                                  if (index == 0)
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Container(
                                        height: 20,
                                        width: 20,
                                        margin:
                                            const EdgeInsets.only(bottom: 5),
                                        padding: const EdgeInsets.all(2.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border: Border.all(
                                              color: context
                                                  .read<AppThemeCubit>()
                                                  .state
                                                  .primaryColor,
                                              width: 1),
                                        ),
                                        child: Checkbox(
                                          value: index == 0 ? true : false,
                                          fillColor:
                                              const MaterialStatePropertyAll(
                                                  kTransparent),
                                          checkColor: context
                                              .read<AppThemeCubit>()
                                              .state
                                              .primaryColor,
                                          side: BorderSide.none,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              side: BorderSide.none),
                                          onChanged: (value) {},
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                            if ((loginModel?.unreadNotifications ?? 0) > 0)
                              const Positioned(
                                top: 0,
                                right: 0,
                                child: NotificationBadge(),
                              ),
                          ],
                        ),
                      ),
                    ).animate().fade(duration: 600.ms);
                  },
                );
              }),
            ),
            Divider(
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: CustomButton(
                  text: "Add Account",
                  icon: const Icon(
                    Icons.add_circle_outline,
                    color: kWhite,
                  ),
                  buttonColor: context
                      .read<AppThemeCubit>()
                      .state
                      .primaryColor
                      .withOpacity(0.8),
                  function: () {
                    final GlobalKey<FormState> key = GlobalKey();
                    final LoginCubit loginCubit = context.read<LoginCubit>();
                    showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) =>
                            addNewAccount(context, key, loginCubit));
                  }),
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
    );
  }

  Future<void> onProfileTap(
      BuildContext context, List<LoginModel> users, int index,
      {checkFirst = true}) async {
    if (users[0] == users[index] && checkFirst) {
      Fluttertoast.showToast(msg: "Already logged In");
      return;
    }

    CoolAlert.show(
        context: context,
        type: CoolAlertType.loading,
        lottieAsset: "assets/profile.json",
        text: "Switching profile ... ");
    String? jsonAuthModel =
        Global.storageService.getAuthenticationModelString();
    if (jsonAuthModel != null) {
      context.read<LoginCubit>().onChangeLoginModel(users[index]);
      LoginPage().initialCalls(context);
      await context.read<ProfileCubit>().getProfile(context).then((value) {
        ProfileModel? profileModel =
            context.read<ProfileCubit>().state.profileModel;
        users[index].unreadNotifications =
            profileModel?.record?.unreadNotifications;
        context.read<LoginCubit>().onChangeLoginModel(users[index]);
        context.read<AuthenticationCubit>().isDeviceSupported(context).then(
          (value) {
            if (profileModel?.record?.company != null) {
              users[index].owner?.company =
                  Company.fromJson(profileModel!.record!.company!.toJson());
            }
            context.read<AppThemeCubit>().onChangeAppTheme(const ProfilePage()
                .parseHexColor(
                    users[index].owner?.company?.themeColor ?? "#751b50"));
            Global.storageService.setAuthenticationModelString(
              users[index],
              addItInFront: true,
              index: index,
            );
            if (value == true) {
              return Navigator.pushReplacementNamed(
                  context, AppRoutes.authorization);
            }
            return Navigator.pushReplacementNamed(context, AppRoutes.dashboard);
          },
        );
      });
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    }
  }
}
