import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/data/models/get_all_teacher_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_state.dart';

class Item extends GetAllTeacherData {
  Item({
    this.isSelected,
  });

  bool? isSelected;
}

class DeleteTeacherPage extends StatefulWidget {
  final String? title;
  static const String routeName = "/DeleteTeacherPage";

  DeleteTeacherPage({this.title});

  @override
  State<StatefulWidget> createState() {
    return DeleteTeacherPageState();
  }
}

class DeleteTeacherPageState extends State<DeleteTeacherPage> {
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

  List<Item> _generateItems({List<GetAllTeacherData>? list}) {
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
        label: const Text('Username'),
        numeric: false,
        tooltip: 'Name of the item',
        // onSort: (int columnIndex, bool ascending) {
        //   if (ascending) {
        //     _items.sort((item1, item2) =>
        //         item1.nameCourse!.compareTo(item2.nameCourse!));
        //   } else {
        //     _items.sort((item1, item2) =>
        //         item2.nameCourse!.compareTo(item1.nameCourse!));
        //   }
        //
        //   setState(() {
        //     _sortColumnIndex = columnIndex;
        //     _sortAscending = ascending;
        //   });
        // },
      ),
      DataColumn(
        label: const Text('Full Name'),
        numeric: false, // Deliberately set to false to avoid right alignment.
        tooltip: 'Price of the item',
        // onSort: (int columnIndex, bool ascending) {
        //   if (ascending) {
        //     _items.sort(
        //             (item1, item2) => item1.fullName!.compareTo(item2.fullName!));
        //   } else {
        //     _items.sort(
        //             (item1, item2) => item2.fullName!.compareTo(item1.fullName!));
        //   }
        //
        //   setState(() {
        //     _sortColumnIndex = columnIndex;
        //     _sortAscending = ascending;
        //   });
        // },
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
    return BlocBuilder<GetAllTeacherBloc, GetAllTeacherState>(
        builder: (context, state) {
      if (state is Empty) {
        BlocProvider.of<GetAllTeacherBloc>(context).add(GetAllTeacherE());
      } else if (state is Loaded) {
        Map fieldsMapOne = {};
        for (var item in state.data!) {
          fieldsMapOne = {
            "address": "${item.address}",
            "dateBirth": "${item.dateBirth}",
            "phoneNumber": "${item.phoneNumber}",
            "parentName": "${item.parentName}",
            "phoneNumberParent": "${item.phoneNumberParent}",
            "email": "${item.email}",
            "tokenResetPassword": "${item.tokenResetPassword}",
            "_id": "${item.iId}",
            "fullName": "${item.fullName}",
            "idClass": "${item.idClass}",
            "nameClass": "${item.nameClass}",
            "role": "${item.role}",
            "username": "${item.username}",
            "password": "${item.password}",
            "gender": "${item.gender}",
            "avatar": "${item.avatar}",
            "createDate": "${item.createDate}",
            "deleted": "${item.deleted}",
            "__v": 0,
            'isSelected': false,
          };
          a = [...a, fieldsMapOne];
        }

        return Scaffold(
            appBar: appBar(context: context, title: widget.title),
            body: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: DataTable(
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  columnSpacing: 0,
                  dividerThickness: 5,
                  onSelectAll: (bool? isSelected) {
                    isSelected = false;
                    a.forEach((item) {
                      item['isSelected'] = isSelected;
                    });

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
                          Text(item['_id']),
                        ),
                        DataCell(
                          Text(item['username']),
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
