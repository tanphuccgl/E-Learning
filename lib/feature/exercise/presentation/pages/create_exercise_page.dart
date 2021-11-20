import 'dart:collection';
import 'dart:io';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/page_routers.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/widgets/body_get_course.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/add_exercise_remote.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class CreateExercisePage extends StatefulWidget {
  static const String routeName = "/CreateExercisePage";
  final String? idCourse;

  const CreateExercisePage({Key? key, this.idCourse}) : super(key: key);

  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  TextEditingController? _controllerText;
  TextEditingController? _controllerDescription;
  String? nameCourse;
  String? description;
  String typePointValue = 'Point';
  TextEditingController? _controllerAllow;
  String _valueChangedAallow = '';
  String _valueToValidAllow = '';
  String _valueSavedAllow = '';
  bool? isSwitchedAllow;
  TextEditingController? _controllerDue;
  String _valueChangedDue = '';
  String _valueToValidDue = '';
  String _valueSavedDue = '';
  bool? isSwitchedDue;
  FilePickerResult? result;
  List<PlatformFile>? listFile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting("en", null);
    isSwitchedAllow = false;
    isSwitchedDue = false;
    Intl.defaultLocale = 'en_US';
    setState(() {
      _controllerText = TextEditingController();
      _controllerDescription = TextEditingController();

      _controllerAllow = TextEditingController(text: DateTime.now().toString());
      _controllerDue = TextEditingController(text: DateTime.now().toString());
    });
    listFile = [];
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: _appBar(title: "Create New Exercise"),
      body: SingleChildScrollView(
        child: Container(
          height: size.width / 0.37,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 25,
                right: size.width / 25,
                top: size.width / 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _nameExercise(title: "Name Exercise"),
                SizedBox(
                  height: size.width / 20,
                ),
                _descriptionExercise(title: "Description"),
                SizedBox(
                  height: size.width / 20,
                ),
                _dateTime(
                    controllerDateTime: _controllerAllow,
                    isSwitched: isSwitchedAllow,
                    valueChange: _valueChangedAallow,
                    valueSave: _valueSavedAllow,
                    valueToValidate: _valueToValidAllow,
                    label: "Allow submissions from",
                    function: (value) {
                      setState(() {
                        isSwitchedAllow = value;
                      });
                    }),
                _dateTime(
                    controllerDateTime: _controllerDue,
                    label: "Due date",
                    isSwitched: isSwitchedDue,
                    valueChange: _valueChangedDue,
                    valueSave: _valueSavedDue,
                    valueToValidate: _valueToValidDue,
                    function: (value) {
                      setState(() {
                        isSwitchedDue = value;
                      });
                    }),
                _typePoint(),
                _chooseFile(title: "Additional files"),
                _listFile(list: listFile),
                _accpect(list: listFile),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _accpect({List<PlatformFile>? list}) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: size.width / 20),
        child: Container(
          height: size.width / 10,
          width: size.width / 4,
          child: ElevatedButton(
            onPressed: () {
              addExercise(idCourse: widget.idCourse,
                  submissionDeadline: _valueChangedDue,
                  allowSubmission: _valueChangedAallow,
                  descriptionExercise: description,
                  titleExercise: nameCourse,

                  success: () => showSuccess(),
                  failure: () => showCancel(),
                  listFile
                  :list);
            },
            child: Text("Accpect"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            ),
          ),
        ),
      ),
    );
  }

  Widget _dateTime({bool? isSwitched,
    String? valueChange,
    String? valueToValidate,
    String? valueSave,
    TextEditingController? controllerDateTime,
    Function(bool)? function,
    String? label}) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      width: size.width,
      height: size.width / 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: size.width / 1.5,
            height: size.width / 5,
            child: DateTimePicker(
                type: DateTimePickerType.dateTime,
                dateMask: 'dd MMMM, yyyy - hh:mm a',
                controller: controllerDateTime,
                //initialValue: _initialValue,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                //icon: Icon(Icons.event),
                dateLabelText: label,
                use24HourFormat: false,
                locale: Locale('en', 'US'),
                onChanged: (val) =>
                    setState(() {
                      valueChange = val;
                      print(valueChange);
                    }),
                validator: (val) {
                  setState(() => valueToValidate = val ?? '');

                  return null;
                },
                onSaved: (val) {
                  setState(() => valueSave = val ?? '');
                }),
          ),
          Switch(
            value: isSwitched!,
            onChanged: function,
            activeTrackColor: Colors.yellow,
            activeColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

  void openFile({PlatformFile? file}) {
    OpenFile.open(file?.path);
  }

  Widget _listFile({List<PlatformFile>? list}) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      height: size.width / 1.4,
      width: size.width,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                openFile(file: list![index]);
              },
              child: Container(
                height: size.width / 7,
                width: size.width / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TypeFile.fileImage.contains(list![index].extension)
                        ? Container(
                      height: size.width / 10,
                      width: size.width / 10,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(
                                  File("${list[index].path}"),
                                  scale: 1),
                              fit: BoxFit.cover)),
                    )
                        : Container(
                      height: size.width / 10,
                      width: size.width / 10,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  "assets/icons/${thumbnail(
                                      image: list[index].extension)}"),
                              fit: BoxFit.cover)),
                    ),
                    SizedBox(
                      width: size.width / 15,
                    ),
                    _detailFile(file: list[index])
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: list!.length),
    );
  }

  Widget _detailFile({PlatformFile? file}) {
    Size size = MediaQuery
        .of(context)
        .size;
    final kb = file!.size / 1024;
    final mb = kb / 1024;
    final fileSize =
    mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} KB";
    return Container(
      height: size.width / 7,
      width: size.width / 1.4,
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
                style:
                TextStyle(color: Colors.black, fontSize: size.width / 25),
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

  String thumbnail({String? image}) {
    if (TypeFile.fileStorage.contains(image)) {
      return "files-and-folders.png";
    } else if (TypeFile.fileVideo.contains(image)) {
      return "video.png";
    } else if (TypeFile.fileSound.contains(image)) {
      return "file.png";
    } else if (TypeFile.fileSpreadsheet.contains(image)) {
      return "excel.png";
    } else if (TypeFile.fileDocument.contains(image)) {
      return "documents.png";
    } else if (image == TypeFile.fileText) {
      return "txt.png";
    } else {
      return "file(1).png";
    }
  }

  Widget _chooseFile({String? title}) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
        height: size.width / 8,
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title!,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: size.width / 20,
                      fontWeight: FontWeight.w600),
                ),
                Container(
                    height: size.width / 10,
                    width: size.width / 10,
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.3),
                        borderRadius:
                        BorderRadius.all(Radius.circular(size.width / 40))),
                    child: IconButton(
                      icon: Icon(
                        Icons.upload_file,
                        color: Colors.black,
                      ),
                      onPressed: () async {
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
                    ))
              ],
            ),
          ],
        ));
  }

  /// chọn loại điểm
  Widget _typePoint() {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      width: size.width / 1.7,
      height: size.width / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size.width / 24),
          border: Border.all(color: Colors.grey),
          color: Colors.lightBlueAccent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Type",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: size.width / 25,
                  fontWeight: FontWeight.w600)),
          Container(
            width: size.width / 3,
            height: size.width / 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width / 35),
                color: Colors.white),
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width / 20, right: size.width / 20),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: typePointValue,
                  icon: const Icon(Icons.arrow_downward),
                  iconSize: 24,
                  elevation: 16,
                  style: const TextStyle(color: Colors.deepPurple),
                  underline: Container(
                    height: 2,
                    color: Colors.deepPurpleAccent,
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      typePointValue = newValue!;
                    });
                  },
                  items: <String>['Point', 'Scale']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  /// chọn khóa học cần thêm bài tập
  BlocProvider<GetCourseBloc> _dropNameCourse(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetCourseBloc>(),
      child: Builder(builder: (context) {
        return Container(
          child: BodyGetCourse(
            changeWithPage: "CreateExercisePage",
          ),
        );
      }),
    );
  }

  Widget _descriptionExercise({String? title}) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      height: size.width / 1.7,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width / 20,
                fontWeight: FontWeight.w600),
          ),
          Container(
            height: size.width / 2,
            width: size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(size.width / 30),
                ),
                border: Border.all(color: Colors.grey, width: 2.0)),
            child: Padding(
              padding: EdgeInsets.all(size.width / 25),
              child: SingleChildScrollView(
                child: TextField(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(700),
                  ],
                  maxLines: 20,
                  decoration: InputDecoration(
                    hintText: "Input description",
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    fillColor: Colors.white,
                  ),
                  onChanged: (value) {
                    description = value;
                  },
                  controller: _controllerDescription,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameExercise({String? title}) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Container(
      height: size.width / 4.7,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title!,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: size.width / 20),
          ),
          TextField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(50),
            ],
            decoration: InputDecoration(
              hintText: "Input name",
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width / 30),
                borderSide: BorderSide(
                  color: Colors.blue,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(size.width / 30),
                borderSide: BorderSide(
                  color: Colors.grey,
                  width: 2.0,
                ),
              ),
            ),
            onChanged: (value) {
              nameCourse = value;
            },
            controller: _controllerText,
          ),
        ],
      ),
    );
  }

  AppBar _appBar({String? title}) {
    Size size = MediaQuery
        .of(context)
        .size;

    return AppBar(
      backgroundColor: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black, //change your color here
      ),
      title: Text(
        title!,
        style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: size.width / 20),
      ),
      centerTitle: true,
      elevation: 0,
    );
  }

  void showCancel() {
    var alert = new AlertDialog1(

      title: "ERROR",
      description: "The system is maintenance",
      onPressed: () {
        Navigator.pop(context);
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void showSuccess() {
    var alert = new AlertDialog1(

      title: "SUCCESS",
      description: "Change password successfully",
      onPressed: () {
        Navigator.pushReplacementNamed(context, PageRoutes.detailExercisePage);
      },
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }


}
