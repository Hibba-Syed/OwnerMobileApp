import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Blocs/Companies/companies_cubit.dart';
import 'package:iskaanowner/Views/side_drawer.dart';

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
        appBarHeight: 50,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: CustomButton(
            text: "Add all verified profiles",
            function: () {
              for (LoginModel loginModel in loginModelList ?? []) {
                Global.storageService.setAuthenticationModelString(loginModel);
              }
              context.read<LoginCubit>().onChangeLoginModel(loginModelList?[0]);
              context.read<ProfileCubit>().getProfile(context).then((isLoaded) {
                if (isLoaded) {
                  context.read<AppThemeCubit>().onChangeAppTheme(
                      const SplashPage().parseHexColor(
                          loginModelList?[0].owner?.company?.themeColor ??
                              "#751b50"));
                  const LoginPage().initialCalls(context);
                  return Navigator.pushReplacementNamed(
                      context, AppRoutes.dashboard);
                } else {
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
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: loginModelList
                          ?.map((e) => InkWell(
                                onTap: () {
                                  Global.storageService
                                      .setAuthenticationModelString(e);
                                  context
                                      .read<LoginCubit>()
                                      .onChangeLoginModel(e);
                                  context
                                      .read<ProfileCubit>()
                                      .getProfile(context)
                                      .then((isLoaded) {
                                    if (isLoaded) {
                                      context
                                          .read<AppThemeCubit>()
                                          .onChangeAppTheme(const SplashPage()
                                              .parseHexColor(e.owner?.company
                                                      ?.themeColor ??
                                                  "#751b50"));
                                      const LoginPage().initialCalls(context);
                                      return Navigator.pushReplacementNamed(
                                          context, AppRoutes.dashboard);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Unable to load profile, please try again !");
                                    }
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          radius: 52,
                                          backgroundColor: kGrey.shade200,
                                          child: CircleAvatar(
                                            radius: 50,
                                            backgroundColor: kWhite,
                                            child: CircleAvatar(
                                              backgroundColor: kWhite,
                                              radius: 40,
                                              foregroundImage: NetworkImage(e
                                                      .owner
                                                      ?.company
                                                      ?.faviconUrl ??
                                                  ""),
                                            ),
                                          ),
                                        ),
                                        CustomText(
                                            text: e.owner?.company?.shortName ??
                                                "")
                                      ],
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
                              ))
                          .toList() ??
                      [],
                ),
              ),
            ),
            Expanded(child: BlocBuilder<CompaniesCubit, CompaniesState>(
              builder: (context, state) {
                if (state.loadingState == LoadingState.loading) {
                  return const CustomLoader();
                }
                state.companiesModel?.record?.removeWhere((company) =>
                    loginModelList?.any(
                        (owner) => owner.owner?.company?.id == company.id) ??
                    false);
                return Column(
                  children: [
                    const Gap(10),
                    CustomText(
                      text: "Same Profile in other companies",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      fontsize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    const Gap(10),
                    Expanded(
                      child: Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: state.companiesModel?.record
                                ?.map(
                                  (e) => Stack(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          final GlobalKey<FormState> key =
                                              GlobalKey();
                                          final LoginCubit loginCubit =
                                              context.read<LoginCubit>();
                                          showModalBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  const SideDrawerPage()
                                                      .addNewAccount(
                                                          key, loginCubit));
                                        },
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            CircleAvatar(
                                              radius: 52,
                                              backgroundColor: kGrey.shade200,
                                              child: CircleAvatar(
                                                radius: 50,
                                                backgroundColor: kWhite,
                                                child: CircleAvatar(
                                                  backgroundColor: kWhite,
                                                  radius: 40,
                                                  foregroundImage: NetworkImage(
                                                      e.faviconUrl ?? ""),
                                                ),
                                              ),
                                            ),
                                            CustomText(text: e.shortName ?? "")
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.red),
                                          child: const Icon(
                                            Icons.login,
                                            color: kWhite,
                                            size: 15,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                                .toList() ??
                            [],
                      ),
                    ),
                  ],
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
