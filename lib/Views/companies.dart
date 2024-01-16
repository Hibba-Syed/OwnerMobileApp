import 'package:cool_alert/cool_alert.dart';
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

    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
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
                            fontSize: MediaQuery.of(context).size.width * 0.04,
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
                                LoginModel? loginModel = loginModelList[index];
                                return CompanySelectionWidget(
                                  onTap: () {
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.loading,
                                        barrierDismissible: false,
                                        lottieAsset: "assets/loader.json");
                                    if (newUser) {
                                      for (var i = (loginModelList.length - 1);
                                          i >= 0;
                                          i--) {
                                        Global.storageService
                                            .setAuthenticationModelString(
                                          loginModelList[i],
                                          newUser: newUser,
                                        );
                                      }
                                    } else {
                                      for (LoginModel loginModel
                                          in loginModelList) {
                                        Global.storageService
                                            .setAuthenticationModelString(
                                          loginModel,
                                          newUser: newUser,
                                        );
                                      }
                                    }
                                    Global.storageService
                                        .setAuthenticationModelString(
                                            loginModel,
                                            addItInFront: true,
                                            index: index);
                                    context
                                        .read<LoginCubit>()
                                        .onChangeLoginModel(loginModel);
                                    context
                                        .read<ProfileCubit>()
                                        .getProfile(context)
                                        .then((isLoaded) {
                                      if (isLoaded) {
                                        Navigator.pop(context);
                                        context
                                            .read<AppThemeCubit>()
                                            .onChangeAppTheme(
                                                const ProfilePage()
                                                    .parseHexColor(loginModel
                                                            .owner
                                                            ?.company
                                                            ?.themeColor ??
                                                        "#751b50"));
                                        LoginPage().initialCalls(context);
                                        return Navigator.pushReplacementNamed(
                                            context, AppRoutes.dashboard);
                                      } else {
                                        Navigator.pop(context);
                                        Fluttertoast.showToast(
                                            msg:
                                                "Unable to load profile, please try again !");
                                      }
                                    });
                                  },
                                  isSelected: true,
                                  title: loginModel.owner?.fullName ?? "",
                                  description:
                                      loginModel.owner?.company?.name ?? "",
                                  profilePictureUrl:
                                      loginModel.owner?.company?.faviconUrl ??
                                          '',
                                );
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
                                    text: "Add all verified profiles",
                                    icon: Image.asset(
                                      "assets/verified.png",
                                      scale: 4,
                                    ),
                                    function: () {
                                      CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.loading,
                                          barrierDismissible: false,
                                          lottieAsset: "assets/loader.json");
                                      for (LoginModel loginModel
                                          in loginModelList) {
                                        Global.storageService
                                            .setAuthenticationModelString(
                                                loginModel,
                                                newUser: newUser);
                                      }
                                      context
                                          .read<LoginCubit>()
                                          .onChangeLoginModel(
                                              loginModelList[0]);
                                      context
                                          .read<ProfileCubit>()
                                          .getProfile(context)
                                          .then((isLoaded) {
                                        if (isLoaded) {
                                          Navigator.pop(context);
                                          context
                                              .read<AppThemeCubit>()
                                              .onChangeAppTheme(
                                                  const ProfilePage()
                                                      .parseHexColor(
                                                          loginModelList[0]
                                                                  .owner
                                                                  ?.company
                                                                  ?.themeColor ??
                                                              "#751b50"));
                                          LoginPage().initialCalls(context);
                                          return Navigator.pushReplacementNamed(
                                              context, AppRoutes.dashboard);
                                        } else {
                                          Navigator.pop(context);
                                          Fluttertoast.showToast(
                                            msg:
                                                "Unable to load profile, please try again !",
                                          );
                                        }
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
