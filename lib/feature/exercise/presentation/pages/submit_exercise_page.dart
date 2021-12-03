import 'dart:collection';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog2.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/open_image.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/data_course/delete_answer.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/data_course/edit_answer.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/presentation/manager/get_info_answer/get_info_answer_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/add_answer.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_exercise_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_description.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/list_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class SubmitExercisePage extends StatefulWidget {
  final String? titleExercise;
  final int? idExercise;
  final String? nameExercise;
  final String? allowSubmission;
  final int? idAnswer;
  final String? submissionDeadline;
  final String? descriptionExercise;
  static const String routeName = "/SubmitExercisePage";

  const SubmitExercisePage(
      {Key? key,
      this.titleExercise,
      this.idAnswer,
      this.idExercise,
      this.submissionDeadline,
      this.nameExercise,
      this.allowSubmission,
      this.descriptionExercise})
      : super(key: key);

  @override
  _SubmitExercisePageState createState() => _SubmitExercisePageState();
}

class _SubmitExercisePageState extends State<SubmitExercisePage> {
  TextEditingController? _controllerDescription;

  String? description;

  FilePickerResult? result;
  List<PlatformFile>? listFile;

  bool? isEdit;
  List<FileUpload>? tempList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      _controllerDescription = TextEditingController();
    });
    listFile = [];
    tempList = [];
    isEdit = false;
    description = "";
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: appBar(context: context, title: widget.titleExercise),
        body: widget.idAnswer != null
            ? BlocProvider(
                create: (_) => sl<GetInformationAnswerBloc>(),
                child: BlocBuilder<GetInformationAnswerBloc,
                    GetInformationAnswerState>(builder: (context, state) {
                  if (state is Empty) {
                    BlocProvider.of<GetInformationAnswerBloc>(context).add(
                      GetInformationAnswerEventE(
                          idAccount: appUser?.iId, idAnswer: widget.idAnswer),
                    );
                  } else if (state is Loaded) {
                    tempList = state.swagger!.data?.fileUpload!;

                    Size size = MediaQuery.of(context).size;
                    _controllerDescription = TextEditingController(
                        text: state.swagger!.data!.descriptionAnswer);

                    return state.swagger != null
                        ? SingleChildScrollView(
                            child: Container(
                              width: size.width,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: size.width / 25,
                                    right: size.width / 25,
                                    top: size.width / 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    inputDescription(
                                        title: "Online text",
                                        context: context,
                                        function: (value) {
                                          description = value;
                                        },
                                        textEditingController:
                                            _controllerDescription),
                                    SizedBox(
                                      height: size.width / 15,
                                    ),

                                    _uploadedFile(
                                        list: tempList,
                                        title:
                                            "Additional files (${state.swagger!.data?.fileUpload?.length})"),
                                    SizedBox(
                                      height: size.width / 25,
                                    ),
                                    // /// pick file từ máy
                                    // chooseFile(
                                    //     title: "Additional files",
                                    //     function: () async {
                                    //       result = await FilePicker.platform
                                    //           .pickFiles(allowMultiple: true);
                                    //       List<PlatformFile>? listFile1 = [];
                                    //
                                    //       if (result != null) {
                                    //         setState(() {
                                    //           listFile1 = result!.files;
                                    //         });
                                    //
                                    //         listFile!.addAll(listFile1!);
                                    //
                                    //         /// duyệt mảng chỉ show 1-1
                                    //         listFile = LinkedHashSet<
                                    //                     PlatformFile>.from(
                                    //                 listFile!)
                                    //             .toList();
                                    //       } else {
                                    //         // User canceled the picker
                                    //       }
                                    //     },
                                    //     context: context),
                                    //
                                    // /// show những file được chọn
                                    // ListFiles(
                                    //   list: listFile,
                                    // ),

                                    /// nút xac nhận
                                    (isEdit == false
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              accept(
                                                  content: "Edit",
                                                  color: Colors.amber,
                                                  context: context,
                                                  function: () {
                                                    setState(() {});
                                                    isEdit = !isEdit!;
                                                  }),
                                              accept(
                                                  content: "Remove",
                                                  color: Colors.red,
                                                  context: context,
                                                  function: () {
                                                    AlertDialog2.yesAbortDialog(
                                                        onPressed: () {
                                                          removeAnswer(
                                                              idAnswer: widget
                                                                  .idAnswer,
                                                              failure: () =>
                                                                  showCancelDelete(),
                                                              success: () =>
                                                                  showSuccessDelete());
                                                        },
                                                        title: "Delete answer",
                                                        body:
                                                            "Are you sure you want to remove the submission data?",
                                                        context: context);
                                                  }),
                                            ],
                                          )
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
                                                                SubmitExercisePage(
                                                                  idExercise: widget
                                                                      .idExercise,
                                                                  descriptionExercise:
                                                                      widget
                                                                          .descriptionExercise,
                                                                  submissionDeadline:
                                                                      widget
                                                                          .submissionDeadline,
                                                                  allowSubmission:
                                                                      widget
                                                                          .allowSubmission,
                                                                  nameExercise:
                                                                      widget
                                                                          .nameExercise,
                                                                  titleExercise:
                                                                      widget
                                                                          .titleExercise,
                                                                  idAnswer: widget
                                                                      .idAnswer,
                                                                )));
                                                  }),
                                              accept(
                                                  color: Colors.green,
                                                  context: context,
                                                  content: "Accept",
                                                  function: () {
                                                    setState(() {});
                                                    isEdit = false;
                                                    editAnswer(
                                                      idExercise:
                                                          widget.idExercise,
                                                      idAnswer: widget.idAnswer,
                                                      descriptionAnswer:
                                                          description,
                                                      listFile: listFile,
                                                      fileKeep: tempList,
                                                      success: () =>
                                                          showSuccessUpdate(),
                                                      failure: () =>
                                                          showCancelUpdate(),
                                                    );
                                                  }),
                                            ],
                                          )),
                                    SizedBox(
                                      height: size.width / 25,
                                    )
                                  ],
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
                }))
            : SingleChildScrollView(
                child: Container(
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: size.width / 25,
                        right: size.width / 25,
                        top: size.width / 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        inputDescription(
                            title: "Online text",
                            context: context,
                            function: (value) {
                              description = value;
                            },
                            textEditingController: _controllerDescription),
                        SizedBox(
                          height: size.width / 15,
                        ),

                        /// pick file từ máy
                        chooseFile(
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
                                listFile =
                                    LinkedHashSet<PlatformFile>.from(listFile!)
                                        .toList();
                              } else {
                                // User canceled the picker
                              }
                            },
                            context: context),

                        /// show những file được chọn
                        ListFiles(
                          list: listFile,
                        ),

                        /// nút xac nhận
                        accept(
                            content: "Accept",
                            context: context,
                            function: () {
                              /// gọi api thêm bài tập
                              addAnswer(
                                  idExercise: widget.idExercise,
                                  descriptionAnswer: description,
                                  success: () => showSuccess(),
                                  failure: () => showCancel(),
                                  listFile: listFile);
                              // }
                            }),
                      ],
                    ),
                  ),
                ),
              ));
  }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Failed submission");
  }

  void showSuccess() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);

          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailExercisePage(
                        nameExercise: widget.nameExercise,
                        allowSubmission: widget.allowSubmission,
                        submissionDeadline: widget.submissionDeadline,
                        descriptionExercise: widget.descriptionExercise,
                        idExercise: widget.idExercise,
                      )));
        },
        title: "SUCCESS",
        description: "Successful submission");
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
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailExercisePage(
                        nameExercise: widget.nameExercise,
                        allowSubmission: widget.allowSubmission,
                        submissionDeadline: widget.submissionDeadline,
                        descriptionExercise: widget.descriptionExercise,
                        idExercise: widget.idExercise,
                      )));
        },
        title: "SUCCESS",
        description: "Delete successful");
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
              height: list!.length + listFile!.length > 4
                  ? size.width / 1.4
                  : list.length * size.width / 6,
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
                  builder: (context) => SubmitExercisePage(
                        idAnswer: widget.idAnswer,
                        titleExercise: widget.titleExercise,
                        nameExercise: widget.nameExercise,
                        allowSubmission: widget.allowSubmission,
                        submissionDeadline: widget.submissionDeadline,
                        descriptionExercise: widget.descriptionExercise,
                        idExercise: widget.idExercise,
                      )));
        },
        title: "SUCCESS",
        description: "Update successful");
  }
}
