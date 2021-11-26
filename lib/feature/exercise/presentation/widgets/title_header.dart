import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/main.dart';

class TitleHeader extends StatefulWidget {
  final ValueChanged<int>? onChanged;
  final int? choosingPos1;

  const TitleHeader({Key? key, this.onChanged, this.choosingPos1})
      : super(key: key);

  @override
  _TitleHeaderState createState() => _TitleHeaderState();
}

class _TitleHeaderState extends State<TitleHeader> {
  List<HeaderItem>? items;
  int? choosingPos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.choosingPos1 != null) {
      choosingPos = widget.choosingPos1;
    } else {
      choosingPos = 1;
    }
    items = <HeaderItem>[];
    items?.add(HeaderItem("Lecture", 1));
    items?.add(HeaderItem("Exercise", 2));
    items?.add(HeaderItem("List User", 3));
    // items?.add(HeaderItem("Chấm điểm", 5));
    appUser?.role == "student" ? items?.add(HeaderItem("List Score", 4)) : null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 10,
      width: size.width,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: items!.map((e) {
          return InkWell(
            onTap: () {
              setState(() {
                choosingPos = e.id;
                widget.onChanged!(e.id);
              });
            },
            child: Container(
              height: size.width / 10,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color:
                    choosingPos == e.id ? Colors.lightBlueAccent : Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width / 30)),
                border: Border.all(
                    color: choosingPos == e.id
                        ? Colors.transparent
                        : Colors.lightBlueAccent,
                    width: 2),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: size.width / 30,
              ),
              child: Center(
                child: Text(
                  e.name,
                  style: TextStyle(
                      color: choosingPos == e.id
                          ? Colors.white
                          : Colors.lightBlueAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: size.width / 25),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class HeaderItem {
  final String name;
  final int id;

  HeaderItem(this.name, this.id);
}
