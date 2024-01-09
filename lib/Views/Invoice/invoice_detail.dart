import 'package:iskaanowner/Blocs/Invoice%20details/invoice_details_cubit.dart';
import 'package:iskaanowner/Widgets/image_builder.dart';

import '../../Blocs/App Theme/app_theme_cubit.dart';
import '../../Utils/utils.dart';

class InvoiceDetailsPage extends StatelessWidget {
  const InvoiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    int? invoiceId = ModalRoute.of(context)!.settings.arguments as int?;
    return Scaffold(
      appBar: BaseAppBar(
        title: "Invoice Details",
        appBar: AppBar(),
        widgets: [const DashboardPage().notificationIcon(context)],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: BlocBuilder<InvoiceDetailsCubit, InvoiceDetailsState>(
        builder: (context, state) {
          if (state.loadingState == LoadingState.loading) {
            return const CustomLoader();
          }
          if (state.invoiceDetailsModel == null) {
            return const CreditNotesPage().emptyList(
              ontap: () => context
                  .read<InvoiceDetailsCubit>()
                  .getInvoiceDetails(context, invoiceId),
            );
          }
          return RefreshIndicator(
            onRefresh: () async {
              context
                  .read<InvoiceDetailsCubit>()
                  .getInvoiceDetails(context, invoiceId);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
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
                          child: ImageBuilder(
                            url: context
                                    .read<ProfileCubit>()
                                    .state
                                    .profileModel
                                    ?.record
                                    ?.company
                                    ?.logoUrl ??
                                "",
                            // height: 40,
                            width: 40,
                            isFit: true,
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
                                fontSize: 18,
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
                                fontSize: 12,
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
                                  text: state.invoiceDetailsModel?.title ?? "",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const Gap(10),
                              CustomText(
                                text: state.invoiceDetailsModel?.association
                                        ?.name ??
                                    "",
                                fontSize: 12,
                                color: kGrey,
                              ),
                            ],
                          ),
                          const Divider(),
                          const Gap(10),
                          RowText(
                            text: "TRN:",
                            text2: state.invoiceDetailsModel?.association
                                    ?.trnNumber ??
                                "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Unit:",
                            text2:
                                state.invoiceDetailsModel?.invoiceable?.name ??
                                    "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Invoice No: ",
                            text2: state.invoiceDetailsModel?.reference ?? "",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Owner Name:",
                            text2: state.invoiceDetailsModel?.invoiceable?.owner
                                    ?.owner?.fullName ??
                                "",
                          ),
                          const Gap(10),
                          RowText(
                              text: "Owner Email:",
                              text2: context
                                      .read<ProfileCubit>()
                                      .state
                                      .profileModel
                                      ?.record
                                      ?.email ??
                                  " -- "),
                          const Gap(10),
                          RowText(
                            text: "Invoice Date:",
                            text2: const OccupantPage().dateTimeFormatter(
                                state.invoiceDetailsModel?.datetime),
                          ),
                          const Gap(10),
                          RowText(
                            text: "Owner TRN:",
                            text2: state.invoiceDetailsModel?.invoiceable?.owner
                                    ?.owner?.trnNumber ??
                                " -- ",
                          ),
                          const Gap(10),
                          RowText(
                            text: "Due Date:",
                            text2: const OccupantPage().dateTimeFormatter(
                                state.invoiceDetailsModel?.dueDate),
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
                    if (state.invoiceDetailsModel?.transactions?.isEmpty ??
                        true)
                      Container(
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
                        height: MediaQuery.of(context).size.height / 2,
                        child: const CreditNotesPage().emptyList(
                            message: "No transactions found",
                            ontap: () {
                              context
                                  .read<InvoiceDetailsCubit>()
                                  .getInvoiceDetails(context, invoiceId);
                            }),
                      ),
                    Column(
                      children: state.invoiceDetailsModel?.transactions
                              ?.map(
                                (e) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                              fontSize: 18,
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
                                                  .withOpacity(0.2),
                                            ),
                                            child: CustomText(
                                                text:
                                                    e.type?.capitalize() ?? ""),
                                          ),
                                        ],
                                      ),
                                      CustomText(
                                          text: e.description == "" ||
                                                  e.description == " "
                                              ? " -- "
                                              : e.description ?? " -- "),
                                      RowText(
                                        text: "Vat",
                                        text2: formatCurrency(e.vat ?? 0),
                                      ),
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
                    ),
                    if (state.invoiceDetailsModel?.transactions?.isNotEmpty ??
                        false)
                      const Gap(10),
                    if (state.invoiceDetailsModel?.transactions?.isNotEmpty ??
                        false)
                      RowText(
                        text: "Total : ",
                        text2: formatCurrency((state
                                    .invoiceDetailsModel?.transactions
                                    ?.map((e) => e.amount ?? 0)
                                    .toList() ??
                                [])
                            .reduce((value, element) => value + element)),
                      ),
                    const Gap(10),
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
