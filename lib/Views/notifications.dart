import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Views/ledger_by_statement.dart';

import '../Models/notifications.dart';
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
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: state.notificationsModel?.record?.length,
            itemBuilder: (BuildContext context, int index) {
              NotificationRecord? notificationRecord =
                  state.notificationsModel?.record?[index];
              return InkWell(
                onTap: () => const LedgerByStatement().decidePage(
                    context,
                    notificationRecord?.objectId,
                    notificationRecord?.objectType),
                child: const UnitsPage().roundedContainer(
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 30,
                          backgroundColor: primaryColor,
                          child: Icon(
                            Icons.list_outlined,
                            color: kWhite,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            children: [
                              CustomText(
                                text: notificationRecord?.message ?? "",
                                textAlign: TextAlign.left,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  const Icon(
                                    Icons.alarm_outlined,
                                    size: 15,
                                    color: primaryColor,
                                  ),
                                  CustomText(
                                    text: const OccupantPage()
                                        .dateTimeFormatter(
                                            notificationRecord?.createdAt),
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
                    color: kGrey.shade200),
              );
            },
          );
        },
      ),
    );
  }
}
