import 'dart:collection';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog2.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/open_image.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/parse_time.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/models/get_info_exercise_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/list_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/data_source/delete_lecture.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/data_source/edit_lecture.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_info_lecture_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/manager/get_info_lecture/get_info_lecture_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/pages/detail_lecture.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/presentation/pages/lecture_page.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

var dio = Dio();

class BodyDetailLecture extends StatefulWidget {
  final int? idLecture;
  final String? textDescription;
  final String? nameCourse;
  final String? idCourse;
  final String? nameLecture;

  const BodyDetailLecture(
      {Key? key,
      this.idLecture,
      this.nameLecture,
      this.textDescription,
      this.nameCourse,
      this.idCourse})
      : super(key: key);

  @override
  _BodyDetailLectureState createState() => _BodyDetailLectureState();
}

class _BodyDetailLectureState extends State<BodyDetailLecture> {
  List<PlatformFile>? listFile;
  final Dio dio = Dio();
  bool? isEdit;
  TextEditingController? textEditingController;
  String? textDescription;
  List<FileUpload>? tempList;
  FilePickerResult? result;
  String? nameLecture;
  TextEditingController? nameLecController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listFile = [];
    isEdit = false;
    textEditingController = TextEditingController(text: widget.textDescription);
    textDescription = '';
    tempList = [];
    nameLecture = "";
    nameLecController = TextEditingController(text: widget.nameLecture);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetInfoLectureBloc, GetInfoLectureState>(
        builder: (context, state) {
      if (state is Empty) {
        getDetailLecture();
      } else if (state is Loaded) {
        Size size = MediaQuery.of(context).size;
        tempList = state.data?.fileUpload!;

        return state.data != null
            ? Scaffold(
                backgroundColor: Colors.white,
                appBar: _appBar(
                    title: state.data?.nameLecture,
                    controller: nameLecController,
                    onChanged: (value) {
                      nameLecture = value;
                    }),
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
                                  : state.data?.descriptionLecture,
                              function: (value) {
                                textDescription = value;
                              },
                              textEditingController: textEditingController),
                          SizedBox(
                            height: size.width / 15,
                          ),

                          ///pick file and show
                          _uploadedFile(
                              list: tempList,
                              title:
                                  "Uploaded File (${state.data?.fileUpload?.length})"),
                          SizedBox(
                            height: size.width / 25,
                          ),
                          appUser?.role == "teacher"
                              ? (isEdit == false
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        accept(
                                            color: Colors.amber,
                                            context: context,
                                            content: "Edit",
                                            function: () {
                                              setState(() {});
                                              isEdit = !isEdit!;
                                            }),
                                        accept(
                                            color: Colors.red,
                                            context: context,
                                            content: "Remove",
                                            function: () {
                                              AlertDialog2.yesAbortDialog(
                                                  context: context,
                                                  title: "Delete Lecture",
                                                  body:
                                                      "You want to delete lecture ${state.data!.nameLecture}",
                                                  onPressed: () {
                                                    removeLecture(
                                                        idLecture:
                                                            widget.idLecture,
                                                        failure: () =>
                                                            showCancelDelete(),
                                                        success: () =>
                                                            showSuccessDelete());
                                                  });
                                            }),
                                      ],
                                    )

                                  ///   chua chinh link api
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        accept(
                                            color: Colors.red,
                                            context: context,
                                            content: "Cancel",
                                            function: () {
                                              setState(() {});
                                              isEdit = false;
                                              Navigator.pop(context);
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          DetailLecturePage(
                                                            idCourse:
                                                                widget.idCourse,
                                                            nameCourse: widget
                                                                .nameCourse,
                                                            idLecture: widget
                                                                .idLecture,
                                                            textDescription: widget
                                                                .textDescription,
                                                          )));
                                            }),
                                        accept(
                                            color: Colors.green,
                                            context: context,
                                            content: "Accept",
                                            function: () {
                                              setState(() {});
                                              isEdit = false;
                                              editLecture(
                                                  success: () =>
                                                      showSuccessUpdate(),
                                                  failure: () =>
                                                      showCancelUpdate(),
                                                  idCourse:
                                                      state.data?.idCourse,
                                                  nameLecture: nameLecture,
                                                  descriptionAnswer:
                                                      textDescription,
                                                  idLecture: widget.idLecture,
                                                  fileKeep: tempList,
                                                  listFile: listFile);
                                            }),
                                      ],
                                    ))
                              : SizedBox.shrink(),
                          SizedBox(
                            height: size.width / 20,
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
            isEdit == true
                ? chooseFile(
                    title: "Additional files",
                    function: () async {
                      result = await FilePicker.platform
                          .pickFiles(allowMultiple: true);
                      List<PlatformFile>? listFile1 = [];

                      if (result != null) {
                        setState(() {
                          listFile1 = result!.files;
                        });

                        listFile!.addAll(listFile1!);

                        /// duyệt mảng chỉ show 1-1
                        listFile = LinkedHashSet<PlatformFile>.from(listFile!)
                            .toList();
                      } else {
                        // User canceled the picker
                      }
                    },
                    context: context)
                : Text(
                    title!,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: size.width / 20,
                        fontWeight: FontWeight.w600),
                  ),
            SizedBox(
              height: size.width / 20,
            ),
            Container(
              width: size.width,
              height: (list!.length + listFile!.length) * size.width / 6,
              child: ListView(
                children: [
                  ListFiles(
                    list: listFile,
                    scrollPhysics: NeverScrollableScrollPhysics(),
                    isUpdate: isEdit == true ? false : true,
                  ),
                  _listFile(list: list),
                ],
              ),
            ),
          ],
        ));
  }

  Widget _listFile({List<FileUpload>? list}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,

      ///  widget.list!.length > 4 ? size.width / 1.4 : widget.list!.length * size.width / 6,
      height: list!.length * size.width / 6,
      child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
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
                    isEdit == false
                        ? IconButton(
                            icon: Icon(Icons.arrow_circle_down),
                            onPressed: () {
                              setState(() {
                                downloadFile(
                                    url: list[index].pathname,
                                    namefile: list[index].originalname);
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.cancel),
                            onPressed: () {
                              setState(() {
                                list.remove(list[index]);
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
          ),
        ],
      ),
    );
  }

  Widget _content(
      {String? content,
      TextEditingController? textEditingController,
      Function(String?)? function}) {
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
                color: Colors.redAccent.withOpacity(0.3),
                width: size.width / 100)),
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
                    TextField(
                      controller: textEditingController,
                      onChanged: function,
                      enabled: isEdit == true ? true : false,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
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
        color: Colors.redAccent.withOpacity(0.3),
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

  PreferredSize _appBar(
      {String? title,
      TextEditingController? controller,
      Function(String?)? onChanged}) {
    Size size = MediaQuery.of(context).size;

    return PreferredSize(
      preferredSize: Size.fromHeight(size.width / 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: isEdit == false
            ? Text(
                title!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: size.width / 15),
              )
            : TextField(
                controller: controller,
                maxLines: 1,
                onChanged: onChanged!,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width / 20,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w700),
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

  void showCancelUpdate() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Update failed");
  }

  void showSuccessUpdate() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailLecturePage(
                        textDescription: widget.textDescription,
                        idLecture: widget.idLecture,
                      )));
        },
        title: "SUCCESS",
        description: "Update successful");
  }

  void showCancelDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Delete failed");
  }

  void showSuccessDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailCoursePage(
                        idCourse: widget.idCourse,
                        nameCourse: widget.nameCourse,
                        widgetId: 1,
                        choosingPos: 1,
                      )));
        },
        title: "SUCCESS",
        description: "Delete successful");
  }
}
