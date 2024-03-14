import 'dart:io';

import 'package:flutter_dynamic_icon_plus/flutter_dynamic_icon_plus.dart';

import '../Utils/utils.dart';

class ChangeIcon extends StatelessWidget {
  const ChangeIcon({super.key});

  @override
  Widget build(BuildContext context) {
    Widget? bottomWidget;
    Map? arguments = ModalRoute.of(context)?.settings.arguments as Map?;
    if (arguments != null) {
      if (arguments["showBottomText"] == true) {
        bottomWidget = Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: kWhite),
          child: CustomText(
            text: "You can always change later from\nDrawer > Brand your app",
            textAlign: TextAlign.center,
            fontSize: MediaQuery.of(context).size.width * 0.04,
          ),
        );
      }
    }
    // icons.where((element) => element["id"]).toList();
    return Scaffold(
      bottomNavigationBar: bottomWidget,
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
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: kWhite),
                child: CustomText(
                  text:
                      "Choose the ICON you would like to use for your application.",
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  textAlign: TextAlign.center,
                ),
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
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1),
                  itemCount: icons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () => onTap(context,
                          name: icons[index]["name"],
                          color: icons[index]["color"],
                          iconName: icons[index]["name"] == "iskaan"
                              ? null
                              : icons[index]["name"]),
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
                            "assets/${icons[index]["name"]}/${icons[index]["name"]}.png",
                            width: MediaQuery.of(context).size.width * 0.4,
                            fit: BoxFit.cover,
                            height: MediaQuery.of(context).size.width * 0.4,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTap(BuildContext context,
      {String? iconName, String? color, String? name}) async {
    if (color != null) {
      Global.storageService.setAppTheme(color);
    }
    if (name != null) {
      Global.storageService.setAppLogo(name);
    }
    try {
      if (await FlutterDynamicIconPlus.supportsAlternateIcons) {
        await FlutterDynamicIconPlus.setAlternateIconName(iconName);
        if (context.mounted && Platform.isAndroid) {
          customDialogue(context);
        }
        FlutterDynamicIconPlus.alternateIconName;
        return;
      }
    } catch (_) {}
    if (context.mounted) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Failed to change app icon"),
      ));
    }
  }

  void customDialogue(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (context) => Theme(
        data:
            ThemeData(dialogTheme: const DialogTheme(backgroundColor: kWhite)),
        child: AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: "Icon Changed Successfully",
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
                textAlign: TextAlign.center,
              ),
              const Gap(20),
              CustomText(
                text:
                    "Access your recent apps, tap square (Android) or swipe up (iPhone). Find the app, then swipe it away: sideways on Android, up on iPhone. That's all!",
                textAlign: TextAlign.center,
                color: kGrey,
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
              const Gap(20),
              CustomButton(
                  text: "Close",
                  function: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
