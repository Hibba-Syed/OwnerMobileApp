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
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    webViewController.setNavigationDelegate(NavigationDelegate(
      onWebResourceError: (error) => setState(() {
        isLoading = false;
        isError = true;
      }),
      onPageFinished: (String url) {
        setState(() {
          isLoading = false;
        });
        Future.delayed(const Duration(seconds: 5), () {
          webViewController.runJavaScript(
              'document.getElementsByClassName("ant-btn")[1].style.display="none";');
        });
      },
    ));
    webViewController.loadRequest(Uri.parse(
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String? ??
            ""));
    String communityName =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String? ??
            "";
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
                  if (isLoading)
                    const Center(
                      child: CircularProgressIndicator(),
                    ),
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
