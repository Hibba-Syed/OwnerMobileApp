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
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const DashboardPage().appBar(
                  context,
                  text: "Unit $unitNumber - Requests",
                  trailingIcon: IconButton(
                    onPressed: () => const LedgerPage().showFilter(context,
                        child: filterView(), resetFunction: () {
                      context.read<RequestsCubit>().resetFilters();
                      context
                          .read<RequestsCubit>()
                          .getRequests(context, unitId);
                      Navigator.pop(context);
                    }, applyFunction: () {
                      context
                          .read<RequestsCubit>()
                          .getRequests(context, unitId);
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
      ),
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
        return SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Select Request Type",
                color: context.read<AppThemeCubit>().state.primaryColor,
              ),
              const Gap(10),
              DropdownMenu<ApplicationType>(
                initialSelection:
                    context.read<RequestsCubit>().state.requestType,
                hintText: "Select",
                expandedInsets: const EdgeInsets.all(0),
                inputDecorationTheme:
                    const InputDecorationTheme(border: UnderlineInputBorder()),
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
          ),
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
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: mainAxisAlignment,
      children: [
        Image.asset(
          image,
          width: MediaQuery.of(context).size.width * 0.035,
          color: const Color(0xffB2B1B1),
        ),
        const Gap(2),
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
