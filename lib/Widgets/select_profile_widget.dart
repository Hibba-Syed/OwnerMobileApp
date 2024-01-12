import 'dart:convert';

import 'package:iskaanowner/Blocs/App%20Theme/app_theme_cubit.dart';
import 'package:iskaanowner/Utils/utils.dart';
import 'package:iskaanowner/Views/side_drawer.dart';
import 'package:iskaanowner/Widgets/image_builder.dart';

class SelectProfilePage extends StatelessWidget {
  const SelectProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    String? userList = Global.storageService.getAuthenticationModelString();
    List<dynamic> users = jsonDecode(userList ?? "[]");
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Gap(20),
          CustomText(
            text: "Select a Profile",
            color: context.read<AppThemeCubit>().state.primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          const Gap(10),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: GridView.builder(
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: users.length,
              itemBuilder: (BuildContext context, int index) {
                LoginModel loginModel = LoginModel.fromJson(users[index]);
                return InkWell(
                  onTap: () async => await const SideDrawerPage()
                      .onProfileTap(context, users, index),
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
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              url: loginModel.owner?.company?.logoUrl ?? "",
                              isFit: true,
                            ),
                          ),
                          if (index == 0)
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
                            "${loginModel.owner?.firstName ?? " -- "} ${loginModel.owner?.lastName ?? " -- "} ",
                        textAlign: TextAlign.center,
                        fontSize: 14,
                        maxLines: 2,
                      ),
                      CustomText(
                        text: loginModel.owner?.company?.name ?? "",
                        fontSize: 12,
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
            color: context.read<AppThemeCubit>().state.primaryColor,
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
                  final GlobalKey<FormState> key = GlobalKey();
                  final LoginCubit loginCubit = context.read<LoginCubit>();
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) => const SideDrawerPage()
                          .addNewAccount(context, key, loginCubit));
                }),
          )
        ],
      ),
    );
  }
}
