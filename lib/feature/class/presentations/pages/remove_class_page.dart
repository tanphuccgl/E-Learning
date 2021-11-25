

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';


class Item extends GetAllClassData {
  Item({
    this.isSelected,
  });

  bool? isSelected;
}

class RemoveClassPage extends StatefulWidget {
  static const String routeName = "/RemoveClassPage";

  @override
  State<StatefulWidget> createState() {
    return RemoveClassPageState();
  }
}

class RemoveClassPageState extends State<RemoveClassPage> {
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

  List<Item> _generateItems({List<GetAllClassData>? list}) {
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
        label: const Text('Name Class'),
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
        label: const Text('Grade Class'),
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
    return BlocBuilder<GetAllClassBloc, GetAllClassState>(
        builder: (context, state) {
          if (state is Empty) {
            BlocProvider.of<GetAllClassBloc>(context)
                .add(GetGetAllClassE());
          } else if (state is Loaded) {
            for (var item in state.data!) {
              final Map fieldsMapOne = {




                'nameClass': "${item.nameClass}",
                'lv': "${item.lv}",
                'deleted': "${item.deleted}",
                'iId': "${item.iId}",
                'isSelected': false,
              };
              a = [...a, fieldsMapOne];
            }

            return Scaffold(
                appBar: appBar(context: context, title: "Remove Class"),
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
                              Text(item['iId']),
                            ),
                            DataCell(
                              Text(item['nameClass']),
                              placeholder: false,
                              showEditIcon: true,
                              onTap: () {
                                print('onTap');
                              },
                            ),
                            DataCell(Text(item['lv'])),
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
