import 'package:flutter/material.dart';

/// chọn loại điểm
Widget typePoint({BuildContext? context,String? typePointValue,Function(String?)? function}) {
  Size size = MediaQuery.of(context!).size;

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
                onChanged: function,
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