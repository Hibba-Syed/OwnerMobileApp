import '../Utils/utils.dart';

class UnitFinancialPage extends StatelessWidget {
  const UnitFinancialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: "Financial summary",
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                width: MediaQuery.of(context).size.width * 0.4,
                text: "Export",
                function: () {},
                icon: const Icon(
                  Icons.document_scanner_outlined,
                  color: kWhite,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Table(
              border: TableBorder.all(color: primaryColor),
              children: [
                {
                  "community": "Community",
                  "unitNumber": "Unit Number",
                  "balance": "Balance",
                  "fontWeight": FontWeight.bold,
                  "color": primaryColor.withOpacity(0.1)
                },
                {
                  "community": "IT Plaza",
                  "unitNumber": "1009",
                  "balance": "500 AED",
                },
                {
                  "community": "Axis 8",
                  "unitNumber": "1008",
                  "balance": "900 AED",
                },
              ]
                  .map(
                    (e) => unitFinancialTableRow(e["community"] as String,
                        e["unitNumber"] as String, e["balance"] as String,
                        color: e["color"] as Color?,
                        fontWeight: e["fontWeight"] as FontWeight?),
                  )
                  .toList(),
            )
          ],
        ),
      ),
    );
  }

  TableRow unitFinancialTableRow(
      String community, String unitNumber, String balance,
      {FontWeight? fontWeight, Color? color}) {
    return TableRow(
      children: [
        Container(
          color: color,
          child: TableCell(
            child: CustomText(
              text: community,
              fontWeight: fontWeight,
            ),
          ),
        ),
        Container(
          color: color,
          child: TableCell(
            child: CustomText(
              text: unitNumber,
              fontWeight: fontWeight,
            ),
          ),
        ),
        Container(
          color: color,
          child: TableCell(
            child: CustomText(
              text: balance,
              fontWeight: fontWeight,
            ),
          ),
        ),
      ],
    );
  }
}
