import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CustonWebview extends StatefulWidget {
  final String url;
  CustonWebview(this.url);
  @override
  _CustonWebviewState createState() => _CustonWebviewState();
}

class _CustonWebviewState extends State<CustonWebview> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final sh = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 247, 250),
        iconTheme: IconThemeData(
          color: const Color.fromRGBO(54, 158, 255, 1),
        ),
        title: Text('Webview',
            style: TextStyle(
              fontSize: 0.04 * sw,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            )),
        centerTitle: true,
      ),
      body: WebViewWidget(
        controller: _controller,
      ),
    );
  }
}
