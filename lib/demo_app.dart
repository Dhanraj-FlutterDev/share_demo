import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;

class DemoApp extends StatefulWidget {
  const DemoApp({Key? key}) : super(key: key);

  @override
  _DemoAppState createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  final urlImage =
                      'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg';
                  final url = Uri.parse(urlImage);
                  final response = await http.get(url);
                  final bytes = response.bodyBytes;
                  final temp = await getTemporaryDirectory();
                  final path = '${temp.path}/image.jpg';
                  print(path);
                  File(path).writeAsBytesSync(bytes);
                  await Share.shareFiles([path],
                      text: 'images', subject: 'something to share');
                },
                child: const Text('share')),
          ),
          Center(
            child: ElevatedButton(
                onPressed: () async {
                  await Share.share('Share this Text',
                      subject: 'any subject if you have');
                },
                child: const Text('Share Text')),
          ),
        ],
      ),
    );
  }
}
