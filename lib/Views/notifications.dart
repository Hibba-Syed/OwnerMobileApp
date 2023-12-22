import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Views/ledger_by_account_details.dart';
import 'package:iskaanowner/Views/ledger_by_statement.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
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
          if (state.notificationsModel?.record?.isEmpty ?? true) {
            return const CreditNotesPage().emptyList();
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
                    context,
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 30,
                            backgroundColor: context
                                .read<AppThemeCubit>()
                                .state
                                .primaryColor,
                            child: const LedgerByAccountDetailsPage()
                                .ledgerIcon(notificationRecord?.objectType,
                                    icon: Icons.list_outlined)),
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
                                  Icon(
                                    Icons.alarm_outlined,
                                    size: 15,
                                    color: context
                                        .read<AppThemeCubit>()
                                        .state
                                        .primaryColor,
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
