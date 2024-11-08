// import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

// Instantiate the client
// final AgoraClient client = AgoraClient(
//   agoraConnectionData: AgoraConnectionData(
//     appId: "<--Add Your App Id Here-->",
//     channelName: "test",
//   ),
// );

class VideoCall extends StatefulWidget {
  const VideoCall({super.key});

  @override
  State<VideoCall> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCall> {
  @override
  void initState() {
    super.initState();
    initAgora();
  }

  void initAgora() async {
    // await client.initialize();
  }

// Build your layout
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // AgoraVideoViewer(client: client),
              // AgoraVideoButtons(client: client),
            ],
          ),
        ),
      ),
    );
  }
}
