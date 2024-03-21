import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconify_flutter_plus/iconify_flutter_plus.dart';
import 'package:iconify_flutter_plus/icons/ic.dart';
import 'package:iskaanowner/Blocs/Notifications/notifications_cubit.dart';
import 'package:iskaanowner/Views/ledger/ledger_by_account_details.dart';
import 'package:iskaanowner/Widgets/notification_badge.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            const DashboardPage().appBar(
              context,
              text: "Notifications",
              trailingIcon: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.abc,
                  color: kTransparent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      context
                          .read<NotificationsCubit>()
                          .readAllNotifications(context);
                    },
                    child: Row(
                      children: [
                        Iconify(
                          Ic.outline_mark_chat_read,
                          size: MediaQuery.of(context).size.width * 0.035,
                          color: kGrey,
                        ),
                        const Gap(5),
                        CustomText(
                          text: "Read all",
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          color: kGrey,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<NotificationsCubit, NotificationsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.notificationsModel?.notifications?.isEmpty ??
                      true) {
                    return const CreditNotesPage().emptyList(
                        ontap: () => context
                            .read<NotificationsCubit>()
                            .getNotifications(context));
                  }
                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<NotificationsCubit>()
                          .getNotifications(context);
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.all(10),
                      itemCount:
                          state.notificationsModel?.notifications?.length,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        NotificationRecord? notificationRecord =
                            state.notificationsModel?.notifications?[index];
                        return Column(
                          children: [
                            InkWell(
                                onTap: () {
                                  if ((notificationRecord?.isRead ?? 0) == 0) {
                                    context
                                        .read<NotificationsCubit>()
                                        .readNotification(context,
                                            notificationRecord?.id, index);
                                  }
                                  if (notificationRecord?.objectType?.toLowerCase() == "owners" ||
                                      notificationRecord?.objectType
                                              ?.toLowerCase() ==
                                          "notice" ||
                                      notificationRecord?.objectType
                                              ?.toLowerCase() ==
                                          "email_enquiry") {
                                    showDialog(
                                      context: context,
                                      builder: (context) => Theme(
                                        data: ThemeData(
                                            dialogBackgroundColor: kWhite),
                                        child: AlertDialog(
                                            content: notificationContent(
                                                notificationRecord,
                                                maxLines: 5)),
                                      ),
                                    );
                                    return;
                                  }
                                  if (notificationRecord?.objectType
                                          ?.toLowerCase() ==
                                      "application") {
                                    String? route = const RequestsPage()
                                        .getRouteName(notificationRecord
                                            ?.subGroup
                                            ?.toLowerCase());
                                    if (route != null) {
                                      Navigator.pushNamed(context, route,
                                          arguments: [
                                            notificationRecord?.objectId,
                                            notificationRecord?.activity,
                                            notificationRecord?.subGroup,
                                          ]);
                                    } else {
                                      Fluttertoast.showToast(
                                          msg: "unknown request");
                                    }
                                    return;
                                  }
                                  if (notificationRecord?.objectType
                                          ?.toLowerCase() ==
                                      "shared_docs") {
                                    context
                                        .read<SharedDocumentsCubit>()
                                        .getSharedDocuments(context,
                                            unitId:
                                                notificationRecord?.objectId);
                                    Navigator.pushNamed(
                                        context, AppRoutes.sharedDocument,
                                        arguments:
                                            notificationRecord?.objectId);
                                  }
                                  const LedgerPage().decidePage(
                                      context,
                                      notificationRecord?.objectId,
                                      notificationRecord?.objectType);
                                },
                                child: notificationBody(
                                    context, notificationRecord)),
                            if ((index + 1) ==
                                state.notificationsModel?.notifications?.length)
                              SizedBox(
                                height: 150,
                                child:
                                    state.loadMoreState == LoadingState.loading
                                        ? const CustomLoader()
                                        : null,
                              ),
                          ],
                        ).animate().fade(duration: 600.ms);
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget notificationBody(
      BuildContext context, NotificationRecord? notificationRecord) {
    return Stack(
      children: [
        const UnitsPage().roundedContainer(
            context, notificationContent(notificationRecord),
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            color: kWhite),
        if ((notificationRecord?.isRead ?? 0) == 0)
          const Positioned(right: 0, top: 3, child: NotificationBadge())
      ],
    );
  }

  Widget notificationContent(NotificationRecord? notificationRecord,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Image.asset(
              const LedgerByAccountDetailsPage().ledgerImageIcon(
                notificationRecord?.objectType,
                makeNotificationDefault: true,
              ),
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.width * 0.1,
              color: context
                  .read<AppThemeCubit>()
                  .state
                  .primaryColor
                  .withOpacity(0.8),
            ),
            const Gap(10),
            Expanded(
              child: CustomText(
                text: notificationRecord?.group ?? "",
                maxLines: maxLines,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.045,
              ),
            ),
          ],
        ),
        const Gap(10),
        CustomText(
          text: notificationRecord?.message ?? "",
          fontSize: MediaQuery.of(context).size.width * 0.035,
        ),
        const Gap(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.alarm_outlined,
              size: MediaQuery.of(context).size.width * 0.03,
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(5),
            CustomText(
              text: const OccupantPage()
                  .dateTimeFormatter(notificationRecord?.createdAt),
              fontSize: MediaQuery.of(context).size.width * 0.03,
            )
          ],
        )
      ],
    );
  }
}
