import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';

import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';

var dio = Dio();

class OpenImage extends StatefulWidget {
  final String? url;
  final Files? file;
  final String? originalname;

  const OpenImage({Key? key, this.url, this.file, this.originalname})
      : super(key: key);

  @override
  State<OpenImage> createState() => _OpenImageState();
}

class _OpenImageState extends State<OpenImage> {
  final Dio dio = Dio();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              downloadFile();
            },
          ),
        ],
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
            child: TypeFile.fileImage
                    .contains(widget.file!.originalname?.split(".").last)
                ? Image.network(
                    widget.url!,
                    fit: BoxFit.cover,
                  )
                : ElevatedButton(
                    child: Text(
                      "Download file",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      downloadFile();
                    })),
      ),
    );
  }

  Future<bool> saveFile(String url, String fileName) async {
    Directory directory;
    try {
      if (Platform.isAndroid) {
        if (await _requestPermission(Permission.storage)) {
          directory = (await getExternalStorageDirectory())!;
          String newPath = "";
          print(directory);
          List<String> paths = directory.path.split("/");
          for (int x = 1; x < paths.length; x++) {
            String folder = paths[x];
            if (folder != "Android") {
              newPath += "/" + folder;
            } else {
              break;
            }
          }
          newPath = newPath;
          print(newPath);
          directory = Directory(newPath);
        } else {
          return false;
        }
      } else {
        if (await _requestPermission(Permission.photos) &&
            await _requestPermission(Permission.accessMediaLocation) &&
            await _requestPermission(Permission.manageExternalStorage)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists()) {
        await dio.download(url, saveFile.path,
            onReceiveProgress: (value1, value2) {
          setState(() {
          });
        });
        if (Platform.isIOS) {
          await ImageGallerySaver.saveFile(saveFile.path,
              isReturnPathOfIOS: true);
        }
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var result = await permission.request();
      if (result == PermissionStatus.granted) {
        return true;
      }
    }
    return false;
  }

  downloadFile() async {
    setState(() {

    });
    print("${widget.url!}");
    print("${widget.originalname!}");
    bool downloaded = await saveFile(widget.url!, "${widget.originalname!}");
    if (downloaded) {
      showSuccess();
      print("File Downloaded");
    } else {
      showCancel();
      print("Problem Downloading File");
    }
    setState(() {

    });
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "File download failed");
  }

  void showSuccess() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => DetailCoursePage(
          //           idCourse: widget.idCourse,
          //           nameCourse: widget.nameCourse,
          //           widgetId: 2,
          //           choosingPos: 2,
          //         )));
        },
        title: "SUCCESS",
        description: "File download successful");
  }
}
