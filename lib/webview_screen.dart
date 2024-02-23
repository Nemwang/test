import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({Key? key}) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController;
  late var url;
  double progress = 0;

  var urlController = TextEditingController();
  var initialUrl = "https://nrnanagoya.com/";

  Future<bool> _goBack(BuildContext context) async {
    if (await webViewController!.canGoBack()) {
      webViewController!.goBack();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () => _goBack(context),
        child: Column(
          children: [
            Expanded(
              child: InAppWebView(
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
                initialUrlRequest: URLRequest(url: Uri.parse(initialUrl)),
                pullToRefreshController: PullToRefreshController(
                  onRefresh: () async {
                    webViewController?.reload();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
