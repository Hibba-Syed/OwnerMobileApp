import 'dart:convert';

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
          color: primaryColor.withOpacity(0.1),
          child: SafeArea(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const UnitsPage().roundedContainer(
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
                        "Owner ID : ${profileModel?.record?.ownerExternalId ?? " -- "}"),
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
                              const CustomText(
                                text: "Select a Profile",
                                color: primaryColor,
                                fontsize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                              const Gap(10),
                              Column(
                                children: List.generate(users.length, (index) {
                                  LoginModel loginModel = loginModelFromJson(
                                      jsonEncode(users[index]));
                                  return Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: kWhite,
                                    ),
                                    child: ListTile(
                                      onTap: () {
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
                                        Navigator.pushNamed(
                                            context, AppRoutes.splash);
                                      },
                                      leading: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: primaryColor),
                                          child: const Icon(
                                            Icons.person_outline,
                                            color: kWhite,
                                          )),
                                      title: CustomText(
                                          text:
                                              loginModel.owner?.fullName ?? ""),
                                      trailing: index == 0
                                          ? const Icon(
                                              Icons.done,
                                              color: primaryColor,
                                            )
                                          : const Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 15,
                                            ),
                                    ),
                                  );
                                }),
                              ),
                              const Gap(10),
                              const Divider(
                                color: primaryColor,
                              ),
                              const Gap(10),
                              CustomButton(
                                  text: "Add Account",
                                  icon: const Icon(
                                    Icons.add,
                                    color: kWhite,
                                  ),
                                  function: () {
                                    Navigator.pushNamed(
                                        context, AppRoutes.login,
                                        arguments: true);
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
          leading: const Icon(
            Icons.person_2_outlined,
            color: primaryColor,
          ),
          title: const CustomText(
            text: "Profile",
            textAlign: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: primaryColor,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.happinessCenter);
          },
          leading: const Icon(
            Icons.emoji_people_outlined,
            color: primaryColor,
          ),
          title: const CustomText(
            text: "Happiness Center",
            textAlign: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: primaryColor,
          ),
        ),
        ListTile(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.changePassword);
          },
          leading: const Icon(
            Icons.password_outlined,
            color: primaryColor,
          ),
          title: const CustomText(
            text: "Change Password",
            textAlign: TextAlign.left,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 18,
            color: primaryColor,
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(10),
          child: CustomButton(
            text: "Logout",
            function: () {
              Global.storageService.removeUser();
              Navigator.pushReplacementNamed(
                context,
                AppRoutes.login,
              );
            },
            icon: const Icon(
              Icons.logout_outlined,
              color: kWhite,
            ),
          ),
        ),
      ],
    );
  }
}
