import 'package:iskaanowner/Models/requests.dart';

import '../Blocs/App Theme/app_theme_cubit.dart';
import '../Utils/utils.dart';

class RequestsPage extends StatelessWidget {
  const RequestsPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? unitNumber =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String?;
    int? unitId =
        (ModalRoute.of(context)?.settings.arguments as List)[1] as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "$unitNumber - Requests",
        appBar: AppBar(),
        automaticallyImplyLeading: true,
        widgets: [
          IconButton(
              onPressed: () => const LedgerPage().showFilter(context,
                      child: filterView(), resetFunction: () {
                    context.read<RequestsCubit>().resetFilters();
                    context.read<RequestsCubit>().getRequests(context, unitId);
                    Navigator.pop(context);
                  }, applyFunction: () {
                    context.read<RequestsCubit>().getRequests(context, unitId);
                    Navigator.pop(context);
                  }),
              icon: Icon(
                Icons.filter_alt_outlined,
                color: context.read<AppThemeCubit>().state.primaryColor,
              ))
        ],
        appBarHeight: 50,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const CustomSearch(),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: BlocBuilder<RequestsCubit, RequestsState>(
                builder: (context, state) {
                  if (state.loadingState == LoadingState.loading) {
                    return const CustomLoader();
                  }
                  if (state.requestsModel?.applications?.isEmpty ?? true) {
                    return const CreditNotesPage().emptyList();
                  }
                  return ListView.builder(
                    itemCount: state.requestsModel?.applications?.length,
                    itemBuilder: (BuildContext context, int index) {
                      Application? application =
                          state.requestsModel?.applications?[index];
                      return InkWell(
                        onTap: () {
                          context.read<RequestDetailsCubit>().getRequestDetails(
                              context,
                              application?.id,
                              application?.applicationType);
                          String? routeName =
                              getRouteName(application?.applicationType);
                          if (routeName != null) {
                            Navigator.pushNamed(context, routeName, arguments: [
                              application?.id,
                              application?.reference,
                              application?.applicationType,
                            ]);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: kWhite,
                            boxShadow: [
                              BoxShadow(
                                  offset: const Offset(
                                    1,
                                    1,
                                  ),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  color: kGrey.shade200),
                            ],
                          ),
                          child: Column(
                            children: [
                              requestCardHeader(context, application),
                              const SizedBox(
                                height: 10,
                              ),
                              requestCardBody(context, application),
                              const SizedBox(
                                height: 10,
                              ),
                              requestCardFooter(context, application),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
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
            fontsize: 12,
          ),
          color: const Color(0xfff3f8fb),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        ),
        CustomText(
          text: const OccupantPage().dateTimeFormatter(application?.createdAt),
          fontsize: 12,
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
                fontsize: 12,
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
                  fontsize: 12,
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
              fontsize: 12,
              color: Colors.amber.shade100,
            ),
            const SizedBox(
              width: 10,
            ),
            const UnitsPage().roundedContainer(
              context,
              CustomText(
                text: application?.status ?? "No status",
                fontsize: 12,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              color: Colors.amber.shade100,
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
            const LedgerPage().filterDropdown(
              (state.requestsFiltersModel?.applicationType ?? [])
                ..insert(0, "Select"),
              onSelected: (requestType) => context
                  .read<RequestsCubit>()
                  .onChangeRequestType(requestType),
            ),
            const Gap(10),
            CustomText(
              text: "Select Status",
              color: context.read<AppThemeCubit>().state.primaryColor,
            ),
            const Gap(10),
            const LedgerPage().filterDropdown(
              (state.requestsFiltersModel?.status ?? [])..insert(0, "Select"),
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
}
