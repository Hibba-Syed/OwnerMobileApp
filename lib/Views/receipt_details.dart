import 'package:iskaanowner/Views/ledger.dart';
import 'package:iskaanowner/Views/shared_documnet.dart';

import '../Utils/utils.dart';

class ReceiptDetailsPage extends StatelessWidget {
  const ReceiptDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Receipt Details",
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
                text2: "Receipt No.RE001-23-00063",
              ),
              const Gap(10),
              const RowText(
                text: "Payment Method",
                text2: "Direct Deposit",
              ),
              const Gap(10),
              const RowText(
                text: "Payment Date: Nov 7, 2023",
                text2: "Receipt Date: Nov 7, 2023",
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
                      "Amount",
                    ]
                        .map((e) => const SharedDocumentPage()
                            .sharedDocumentDataColumn(e))
                        .toList(),
                    rows: [
                      {
                        "Account": "Access Card VAT",
                        "Description": "",
                        "Amount": "AED 10.48"
                      },
                      {
                        "Account": "Access Card",
                        "Description": "",
                        "Amount": "AED 9.52"
                      },
                      {
                        "Account": "Income Account",
                        "Description": "",
                        "Amount": "AED 9.52"
                      },
                      {
                        "Account": "",
                        "Description": "TOTAL",
                        "Amount": "AED 50.50"
                      },
                    ].map((e) => const LedgerPage().ledgerDataRow(e)).toList()),
              ),
              const Gap(10),
              const RowText(
                text: "PAID BY:",
                text2: "Hammad Ahmad",
              ),
              const Gap(10),
              const RowText(
                text: "PHONE:",
                text2: "923214252414",
              ),
              const Gap(10),
              const RowText(
                text: "EMAIL:",
                text2: "imhammadahmad94@gmail.com",
              ),
              const Gap(10),
              const RowText(
                text: "BANK ACCOUNT:",
                text2: "Current",
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );
  }
}
