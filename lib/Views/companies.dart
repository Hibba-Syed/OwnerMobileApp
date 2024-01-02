import 'package:cool_alert/cool_alert.dart';
import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Widgets/image_builder.dart';

import '../Utils/utils.dart';

class CompaniesPage extends StatelessWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<LoginModel>? loginModelList =
        ModalRoute.of(context)?.settings.arguments as List<LoginModel>?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "Select Company",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
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
                Global.storageService.setAuthenticationModelString(loginModel);
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
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            CustomText(
              text: "Multiple Profiles found",
              fontsize: 20,
              fontWeight: FontWeight.bold,
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(10),
            const CustomText(
                text:
                    "We found multiple companies against this email and password. Please select one of them to login"),
            const Gap(10),
            Expanded(
              child: Center(
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(5),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                        for (LoginModel loginModel in loginModelList) {
                          Global.storageService
                              .setAuthenticationModelString(loginModel);
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
                                  url: loginModel.owner?.company?.logoUrl ?? "",
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
                            fontsize: 12,
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
    );
  }
}
