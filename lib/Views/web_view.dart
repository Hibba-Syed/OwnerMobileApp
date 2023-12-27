import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/utils.dart';

class MyWebView extends StatefulWidget {
  const MyWebView({super.key});

  @override
  State<MyWebView> createState() => _MyWebViewState();
}

class _MyWebViewState extends State<MyWebView> {
  final WebViewController webViewController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);
  @override
  void dispose() {
    webViewController.removeJavaScriptChannel('flutter_inject');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    webViewController.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (url) => _startListeningForAntBtn(),
      onPageFinished: (String url) {
        print("finished: $url");
        webViewController.runJavaScript(
            'document.getElementsByClassName("ant-btn")[1].style.display="none";');
      },
    ));
    webViewController.loadRequest(Uri.parse(
        (ModalRoute.of(context)?.settings.arguments as List)[1] as String? ??
            ""));
    String communityName =
        (ModalRoute.of(context)?.settings.arguments as List)[0] as String? ??
            "";
    return Scaffold(
      appBar: BaseAppBar(
        title: communityName,
        appBar: AppBar(),
        widgets: const [],
        appBarHeight: 50,
        automaticallyImplyLeading: true,
      ),
      body: WebViewWidget(controller: webViewController),
    );
  }

  void _startListeningForAntBtn() {
    print("inside  ././././/n.//n");
    const checkAntBtnScript = '''
      var antBtnInterval = setInterval(function() {
        console.log("working");
        var antBtnElement = document.getElementsByClassName("ant-btn");
        if (antBtnElement) {
          clearInterval(antBtnInterval);
          window.flutter_inject.postMessage('AntBtnAvailable');
        }
      }, 100);
    ''';

    webViewController.runJavaScript(checkAntBtnScript);
    webViewController.setOnConsoleMessage((message) {
      print(message);
    });
    webViewController.addJavaScriptChannel(
      'flutter_inject',
      onMessageReceived: (message) {
        if (message.message == 'AntBtnAvailable') {
          print('Element with class "ant-btn" is now available.');
        }
      },
    );
  }
}
