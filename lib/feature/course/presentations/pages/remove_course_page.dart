import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class Item extends GetCourseData {
  Item({
    this.isSelected,
  });

  bool? isSelected;
}

class RemoveCoursePage extends StatefulWidget {
  static const String routeName = "/RemoveCoursePage";

  @override
  State<StatefulWidget> createState() {
    return RemoveCoursePageState();
  }
}

class RemoveCoursePageState extends State<RemoveCoursePage> {
  List<Item> _items = [];
  int _sortColumnIndex = 0;
  bool _sortAscending = true;
  List a = [];

  // @override
  // void initState() {
  //   super.initState();
  //   setState(() {
  //     _items = _generateItems();
  //   });
  // }

  List<Item> _generateItems({List<GetCourseData>? list}) {
    return List.generate(list!.length, (int index) {
      return Item(
        isSelected: false,
      );
    });
  }

  void updateSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(
        label: const Text('No'),
        numeric: false, // Deliberately set to false to avoid right alignment.
      ),
      DataColumn(
        label: const Text('Name Course'),
        numeric: false,
        tooltip: 'Name of the item',
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort((item1, item2) =>
                item1.nameCourse!.compareTo(item2.nameCourse!));
          } else {
            _items.sort((item1, item2) =>
                item2.nameCourse!.compareTo(item1.nameCourse!));
          }

          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),
      DataColumn(
        label: const Text('Teacher'),
        numeric: false, // Deliberately set to false to avoid right alignment.
        tooltip: 'Price of the item',
        onSort: (int columnIndex, bool ascending) {
          if (ascending) {
            _items.sort(
                (item1, item2) => item1.fullName!.compareTo(item2.fullName!));
          } else {
            _items.sort(
                (item1, item2) => item2.fullName!.compareTo(item1.fullName!));
          }

          setState(() {
            _sortColumnIndex = columnIndex;
            _sortAscending = ascending;
          });
        },
      ),
      // DataColumn(
      //   label: const Text('Description'),
      //   numeric: false,
      //   tooltip: 'Description of the item',
      // ),
    ];
  }

  // DataRow _createRow() {
  //   return DataRow(
  //     // index: item.id, // for DataRow.byIndex
  //     key: ValueKey(item.iId),
  //     selected: item.isSelected,
  //     onSelectChanged: (bool? isSelected) {
  //       if (isSelected != null) {
  //         item.isSelected = isSelected;
  //
  //         setState(() {});
  //       }
  //     },
  //     color: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
  //         states.contains(MaterialState.selected)
  //             ? Colors.red
  //             : Color.fromARGB(100, 215, 217, 219)),
  //     cells: [
  //       DataCell(
  //         Text(item.iId.toString()),
  //       ),
  //       DataCell(
  //         Text(item!.fullName!),
  //         placeholder: false,
  //         showEditIcon: true,
  //         onTap: () {
  //           print('onTap');
  //         },
  //       ),
  //       DataCell(Text(item!.fullName!)),
  //       // DataCell(
  //       //   Text(item.description),
  //       // ),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCourseBloc, GetCourseState>(
        builder: (context, state) {
      if (state is Empty) {
        BlocProvider.of<GetCourseBloc>(context)
            .add(GetCourseEventE(idAccount: "", keySearchNameCourse: ""));
      } else if (state is Loaded) {
        for (var item in state.data!) {
          final Map fieldsMapOne = {
            'fullName': "${item.fullName}",
            'nameCourse': "${item.nameCourse}",
            'createDate': "${item.createDate}",
            'role': "${item.role}",
            'idAccount': "${item.idAccount}",
            'idCourse': "${item.idCourse}",
            'deleted': "${item.deleted}",
            'iId': "${item.iId}",
            'isSelected': false,
          };
          a = [...a, fieldsMapOne];
        }

        return Scaffold(
            appBar: appBar(context: context, title: "Remove Course"),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: DataTable(
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  columnSpacing: 0,
                  dividerThickness: 5,
                  onSelectAll: (bool? isSelected) {
                    if (isSelected != null) {
                      a.forEach((item) {
                        item['isSelected'] = isSelected;
                      });

                      setState(() {});
                    } else {
                      isSelected = false;
                      a.forEach((item) {
                        item['isSelected'] = isSelected;
                      });
                    }
                    print(isSelected);
                  },
                  dataRowColor: MaterialStateColor.resolveWith(
                      (Set<MaterialState> states) =>
                          states.contains(MaterialState.selected)
                              ? Colors.blue
                              : Color.fromARGB(100, 215, 217, 219)),
                  dataRowHeight: 80,
                  dataTextStyle: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.black),
                  headingRowColor: MaterialStateColor.resolveWith(
                      (states) => Colors.lightBlueAccent),
                  headingRowHeight: 80,
                  headingTextStyle: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                  horizontalMargin: 10,
                  showBottomBorder: true,
                  showCheckboxColumn: true,
                  columns: _createColumns(),
                  rows: a.map((item) {
                    return DataRow(
                      // index: item.id, // for DataRow.byIndex

                      selected: item['isSelected'],
                      onSelectChanged: (bool? isSelected) {
                        if (isSelected != null) {
                          item['isSelected'] = isSelected;

                          setState(() {});
                        }
                      },
                      color: MaterialStateColor.resolveWith(
                          (Set<MaterialState> states) =>
                              states.contains(MaterialState.selected)
                                  ? Colors.red
                                  : Color.fromARGB(100, 215, 217, 219)),
                      cells: [
                        DataCell(
                          Text(item['iId']),
                        ),
                        DataCell(
                          Text(item['nameCourse']),
                          placeholder: false,
                          showEditIcon: true,
                          onTap: () {
                            print('onTap');
                          },
                        ),
                        DataCell(Text(item['fullName'])),
                        // DataCell(
                        //   Text(item.description),
                        // ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ));
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
}
