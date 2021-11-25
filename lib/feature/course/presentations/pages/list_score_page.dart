// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
// import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_teacher/get_point_teacher_bloc.dart';
// import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_teacher/get_point_teacher_event.dart';
// import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_point_teacher/get_point_teacher_state.dart';
// import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/models/list_teacher_response_model.dart';
//
// class Item extends Data {
//   Item({
//     this.isSelected,
//   });
//
//   bool? isSelected;
// }
//
// class ListScorePage extends StatefulWidget {
//   static const String routeName="/ListScorePage";
//   final String? idCourse;
//   const ListScorePage({Key? key,this.idCourse}) : super(key: key);
//
//   @override
//   _ListScorePageState createState() => _ListScorePageState();
// }
//
// class _ListScorePageState extends State<ListScorePage> {
//   int _sortColumnIndex = 0;
//   bool _sortAscending = true;
//   List a = [];
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<GetPointTeacherBloc, GetPointTeacherState>(
//         builder: (context, state) {
//           if (state is Empty) {
//             BlocProvider.of<GetPointTeacherBloc>(context).add(
//                 GetPointTeacherEventE(idCourse: widget.idCourse, ));
//
//           } else if (state is Loaded) {
//             for (var item in state.data2!) {
//               final Map fieldsMapOne = {
//
//
//
//
//                 'nameClass': "${item.fullName}",
//                 'lv': "${item.lv}",
//                 'deleted': "${item.deleted}",
//                 'iId': "${item.iId}",
//                 'isSelected': false,
//               };
//               a = [...a, fieldsMapOne];
//             }
//             return state.data!.isNotEmpty
//                 ?
//
//               SizedBox(
//                   width: MediaQuery.of(context).size.width,
//                   child: SingleChildScrollView(
//                     child: DataTable(
//                       sortColumnIndex: _sortColumnIndex,
//                       sortAscending: _sortAscending,
//                       columnSpacing: 0,
//                       dividerThickness: 5,
//                       onSelectAll: (bool? isSelected) {
//
//                         isSelected = false;
//                         a.forEach((item) {
//                           item['isSelected'] = isSelected;
//                         });
//
//                         print(isSelected);
//                       },
//                       dataRowColor: MaterialStateColor.resolveWith(
//                               (Set<MaterialState> states) =>
//                           states.contains(MaterialState.selected)
//                               ? Colors.blue
//                               : Color.fromARGB(100, 215, 217, 219)),
//                       dataRowHeight: 80,
//                       dataTextStyle: const TextStyle(
//                           fontStyle: FontStyle.italic, color: Colors.black),
//                       headingRowColor: MaterialStateColor.resolveWith(
//                               (states) => Colors.lightBlueAccent),
//                       headingRowHeight: 80,
//                       headingTextStyle: const TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.black),
//                       horizontalMargin: 10,
//                       showBottomBorder: true,
//                       showCheckboxColumn: true,
//                       columns: _createColumns(),
//                       rows: a.map((item) {
//                         return DataRow(
//                           // index: item.id, // for DataRow.byIndex
//
//                           selected: item['isSelected'],
//                           onSelectChanged: (bool? isSelected) {
//                             if (isSelected != null) {
//                               item['isSelected'] = isSelected;
//
//                               setState(() {});
//                             }
//                           },
//                           color: MaterialStateColor.resolveWith(
//                                   (Set<MaterialState> states) =>
//                               states.contains(MaterialState.selected)
//                                   ? Colors.red
//                                   : Color.fromARGB(100, 215, 217, 219)),
//                           cells: [
//                             DataCell(
//                               Text(item['iId']),
//                             ),
//                             DataCell(
//                               Text(item['nameClass']),
//                               placeholder: false,
//                               showEditIcon: true,
//                               onTap: () {
//                                 print('onTap');
//                               },
//                             ),
//                             DataCell(Text(item['lv'])),
//                             // DataCell(
//                             //   Text(item.description),
//                             // ),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 )
//                 : Center(child: Text("Invail member"));
//           } else if (state is Loading) {
//             return SpinkitLoading();
//           } else if (state is Error) {
//             return Center(
//               child: Text("Lỗi hệ thống"),
//             );
//           }
//           return Container();
//         });
//   }
//   void updateSort(int columnIndex, bool ascending) {
//     setState(() {
//       _sortColumnIndex = columnIndex;
//       _sortAscending = ascending;
//     });
//   }
//
//   List<DataColumn> _createColumns() {
//     return [
//       DataColumn(
//         label: const Text('No'),
//         numeric: false, // Deliberately set to false to avoid right alignment.
//       ),
//       DataColumn(
//         label: const Text('Name Class'),
//         numeric: false,
//         tooltip: 'Name of the item',
//         // onSort: (int columnIndex, bool ascending) {
//         //   if (ascending) {
//         //     _items.sort((item1, item2) =>
//         //         item1.nameCourse!.compareTo(item2.nameCourse!));
//         //   } else {
//         //     _items.sort((item1, item2) =>
//         //         item2.nameCourse!.compareTo(item1.nameCourse!));
//         //   }
//         //
//         //   setState(() {
//         //     _sortColumnIndex = columnIndex;
//         //     _sortAscending = ascending;
//         //   });
//         // },
//       ),
//       DataColumn(
//         label: const Text('Grade Class'),
//         numeric: false, // Deliberately set to false to avoid right alignment.
//         tooltip: 'Price of the item',
//         // onSort: (int columnIndex, bool ascending) {
//         //   if (ascending) {
//         //     _items.sort(
//         //             (item1, item2) => item1.fullName!.compareTo(item2.fullName!));
//         //   } else {
//         //     _items.sort(
//         //             (item1, item2) => item2.fullName!.compareTo(item1.fullName!));
//         //   }
//         //
//         //   setState(() {
//         //     _sortColumnIndex = columnIndex;
//         //     _sortAscending = ascending;
//         //   });
//         // },
//       ),
//       // DataColumn(
//       //   label: const Text('Description'),
//       //   numeric: false,
//       //   tooltip: 'Description of the item',
//       // ),
//     ];
//   }
//
// // DataRow _createRow() {
// //   return DataRow(
// //     // index: item.id, // for DataRow.byIndex
// //     key: ValueKey(item.iId),
// //     selected: item.isSelected,
// //     onSelectChanged: (bool? isSelected) {
// //       if (isSelected != null) {
// //         item.isSelected = isSelected;
// //
// //         setState(() {});
// //       }
// //     },
// //     color: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
// //         states.contains(MaterialState.selected)
// //             ? Colors.red
// //             : Color.fromARGB(100, 215, 217, 219)),
// //     cells: [
// //       DataCell(
// //         Text(item.iId.toString()),
// //       ),
// //       DataCell(
// //         Text(item!.fullName!),
// //         placeholder: false,
// //         showEditIcon: true,
// //         onTap: () {
// //           print('onTap');
// //         },
// //       ),
// //       DataCell(Text(item!.fullName!)),
// //       // DataCell(
// //       //   Text(item.description),
// //       // ),
// //     ],
// //   );
// // }
//
// }