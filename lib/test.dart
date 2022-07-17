import 'dart:io';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class Test extends StatefulWidget {
  static const String routeName = "/Test";

  Test({Key? key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // body: Center(
        //   child: loading
        //       ? Padding(
        //           padding: const EdgeInsets.all(8.0),
        //           child: LinearProgressIndicator(
        //             minHeight: 10,
        //             value: progress,
        //           ),
        //         )
        //       : FlatButton.icon(
        //           icon: Icon(
        //             Icons.download_rounded,
        //             color: Colors.white,
        //           ),
        //           color: Colors.blue,
        //           onPressed: downloadFile,
        //           padding: const EdgeInsets.all(10),
        //           label: Text(
        //             "Download Video",
        //             style: TextStyle(color: Colors.white, fontSize: 25),
        //           )),

        );
  }
}
