import 'package:iskaanowner/Models/requests.dart';
import 'package:iskaanowner/Widgets/request_list_page.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Models/request_filters.dart';
import '../../Utils/utils.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    String? unitNumber = arguments['unit_no'];
    int? unitId = arguments['unit_id'];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              const DashboardPage().appBar(
                context,
                widget: CustomText(
                  text: "Unit $unitNumber - Requests",
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                ),
                trailingIcon: IconButton(
                  onPressed: () => const LedgerPage().showFilter(context,
                      child: filterView(), resetFunction: () {
                    context.read<RequestsCubit>().resetFilters();
                    context.read<RequestsCubit>().getRequests(context, unitId);
                    Navigator.pop(context);
                  }, applyFunction: () {
                    context.read<RequestsCubit>().getRequests(context, unitId);
                    Navigator.pop(context);
                  }),
                  icon: Image.asset(
                    "assets/filter.png",
                    scale: 4,
                  ),
                ),
              ),
              CustomSearch(
                initialValue: context.read<RequestsCubit>().state.keyword,
                fillColor: kWhite,
                onSubmitted: (value) {
                  context.read<RequestsCubit>().onChangeKeyword(value);
                  context.read<RequestsCubit>().getRequests(context, unitId);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: RequestListPage(
                  unitId: unitId,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestCardFooter(BuildContext context, Application? application) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const UnitsPage().roundedContainer(
          context,
          CustomText(
            text: "Reference#: ${application?.reference ?? " -- "}",
            fontSize: 12,
          ),
          color: const Color(0xfff3f8fb),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
        CustomText(
          text: const OccupantPage().dateTimeFormatter(application?.createdAt),
          fontSize: 12,
        )
      ],
    );
  }

  Widget requestCardBody(BuildContext context, Application? application) {
    return Row(
      children: [
        const UnitsPage().roundedContainer(
            context,
            Icon(
              Icons.person,
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            padding: const EdgeInsets.all(15),
            invert: true),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: const UnitsPage().roundedContainer(
            context,
            CustomText(text: application?.clientName ?? " -- "),
            padding: const EdgeInsets.all(15),
            color: kGrey.shade200,
            alignment: Alignment.centerLeft,
          ),
        )
      ],
    );
  }

  Widget requestCardHeader(BuildContext context, Application? application) {
    return Row(
      children: [
        const UnitsPage().roundedContainer(
          context,
          Row(
            children: [
              const Icon(
                Icons.delivery_dining_outlined,
                color: kWhite,
                size: 15,
              ),
              CustomText(
                text: " ${application?.applicationType ?? " -- "}",
                color: kWhite,
                fontSize: 12,
              )
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        ),
        const Gap(10),
        if (application?.clientPhone != null)
          const UnitsPage().roundedContainer(
            context,
            Row(
              children: [
                Icon(
                  Icons.phone_outlined,
                  color: context.read<AppThemeCubit>().state.primaryColor,
                  size: 15,
                ),
                CustomText(
                  text: " ${application?.clientPhone}",
                  color: context.read<AppThemeCubit>().state.primaryColor,
                  fontSize: 12,
                )
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            invert: true,
          ),
        const Spacer(),
        Row(
          children: [
            CustomText(
              text: "●",
              fontSize: 12,
              color: getStatusColor(application?.status),
            ),
            const SizedBox(
              width: 10,
            ),
            const UnitsPage().roundedContainer(
              context,
              CustomText(
                text: application?.status ?? "No status",
                fontSize: 12,
                color: getStatusColor(application?.status),
              ),
              invert: true,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              color: getStatusColor(application?.status),
            ),
          ],
        ),
      ],
    );
  }

  Widget filterView() {
    return BlocBuilder<RequestsFiltersCubit, RequestsFiltersState>(
      builder: (context, state) {
        if (state.loadingState == LoadingState.loading) {
          return SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              child: const CustomLoader());
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Select Request Type",
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(10),
            DropdownMenu<ApplicationType>(
              initialSelection: context.read<RequestsCubit>().state.requestType,
              hintText: "Select",
              expandedInsets: const EdgeInsets.all(0),
              onSelected: (requestType) => context
                  .read<RequestsCubit>()
                  .onChangeRequestType(requestType),
              dropdownMenuEntries: state.requestsFiltersModel?.applicationType
                      ?.map<DropdownMenuEntry<ApplicationType>>(
                    (ApplicationType value) {
                      return DropdownMenuEntry<ApplicationType>(
                        value: value,
                        label: value.name ?? "",
                      );
                    },
                  ).toList() ??
                  [],
            ),
            const Gap(10),
            CustomText(
              text: "Select Status",
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(10),
            const LedgerPage().filterDropdown(
              state.requestsFiltersModel?.status ?? [],
              initialSelection: context.read<RequestsCubit>().state.status,
              onSelected: (status) =>
                  context.read<RequestsCubit>().onChangeStatus(status),
            ),
          ],
        );
      },
    );
  }

  String? getRouteName(String? type) {
    if (type?.toLowerCase() == "ad") {
      return AppRoutes.adDetails;
    }
    if (type?.toLowerCase() == "fo") {
      return AppRoutes.foDetails;
    }
    if (type?.toLowerCase() == "ri") {
      return AppRoutes.riDetails;
    }
    if (type?.toLowerCase() == "wp") {
      return AppRoutes.wpDetails;
    }
    if (type?.toLowerCase() == "ss") {
      return AppRoutes.ssDetails;
    }
    if (type?.toLowerCase() == "cs") {
      return AppRoutes.csDetails;
    }
    if (type?.toLowerCase() == "hb") {
      return AppRoutes.hbDetails;
    }
    if (type?.toLowerCase() == "mo") {
      return AppRoutes.moDetails;
    }
    if (type?.toLowerCase() == "dp") {
      return AppRoutes.dpDetails;
    }
    if (type?.toLowerCase() == "tp") {
      return AppRoutes.tpDetails;
    }
    if (type?.toLowerCase() == "mi") {
      return AppRoutes.miDetails;
    }
    return null;
  }

  Color getStatusColor(String? status) {
    Color color = kGrey;
    status = status?.toLowerCase();
    if (status == "pending") {
      color = const Color(0xffffd550);
    }
    if (status == "rescheduled") {
      color = const Color(0xfff7a802);
    }
    if (status == "onhold") {
      color = const Color(0xffffc353);
    }
    if (status == "wait for documents") {
      color = const Color(0xff00c851);
    }
    if (status == "processed") {
      color = const Color(0xff00c851);
    }
    if (status == "approved") {
      color = const Color(0xff00c851);
    }
    if (status == "waiting for payment") {
      color = const Color(0xff9f9f9f);
    }
    if (status == "payment clear") {
      color = const Color(0xff00c851);
    }
    if (status == "notified") {
      color = const Color(0xff459eed);
    }
    if (status == "security clear") {
      color = const Color(0xff64d57e);
    }
    if (status == "refund") {
      color = const Color(0xff500886);
    }
    if (status == "noc issued") {
      color = const Color(0xffffd550);
    }
    if (status == "completed") {
      color = const Color(0xff73E12F);
    }
    if (status == "cancelled") {
      color = const Color(0xffff4444);
    }
    if (status == "declined") {
      color = const Color(0xffff4444);
    }
    return color;
  }

  Widget iconAndText(BuildContext context, String image, String? text,
      {FontWeight? fontWeight,
      MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start}) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Image.asset(
          image,
          width: MediaQuery.of(context).size.width * 0.04,
        ),
        const Gap(5),
        CustomText(
          text: text ?? "",
          fontWeight: fontWeight,
          fontSize: MediaQuery.of(context).size.width * 0.03,
          color: const Color(0xffB2B1B1),
        )
      ],
    );
  }
}
