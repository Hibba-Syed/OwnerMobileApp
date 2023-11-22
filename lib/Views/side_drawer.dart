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
                const SizedBox(
                  height: 10,
                ),
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
