import 'dart:isolate';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Utils/constants.dart';

import '../Utils/utils.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<LoginModel>? loginModelList =
        (ModalRoute.of(context)?.settings.arguments as List)[0]
                as List<LoginModel>? ??
            [] as List<LoginModel>;
    bool? newUser =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as bool? ??
            false;
    List<bool> selectedIndex = loginModelList.map((e) => true).toList();
    List<int> selectedProfilesIndex =
        List.generate(loginModelList.length, (index) => index);
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: StatefulBuilder(builder: (context, changeState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const DashboardPage().appBar(context,
                        text: "Select Profile",
                        trailingIcon: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.abc,
                              color: kTransparent,
                            ))),
                    Expanded(
                      child: ConstrainedBox(
                        constraints:
                            const BoxConstraints(maxWidth: customMaxWidth),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Gap(10),
                            CustomText(
                              text:
                                  "We found profile(s) against this email managed by other CMC(s).If you wish to add the profile(s) associated the this email please select from the list below.",
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.04,
                            ),
                            const Gap(10),
                            Expanded(
                                child: Center(
                              child: ListView.separated(
                                shrinkWrap: true,
                                padding: const EdgeInsets.all(5),
                                itemCount: loginModelList.length,
                                separatorBuilder: (context, index) =>
                                    const Gap(10),
                                itemBuilder: (context, index) {
                                  LoginModel? loginModel =
                                      loginModelList[index];
                                  return CompanySelectionWidget(
                                    onTap: () {
                                      changeState(() {
                                        selectedIndex[index] =
                                            !selectedIndex[index];
                                        if (selectedProfilesIndex
                                            .contains(index)) {
                                          selectedProfilesIndex.remove(index);
                                        } else {
                                          selectedProfilesIndex.add(index);
                                        }
                                      });
                                    },
                                    isSelected: selectedIndex[index],
                                    title: loginModel.owner?.fullName ?? "",
                                    description:
                                        loginModel.owner?.company?.name ?? "",
                                    profilePictureUrl:
                                        loginModel.owner?.company?.faviconUrl ??
                                            '',
                                  ).animate().fade(duration: 600.ms);
                                },
                              ),
                            )),
                            const Gap(10),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxWidth: customMaxWidth,
                                  minWidth: 0,
                                  minHeight: 0),
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                      maxWidth: customMaxWidth),
                                  child: CustomButton(
                                    width: customMaxWidth,
                                    text:
                                        "Add ${selectedProfilesIndex.length == loginModelList.length ? "all" : "selected"} verified profiles",
                                    icon: Image.asset(
                                      "assets/verified.png",
                                      scale: 4,
                                    ),
                                    buttonColor: selectedProfilesIndex.isEmpty
                                        ? kGrey.shade600
                                        : context
                                            .read<AppThemeCubit>()
                                            .state
                                            .primaryColor,
                                    function: () async {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.loading,
                                          barrierDismissible: false,
                                          text: "Adding profiles...",
                                          lottieAsset: "assets/loader.json");
                                      if (selectedProfilesIndex.isEmpty) {
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg: "Select at least one profile");
                                        return;
                                      }

                                      List<LoginModel>? loginModelListCopy = [];
                                      ReceivePort receivePort = ReceivePort();
                                      try {
                                        await Isolate.spawn(
                                          addProfilesUsingIsolateFunction,
                                          [
                                            receivePort.sendPort,
                                            selectedProfilesIndex,
                                            loginModelListCopy,
                                            loginModelList,
                                            newUser,
                                            Global.storageService
                                          ],
                                        );
                                      } on Object {
                                        receivePort.close();
                                      }
                                      await receivePort.first.then(
                                        (value) {
                                          Global.storageService
                                              .setAuthenticationModelListString(
                                                  value[1]);
                                          loginModelListCopy = value[0];
                                          context
                                              .read<LoginCubit>()
                                              .onChangeLoginModel(
                                                  loginModelListCopy?[0]);
                                          context
                                              .read<ProfileCubit>()
                                              .getProfile(context)
                                              .then(
                                            (isLoaded) {
                                              if (isLoaded) {
                                                Navigator.pop(context);
                                                context
                                                    .read<AppThemeCubit>()
                                                    .onChangeAppTheme(const ProfilePage()
                                                        .parseHexColor(
                                                            loginModelListCopy?[
                                                                        0]
                                                                    .owner
                                                                    ?.company
                                                                    ?.themeColor ??
                                                                "#751b50"));
                                                LoginPage()
                                                    .initialCalls(context);
                                                return Navigator
                                                    .pushNamedAndRemoveUntil(
                                                        context,
                                                        AppRoutes.dashboard,
                                                        (route) => false);
                                              } else {
                                                Navigator.pop(context);
                                                Fluttertoast.showToast(
                                                  msg:
                                                      "Unable to load profile, please try again !",
                                                );
                                              }
                                            },
                                          );
                                        },
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
                  ],
                );
              }),
            ),
          ),
        );
      },
    );
  }
}

addProfilesUsingIsolateFunction(List args) async {
  SendPort resultPort = args[0];
  List selectedProfilesIndex = args[1];
  List loginModelListCopy = args[2];
  List loginModelList = args[3];
  bool newUser = args[4];
  StorageService storageService = args[5];
  for (int index in selectedProfilesIndex) {
    loginModelListCopy.add(loginModelList[index]);
  }

  if (newUser) {
    for (var i = (loginModelListCopy.length - 1); i >= 0; i--) {
      storageService.setAuthenticationModelString(
        loginModelListCopy[i],
        newUser: newUser,
      );
    }
  } else {
    for (LoginModel loginModel in loginModelListCopy) {
      storageService.setAuthenticationModelString(loginModel, newUser: newUser);
    }
  }
  Isolate.exit(resultPort,
      [loginModelListCopy, storageService.getAuthenticationModelString()]);
}
