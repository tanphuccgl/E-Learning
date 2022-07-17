import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';

class ListFiles extends StatefulWidget {
  final bool? isUpdate;
  final ScrollPhysics? scrollPhysics;
  final List<PlatformFile>? list;

  const ListFiles({
    Key? key,
    this.scrollPhysics = null,
    this.list,
    this.isUpdate = false,
  }) : super(key: key);

  @override
  ListFilesState createState() => ListFilesState();
}

class ListFilesState extends State<ListFiles> {
  final Dio dio = Dio();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: widget.list!.length > 4
          ? size.width / 1.4
          : widget.list!.length * size.width / 6,
      width: size.width,
      child: ListView.separated(
          physics: widget.scrollPhysics,
          reverse: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                openFile(file: widget.list?[index]);
              },
              child: Container(
                height: size.width / 7,
                width: size.width / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TypeFile.fileImage
                                .contains(widget.list?[index].extension)
                            ? Container(
                                height: size.width / 10,
                                width: size.width / 10,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                            File("${widget.list?[index].path}"),
                                            scale: 1),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                height: size.width / 10,
                                width: size.width / 10,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/icons/${thumbnail(image: widget.list?[index].extension)}"),
                                        fit: BoxFit.cover)),
                              ),
                        SizedBox(
                          width: size.width / 15,
                        ),
                        _detailFile(
                            file: widget.list?[index], context: context),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      onPressed: () {
                        setState(() {
                          widget.isUpdate == false
                              ? widget.list?.remove(widget.list?[index])
                              : null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: widget.list!.length),
    );
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

  ///down file
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
          setState(() {});
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

  downloadFile({String? url, String? namefile}) async {
    setState(() {});

    bool downloaded = await saveFile(url!, "${namefile!}");
    if (downloaded) {
      showSuccess();
      print("File Downloaded");
    } else {
      showCancel();
      print("Problem Downloading File");
    }
    setState(() {});
  }
}

Widget _detailFile({PlatformFile? file, BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;
  final kb = file!.size / 1024;
  final mb = kb / 1024;
  final fileSize =
      mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} KB";
  return Container(
    height: size.width / 7,
    width: size.width / 1.7,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${file.name}",
          style: TextStyle(color: Colors.black, fontSize: size.width / 20),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width / 5,
              child: Text(
                "$fileSize",
                style:
                    TextStyle(color: Colors.black, fontSize: size.width / 25),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              width: size.width / 10,
            ),
            Text(
              "${file.extension}",
              style: TextStyle(color: Colors.black, fontSize: size.width / 25),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        )
        // Text("${list[index].extension}"),
        // Text("$fileSize"),
      ],
    ),
  );
}
