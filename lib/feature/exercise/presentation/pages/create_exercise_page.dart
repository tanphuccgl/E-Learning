import 'dart:collection';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:file_picker/file_picker.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/add_exercise_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/pages/detail_course_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/accpect_button.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_description.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/input_title.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/list_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/type_point.dart';

class CreateExercisePage extends StatefulWidget {
  static const String routeName = "/CreateExercisePage";
  final String? idCourse;
  final String? nameCourse;

  const CreateExercisePage({Key? key, this.idCourse, this.nameCourse})
      : super(key: key);

  @override
  _CreateExercisePageState createState() => _CreateExercisePageState();
}

class _CreateExercisePageState extends State<CreateExercisePage> {
  TextEditingController? _controllerText;
  TextEditingController? _controllerDescription;
  String? nameExercise;
  String? description;
  String typePointValue = 'Point';
  TextEditingController? _controllerAllow;
  String? _valueChangedAallow;

  String _valueToValidAllow = '';
  String _valueSavedAllow = '';
  bool? isSwitchedAllow;
  TextEditingController? _controllerDue;
  String? _valueChangedDue;

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
      _valueChangedAallow = '';
      _valueChangedDue = '';

      _controllerText = TextEditingController();
      _controllerDescription = TextEditingController();

      _controllerAllow = TextEditingController(text: DateTime.now().toString());
      _controllerDue = TextEditingController(text: DateTime.now().toString());
    });
    listFile = [];
  }

  @override
  Widget build(BuildContext context) {
    setState(() {

    });
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: appBar(title: "Create New Exercise", context: context),
      body: SingleChildScrollView(
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
                /// Nhập tên bài tập
                inputName(
                    title: "Name Exercise",
                    function: (value) {
                      nameExercise = value;
                    },
                    context: context,
                    textEditingController: _controllerText,
                    hintText: "Input name"),
                SizedBox(
                  height: size.width / 20,
                ),
                /// Nhập mô tả
                inputDescription(
                    title: "Description",
                    context: context,
                    textEditingController: _controllerDescription,
                    function: (value) {
                      description = value;
                    }),
                SizedBox(
                  height: size.width / 20,
                ),
                /// cài đặt thời gian mở
                _pickDateTime(
                    controllerDateTime: _controllerAllow,
                    isSwitched: isSwitchedAllow,
                    valueChange: _valueChangedAallow,
                    valueSave: _valueSavedAllow,
                    valueToValidate: _valueToValidAllow,
                    label: "Allow submissions from",
                    functionDatetime: (val) => setState(() {
                          _valueChangedAallow = val;
                        }),
                    functionSwitch: (value) {
                      setState(() {
                        isSwitchedAllow = value;
                      });
                    }),
                /// cài đặt thời gian kết thúc
                _pickDateTime(
                    controllerDateTime: _controllerDue,
                    label: "Due date",
                    isSwitched: isSwitchedDue,
                    valueChange: _valueChangedDue,
                    functionDatetime: (val) => setState(() {
                          _valueChangedDue = val;
                        }),
                    valueSave: _valueSavedDue,
                    valueToValidate: _valueToValidDue,
                    functionSwitch: (value) {
                      setState(() {
                        isSwitchedDue = value;
                      });
                    }),
                /// chọn loại điểm 0 - điểm 10 ,1 - đạt/kh đạt
                typePoint(
                    function: (String? newValue) {
                      setState(() {
                        typePointValue = newValue!;
                      });
                    },
                    context: context,
                    typePointValue: typePointValue),
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
                        listFile = LinkedHashSet<PlatformFile>.from(listFile!)
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
                accpect(
                   content: "Accpect",
                    context: context,
                    function: () {
                      ///check nhập tên bài tập
                      if (nameExercise?.trim().length == 0 ||
                          nameExercise == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Input name Course"),
                        ));
                      } else {
                        print("aloww $_valueChangedAallow");
                        print("due $_valueChangedDue");
                        /// gọi api thêm bài tập
                        addExercise(
                            idCourse: widget.idCourse,
                            submissionDeadline:
                                /// bật nút mới gửi DateTime tới server
                            isSwitchedDue == true
                                ? (_valueChangedDue == ""
                                    ? DateTime.parse(DateTime.now().toString())
                                    : DateTime.parse("$_valueChangedDue"))
                                : null,
                            allowSubmission: isSwitchedAllow == true
                                ? (_valueChangedAallow == ""
                                    ? DateTime.parse(DateTime.now().toString())
                                    : DateTime.parse("$_valueChangedAallow"))
                                : null,
                            descriptionExercise: description,
                            titleExercise: nameExercise,
                            success: () => showSuccess(),
                            failure: () => showCancel(),
                            listFile: listFile);
                      }
                    }),
                SizedBox(
                  height: size.width / 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pickDateTime(
      {bool? isSwitched,
      String? valueChange,
      String? valueToValidate,
      String? valueSave,
      TextEditingController? controllerDateTime,
      Function(bool)? functionSwitch,
      Function(String)? functionDatetime,
      String? label}) {
    Size size = MediaQuery.of(context).size;

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
                // dateMask: 'dd MMMM, yyyy - hh:mm a',
                controller: controllerDateTime,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                //icon: Icon(Icons.event),
                dateLabelText: label,
                use24HourFormat: true,
                locale: Locale('en', 'US'),
                onChanged: functionDatetime,
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
            onChanged: functionSwitch,
            activeTrackColor: Colors.yellow,
            activeColor: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }

   /// chọn khóa học cần thêm bài tập
  // BlocProvider<GetCourseBloc> _dropNameCourse(BuildContext context) {
  //   return BlocProvider(
  //     create: (_) => sl<GetCourseBloc>(),
  //     child: Builder(builder: (context) {
  //       return Container(
  //         child: BodyGetCourse(
  //           changeWithPage: "CreateExercisePage",
  //         ),
  //       );
  //     }),
  //   );
  // }

  void showCancel() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "Failed exercise creation");
  }

  void showSuccess() {
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
                        widgetId: 2,
                        choosingPos: 2,
                      )));
        },
        title: "SUCCESS",
        description: "Create successful exercises");
  }
}
