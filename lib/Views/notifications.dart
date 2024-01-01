import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Views/ledger/ledger_by_account_details.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Models/notifications.dart';
import '../Utils/utils.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    _scrollController.addListener(scrollListener);
    super.initState();
  }

  scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      NotificationsCubit notificationsCubit =
          context.read<NotificationsCubit>();
      if (notificationsCubit.state.loadMoreState != LoadingState.loading) {
        notificationsCubit.getMoreNotifications(context);
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    super.dispose();
  }

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
          if (state.notificationsModel?.notifications?.isEmpty ?? true) {
            return const CreditNotesPage().emptyList();
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(10),
                  itemCount: state.notificationsModel?.notifications?.length,
                  itemBuilder: (BuildContext context, int index) {
                    NotificationRecord? notificationRecord =
                        state.notificationsModel?.notifications?[index];
                    return InkWell(
                      onTap: () => const LedgerPage().decidePage(
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
                                      .ledgerIcon(
                                          notificationRecord?.objectType,
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
                                                  notificationRecord
                                                      ?.createdAt),
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
                ),
              ),
              if (state.loadMoreState == LoadingState.loading)
                const SizedBox(
                  height: 100,
                  child: Center(child: CircularProgressIndicator()),
                )
            ],
          );
        },
      ),
    );
  }
}
