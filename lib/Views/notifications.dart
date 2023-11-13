import '../Utils/utils.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Notifications",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const Align(
                alignment: Alignment.centerRight,
                child: CustomText(
                  text: "Read all",
                  color: primaryColor,
                  fontsize: 17,
                )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (BuildContext context, int index) {
                  return const UnitsPage().roundedContainer(
                      const Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: primaryColor,
                            child: Icon(
                              Icons.list_outlined,
                              color: kWhite,
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              children: [
                                CustomText(
                                  text:
                                      "RI20230512636 Request has been approved.",
                                  textAlign: TextAlign.left,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Icon(
                                      Icons.alarm_outlined,
                                      size: 15,
                                      color: primaryColor,
                                    ),
                                    CustomText(
                                      text: "20 mins",
                                      fontsize: 12,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      color: kGrey.shade200);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
