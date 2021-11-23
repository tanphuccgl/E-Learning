
import 'package:flutter/material.dart';


Widget gradingSummary({String? title,BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
    height: size.width / 1.5,
    width: size.width,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title!,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: size.width / 20),
        ),
        Container(
          height: size.width / 1.7,
          width: size.width,
          child: ListView(physics: const NeverScrollableScrollPhysics(),
            children: [
              DataTable(
                columns: [
                  DataColumn(
                      label: Text('Participants',
                          style: TextStyle(
                              fontSize: size.width / 25,
                              fontWeight: FontWeight.bold))),
                  DataColumn(
                      label: Container(
                        width: size.width/1.8,
                        height: size.width,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text('2',
                              style: TextStyle(
                                  fontSize: size.width / 28,
                                  fontWeight: FontWeight.normal)),
                        ),
                      )),
                ],
                rows: [

                  DataRow(cells: [
                    DataCell(Text('Submitted',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(Text('0')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Needs grading',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(Text('0')),
                  ]),
                  DataRow(cells: [
                    DataCell(Text('Time remaining',
                        style: TextStyle(
                            fontSize: size.width / 25,
                            fontWeight: FontWeight.bold))),
                    DataCell(Text('5 ngày 10 hours')),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}