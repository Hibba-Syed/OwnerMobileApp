import '../../Utils/utils.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const DashboardPage().appBar(
              context,
                text: "Forgot Password",
            
            ),
          ],
        ),
      ),
    );
  }
}
