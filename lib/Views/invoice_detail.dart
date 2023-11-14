import 'package:iskaanowner/Views/ledger.dart';
import 'package:iskaanowner/Views/shared_documnet.dart';

import '../Utils/utils.dart';

class InvoiceDetailsPage extends StatelessWidget {
  const InvoiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Invoice Details",
        appBar: AppBar(),
        widgets: const [],
        automaticallyImplyLeading: true,
        appBarHeight: 50,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: kGrey.shade100),
                child: const Icon(
                  Icons.person_outline,
                  size: 30,
                ),
              ),
              const Gap(10),
              const CustomText(
                text: "Community Management Company",
                fontWeight: FontWeight.bold,
                fontsize: 18,
              ),
              const Gap(10),
              const CustomText(
                  text:
                      "1004 IT Plaza Dubai Silicon Oasis, P.O. Box 12345, Dubai, United"),
              const Gap(10),
              const CustomText(text: "Arab Emirates"),
              const Gap(10),
              const CustomText(
                text: "Hill Palace",
                fontWeight: FontWeight.bold,
                fontsize: 18,
              ),
              const Gap(10),
              const CustomText(
                  text: "Silicon Oasis, Dubai, United Arab Emirates"),
              const Gap(10),
              const CustomText(text: "Email:lhe-test1@iskaan.net"),
              const Gap(10),
              const CustomText(
                text: "TRN: 1234567890",
                fontWeight: FontWeight.bold,
                fontsize: 18,
              ),
              const Gap(10),
              const RowText(
                text: "Unit: 101",
                text2: "Tax Invoice",
              ),
              const Gap(10),
              const RowText(
                text: "Owner Name: Hammad Ahmad",
                text2: "Invoice No: IN001-23-00105",
              ),
              const Gap(10),
              const RowText(
                text: "Owner Email: imhammadahmad94@gmail.com",
                text2: "Invoice Date: Nov 2, 2023",
              ),
              const Gap(10),
              const RowText(
                text: "Owner TRN:",
                text2: "Due Date: Dec 2, 2023",
              ),
              const Gap(10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => primaryColor.withOpacity(0.1)),
                    border: TableBorder.all(color: primaryColor),
                    columns: [
                      "Account",
                      "Description",
                      "VAT",
                      "Amount",
                    ]
                        .map((e) => const SharedDocumentPage()
                            .sharedDocumentDataColumn(e))
                        .toList(),
                    rows: [
                      {
                        "Account": "Card",
                        "Description": "",
                        "VAT": "AED 0.50",
                        "Amount": "AED 10.00"
                      },
                      {
                        "Account": "",
                        "Description": "Sub Total	",
                        "VAT": "AED 0.50",
                        "Amount": "AED 10.00"
                      },
                      {
                        "Account": "TOTAL",
                        "Description": "",
                        "VAT": "",
                        "Amount": "AED 10.50"
                      },
                    ].map((e) => const LedgerPage().ledgerDataRow(e)).toList()),
              )
            ],
          ),
        ),
      ),
    );
  }
}
