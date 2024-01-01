import 'package:iskaanowner/Blocs/Receipt%20details/receipt_details_cubit.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class ReceiptDetailsPage extends StatelessWidget {
  const ReceiptDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? receiptId = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "Receipt Details",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: BlocBuilder<ReceiptDetailsCubit, ReceiptDetailsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          return RefreshIndicator(
            onRefresh: ()async{
              context.read<ReceiptDetailsCubit>().getReceiptDetails(context, receiptId);
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: kGrey.shade100),
                          child: const Icon(
                            Icons.person_outline,
                            size: 30,
                          ),
                        ),
                        const Gap(10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: context
                                        .read<ProfileCubit>()
                                        .state
                                        .profileModel
                                        ?.record
                                        ?.company
                                        ?.name ??
                                    "",
                                fontWeight: FontWeight.bold,
                                fontsize: 18,
                                textAlign: TextAlign.left,
                              ),
                              const Gap(10),
                              CustomText(
                                text: context
                                        .read<ProfileCubit>()
                                        .state
                                        .profileModel
                                        ?.record
                                        ?.company
                                        ?.address1 ??
                                    "",
                                textAlign: TextAlign.left,
                                fontsize: 12,
                                color: kGrey,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Gap(10),
                    CustomText(
                      text: "Details",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const Gap(10),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: kWhite,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: kGrey.shade200,
                            blurRadius: 2,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomText(
                                  text: state.receiptDetailsModel?.title ?? "",
                                  fontWeight: FontWeight.bold,
                                  fontsize: 18,
                                ),
                              ),
                              const Gap(10),
                              CustomText(
                                text: state
                                        .receiptDetailsModel?.association?.name ??
                                    "",
                                fontsize: 12,
                                color: kGrey,
                              ),
                            ],
                          ),
                          const Divider(),
                          const Gap(10),
                          RowText(
                            text: "TRN:",
                            text2: state.receiptDetailsModel?.association
                                    ?.trnNumber ??
                                "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Unit:",
                            text2: state.receiptDetailsModel?.unitwise?[0].name ??
                                "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Receipt No.",
                            text2: state.receiptDetailsModel?.reference ?? "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Payment Method:",
                            text2: state.receiptDetailsModel?.paymentMethod ?? "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Payment Date:",
                            text2: const OccupantPage().dateTimeFormatter(
                                state.receiptDetailsModel?.paymentDate),
                          ),
                          const Gap(10),
                          RowText(
                            text: "Receipt Date:",
                            text2: const OccupantPage().dateTimeFormatter(
                                state.receiptDetailsModel?.datetime),
                          ),
                          const Gap(10),
                          RowText(
                            text: "Paid by:",
                            text2: state.receiptDetailsModel?.unitwise?[0].owner
                                    ?.fullName ??
                                "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Phone:",
                            text2: state.receiptDetailsModel?.unitwise?[0].owner
                                    ?.mobile ??
                                "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Email:",
                            text2: state.receiptDetailsModel?.unitwise?[0].owner
                                    ?.email ??
                                "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Bank account:",
                            text2: state.receiptDetailsModel?.account?.type,
                          ),
                        ],
                      ),
                    ),
                    const Gap(10),
                    CustomText(
                      text: "Transactions",
                      color: context.read<AppThemeCubit>().state.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                    const Gap(10),
                    Column(
                      children: state.receiptDetailsModel?.transactions
                              ?.map(
                                (e) => Container(
                                  margin: const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2,
                                          spreadRadius: 2,
                                          color: kGrey.shade200),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: CustomText(
                                              text: e.account?.title ?? "",
                                              fontWeight: FontWeight.bold,
                                              fontsize: 18,
                                            ),
                                          ),
                                          const Gap(10),
                                          Container(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: context
                                                      .read<AppThemeCubit>()
                                                      .state
                                                      .primaryColor
                                                      .withOpacity(0.2)),
                                              child: CustomText(
                                                  text: e.type?.capitalize() ??
                                                      "")),
                                        ],
                                      ),
                                      CustomText(
                                          text: e.description == "" ||
                                                  e.description == " "
                                              ? " -- "
                                              : e.description ?? " -- "),
                                      RowText(
                                        text: "Amount",
                                        text2: formatCurrency(e.amount ?? 0),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                              .toList() ??
                          [],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}
