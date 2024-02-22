import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/utils.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  bool isLoading = true;
  bool isError = false;
  final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  late String communityName;
  @override
  void initState() {
    super.initState();
    webViewController.setNavigationDelegate(NavigationDelegate(
      onWebResourceError: (error) => setState(() {
        isLoading = false;
        isError = true;
      }),
      onPageFinished: (String url) {
        setState(() {
          isLoading = false;
        });
      },
    ));
    communityName =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String? ??
            "";
    webViewController.loadRequest(Uri.parse(
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String? ??
            ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: const DashboardPage().appBar(context, text: communityName),
            ),
            Expanded(
              child: Stack(
                children: [
                  WebViewWidget(controller: webViewController),
                  if (isLoading) const CustomLoader()
                  // if (isError) const CreditNotesPage().emptyList(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
