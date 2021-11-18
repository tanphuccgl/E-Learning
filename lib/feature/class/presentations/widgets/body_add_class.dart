import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/data_sources/add_class_remote_data_source.dart';

class BodyAddClass extends StatefulWidget {
  BodyAddClass({Key? key}) : super(key: key);

  @override
  _BodyAddClassState createState() => _BodyAddClassState();
}

class _BodyAddClassState extends State<BodyAddClass> {
  TextEditingController _nameClassController = TextEditingController();
  String? _nameClass;
  List<int> lv = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  int dropdownValue = 1;
  int? value;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: size.height / 12.8,
            width: size.width / 2,
            child: TextFormField(
              controller: _nameClassController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  icon: Icon(Icons.login), labelText: 'Name Course'),
              onChanged: (value) {
                _nameClass = value;
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 40),
              child: DropdownButton<int>(
                value: dropdownValue,
                icon: const Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.deepPurple),
                underline: Container(
                  height: 2,
                  color: Colors.deepPurpleAccent,
                ),
                onChanged: (int? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
                    .map<DropdownMenuItem<int>>((value) {
                  return DropdownMenuItem<int>(
                    value: value,
                    child: Text("${value}"),
                  );
                }).toList(),
              )),
          ElevatedButton(
              onPressed: () {
                if (dropdownValue != null && _nameClass != null) {
                  // addClass(_nameClass!, dropdownValue);

                } else {}
              },
              child: Text("xac nhan"))
        ],
      ),
    );
  }
}
