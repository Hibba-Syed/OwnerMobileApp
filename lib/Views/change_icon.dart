import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';

import '../Utils/utils.dart';

class ChangeIcon extends StatelessWidget {
  const ChangeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const DashboardPage().appBar(
                context,
                text: "Brand your App",
              ),
              CustomText(
                text:
                    "Choose the ICON you would like to use for your application.",
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
              const Gap(20),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: kWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Note : ",
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: kGrey,
                      fontWeight: FontWeight.bold,
                    ),
                    const Gap(10),
                    CustomText(
                      text:
                          "Make sure to fully close the app. \n\nHead to your recent apps list and swipe away the app to clear it to see the effect.",
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      color: kGrey,
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      try {
                        if (await FlutterDynamicIconPlus
                            .supportsAlternateIcons) {
                          await FlutterDynamicIconPlus.setAlternateIconName(
                              null);
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("App icon restore successful"),
                            ));
                          }
                          FlutterDynamicIconPlus.alternateIconName;
                          return;
                        }
                      } catch (_) {}
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          duration: Duration(seconds: 3),
                          content: Text("Failed to change app icon"),
                        ));
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                            color: kGrey.shade200,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/owner.png",
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      try {
                        if (await FlutterDynamicIconPlus
                            .supportsAlternateIcons) {
                          await FlutterDynamicIconPlus.setAlternateIconName(
                              "saga");
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("App icon change successful"),
                            ));
                          }
                          FlutterDynamicIconPlus.alternateIconName;
                          return;
                        }
                      } catch (_) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              duration: Duration(seconds: 3),
                              content: Text("Failed to change app icon"),
                            ),
                          );
                        }
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: kWhite,
                        boxShadow: [
                          BoxShadow(
                            color: kGrey.shade200,
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/saga.png",
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
