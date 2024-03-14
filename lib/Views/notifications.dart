import 'package:flutter_animate/flutter_animate.dart';
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
                                  if (notificationRecord?.objectType
                                              ?.toLowerCase() ==
                                          "owners" ||
                                      notificationRecord?.objectType
                                              ?.toLowerCase() ==
                                          "notice") {
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
                                child: notificationBody(notificationRecord)),
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

  Widget notificationBody(NotificationRecord? notificationRecord) {
    return const UnitsPage().roundedContainer(
        context, notificationContent(notificationRecord),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 5),
        color: kWhite);
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
                text: getNotificationName(
                    notificationRecord?.objectType?.toLowerCase()),
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

  String getNotificationName(String? value) {
    if (value == "shared_docs") return "Shared Document";
    if (value == "application") return "Request";
    if (value == "email_enquiry") return "Email Enquiry";
    if (value == "credit_memo") return "Credit Note";
    return value?.capitalize() ?? "";
  }
}
