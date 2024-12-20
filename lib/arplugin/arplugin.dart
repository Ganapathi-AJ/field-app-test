// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:permission_handler/permission_handler.dart';

// class WebViewPage extends StatefulWidget {
//   final String url;

//   const WebViewPage({Key? key, required this.url}) : super(key: key);

//   @override
//   State<WebViewPage> createState() => _WebViewPageState();
// }

// class _WebViewPageState extends State<WebViewPage> {
//   InAppWebViewController? _webViewController;
//   bool _permissionGranted = false;

//   @override
//   void initState() {
//     super.initState();
//     _requestCameraPermission();
//   }

//   Future<void> _requestCameraPermission() async {
//     final status = await Permission.camera.request();
//     setState(() {
//       _permissionGranted = status.isGranted;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.black,
//       ),
//       body: _permissionGranted
//           ? InAppWebView(
//               initialUrlRequest: URLRequest(url: WebUri(widget.url)),
//               initialOptions: InAppWebViewGroupOptions(
//                 crossPlatform: InAppWebViewOptions(
//                   mediaPlaybackRequiresUserGesture: false,
//                 ),
//                 ios: IOSInAppWebViewOptions(
//                   allowsInlineMediaPlayback: true,
//                 ),
//               ),
//               onWebViewCreated: (controller) {
//                 _webViewController = controller;
//               },
//               androidOnPermissionRequest:
//                   (controller, origin, resources) async {
//                 return PermissionRequestResponse(
//                     resources: resources,
//                     action: PermissionRequestResponseAction.GRANT);
//               },
//             )
//           : const Center(
//               child: Text('Camera permission is required to use this feature'),
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
// import 'package:flutter_unity_widget/flutter_unity_widget.dart';

class UnityDemoScreen extends StatefulWidget {
  const UnityDemoScreen({Key? key}) : super(key: key);

  @override
  State<UnityDemoScreen> createState() => _UnityDemoScreenState();
}

class _UnityDemoScreenState extends State<UnityDemoScreen> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  // UnityWidgetController? _unityWidgetController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      // body: WillPopScope(
      //   onWillPop: () async {
      //     // Pop the category page if Android back button is pressed.
      //     return true;
      //   },
      //   child: Container(
      //     color: Colors.yellow,
      //     child: UnityWidget(
      //       onUnityCreated: onUnityCreated,
      //     ),
      //   ),
      // ),
    );
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    // _unityWidgetController = controller;
  }
}
