import '../Utils/utils.dart';

class VerifyDocumentsPage extends StatelessWidget {
  const VerifyDocumentsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CustomButton(text: "Save", function: () {}),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage()
                  .appBar(context, text: "Verify Documents"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: "Id*",
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffB2B1B1),
                    fontSize: MediaQuery.of(context).size.width * 0.032,
                  ),
                  const Gap(10),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kGrey,
                    ),
                  ),
                  const Gap(10),
                  CustomText(
                    text: "Passport*",
                    fontWeight: FontWeight.bold,
                    color: const Color(0xffB2B1B1),
                    fontSize: MediaQuery.of(context).size.width * 0.032,
                  ),
                  const Gap(10),
                  Container(
                    height: MediaQuery.of(context).size.width * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: kGrey,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
