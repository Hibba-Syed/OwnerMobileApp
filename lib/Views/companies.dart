import 'package:cool_alert/cool_alert.dart';
import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Widgets/image_builder.dart';

import '../Utils/utils.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<LoginModel>? loginModelList =
        (ModalRoute.of(context)?.settings.arguments as List)[0]
            as List<LoginModel>?;
    bool? newUser =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as bool?;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton(
            text: "Add all verified profiles",
            function: () {
              CoolAlert.show(
                  context: context,
                  type: CoolAlertType.loading,
                  barrierDismissible: false,
                  lottieAsset: "assets/loader.json");
              for (LoginModel loginModel in loginModelList ?? []) {
                Global.storageService.setAuthenticationModelString(loginModel,
                    newUser: newUser ?? false);
              }
              context.read<LoginCubit>().onChangeLoginModel(loginModelList?[0]);
              context.read<ProfileCubit>().getProfile(context).then((isLoaded) {
                if (isLoaded) {
                  Navigator.pop(context);
                  context.read<AppThemeCubit>().onChangeAppTheme(
                      const ProfilePage().parseHexColor(
                          loginModelList?[0].owner?.company?.themeColor ??
                              "#751b50"));
                  const LoginPage().initialCalls(context);
                  return Navigator.pushReplacementNamed(
                      context, AppRoutes.dashboard);
                } else {
                  Navigator.pop(context);
                  Fluttertoast.showToast(
                      msg: "Unable to load profile, please try again !");
                }
              });
            }),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardPage().appBar(context,
                
                    text: "Select Profile",
                
                  trailingIcon: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.abc,
                        color: kTransparent,
                      ))),
              const Gap(10),
              CustomText(
                text:
                    "We found profile(s) against this email managed by other CMC(s).If you wish to add the profile(s) associated the this email please select from the list below.",
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
              const Gap(10),
              Expanded(
                child: Center(
                  child: GridView.builder(
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(5),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemCount: loginModelList?.length,
                    itemBuilder: (BuildContext context, int index) {
                      LoginModel loginModel = loginModelList![index];
                      return InkWell(
                        onTap: () {
                          CoolAlert.show(
                              context: context,
                              type: CoolAlertType.loading,
                              barrierDismissible: false,
                              lottieAsset: "assets/loader.json");
                          if (newUser ?? false) {
                            for (var i = (loginModelList.length - 1);
                                i >= 0;
                                i--) {
                              Global.storageService
                                  .setAuthenticationModelString(
                                loginModelList[i],
                                newUser: newUser ?? false,
                              );
                            }
                          } else {
                            for (LoginModel loginModel in loginModelList) {
                              Global.storageService
                                  .setAuthenticationModelString(
                                loginModel,
                                newUser: newUser ?? false,
                              );
                            }
                          }
                          Global.storageService.setAuthenticationModelString(
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
                              context.read<AppThemeCubit>().onChangeAppTheme(
                                  const ProfilePage().parseHexColor(
                                      loginModel.owner?.company?.themeColor ??
                                          "#751b50"));
                              const LoginPage().initialCalls(context);
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(
                                      MediaQuery.of(context).size.width * 0.05),
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: kWhite),
                                  child: ImageBuilder(
                                    url: loginModel.owner?.company?.logoUrl ??
                                        "",
                                    isFit: true,
                                    height:
                                        MediaQuery.of(context).size.width * 0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                  ),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.green),
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
                                  "${loginModel.owner?.firstName?.capitalize() ?? " -- "} ${loginModel.owner?.lastName?.capitalize() ?? " -- "}",
                              textAlign: TextAlign.center,
                              maxLines: 2,
                            ),
                            CustomText(
                              text: loginModel.owner?.company?.name ?? "",
                              fontSize: 12,
                              maxLines: 2,
                              color: kGrey,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
