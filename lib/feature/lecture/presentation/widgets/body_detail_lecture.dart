import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/open_image.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/parse_time.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_info_lecture_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_state.dart';

var dio = Dio();

class BodyDetailLecture extends StatefulWidget {
  final int? idLecture;

  const BodyDetailLecture({Key? key, this.idLecture}) : super(key: key);

  @override
  _BodyDetailLectureState createState() => _BodyDetailLectureState();
}

class _BodyDetailLectureState extends State<BodyDetailLecture> {
  List<PlatformFile>? listFile;
  final Dio dio = Dio();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listFile = [];
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetInfoLectureBloc, GetInfoLectureState>(
        builder: (context, state) {
      if (state is Empty) {
        getDetailLecture();
      } else if (state is Loaded) {
        Size size = MediaQuery.of(context).size;

        return state.data != null
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: _appBar(title: state.data?.nameLecture),
                body: SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: size.width / 25,
                          right: size.width / 25,
                          top: size.width / 20),
                      child: Column(
                        children: [
                          ///khung giờ nộp bài
                          _header(time: state.data?.createDate),

                          /// mô tả
                          _content(
                              content: state.data?.descriptionLecture == null
                                  ? ""
                                  : state.data?.descriptionLecture),
                          SizedBox(
                            height: size.width / 15,
                          ),

                          ///pick file and show
                          _uploadedFile(
                              list: state.data?.fileUpload,
                              title:
                                  "Uploaded File (${state.data?.fileUpload?.length})"),
                          SizedBox(
                            height: size.width / 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            : Center(child: Text("Invail exercise"));
      } else if (state is Loading) {
        return SpinkitLoading();
      } else if (state is Error) {
        return Center(
          child: Text("Lỗi hệ thống"),
        );
      }
      return Container();
    });
  }

  void getDetailLecture() {
    BlocProvider.of<GetInfoLectureBloc>(context)
        .add(GetInfoLectureEventE(idLecture: widget.idLecture));
  }

  Widget _uploadedFile({List<FileUpload>? list, String? title}) {
    Size size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title!,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: size.width / 20,
            ),
            _listFile(list: list),
          ],
        ));
  }

  Widget _listFile({List<FileUpload>? list}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,

      ///  widget.list!.length > 4 ? size.width / 1.4 : widget.list!.length * size.width / 6,
      height:
          list!.length > 4 ? size.width / 1.4 : list.length * size.width / 6,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OpenImage(
                            url: list[index].pathname,
                            // file: list[index],
                            originalname: list[index].originalname,
                          )),
                );
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
                        TypeFile.fileImage.contains(
                                list[index].originalname?.split(".").last)
                            ? Container(
                                height: size.width / 10,
                                width: size.width / 10,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            "${list[index].pathname}"),
                                        fit: BoxFit.cover)),
                              )
                            : Container(
                                height: size.width / 10,
                                width: size.width / 10,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/icons/${thumbnail(image: list[index].originalname?.split(".").last)}"),
                                        fit: BoxFit.cover)),
                              ),
                        SizedBox(
                          width: size.width / 15,
                        ),
                        _detailFile(file: list[index]),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_circle_down),
                      onPressed: () {
                        setState(() {
                          downloadFile(
                              url: list[index].pathname,
                              namefile: list[index].originalname);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: list.length),
    );
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

  Widget _detailFile({FileUpload? file}) {
    Size size = MediaQuery.of(context).size;
    final kb = file!.size! / 1024;
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
            "${file.originalname}",
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
            ],
          )
          // Text("${list[index].extension}"),
          // Text("$fileSize"),
        ],
      ),
    );
  }

  Widget _content({String? content}) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.only(top: size.width / 15),
      child: Container(
        height: size.width / 2,
        width: size.width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(size.width / 30),
            ),
            color: Colors.grey.shade300.withOpacity(0.3),
            border: Border.all(
                color: Colors.cyan.withOpacity(0.3), width: size.width / 100)),
        child: Padding(
          padding: EdgeInsets.all(size.width / 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "Description",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width / 20,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                height: size.width / 3.2,
                child: ListView(
                  children: [
                    Text(
                      content!,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: size.width / 25,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _header({String? time}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.width / 6,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(size.width / 30),
        ),
        color: Colors.cyan.withOpacity(0.3),
      ),
      child: Padding(
        padding: EdgeInsets.all(size.width / 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Creation time: ${parseStringToTime(textTime: time)}",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize _appBar({String? title}) {
    Size size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size.fromHeight(size.width / 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          title!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: size.width / 15),
        ),
        centerTitle: true,
        elevation: 0,
      ),
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
}
