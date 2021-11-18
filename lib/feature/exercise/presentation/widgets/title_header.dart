import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleHeader extends StatefulWidget {
  final ValueChanged<int>? onChanged;

  const TitleHeader({Key? key, this.onChanged}) : super(key: key);

  @override
  _TitleHeaderState createState() => _TitleHeaderState();
}

class _TitleHeaderState extends State<TitleHeader> {
  List<HeaderItem>? items;
  int choosingPos = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    items = <HeaderItem>[];
    items?.add(HeaderItem("Bài giảng", 1));
    items?.add(HeaderItem("Bài tập", 2));
    items?.add(HeaderItem("DS Học sinh", 3));
    items?.add(HeaderItem("Chấm điểm", 4));
    items?.add(HeaderItem("DS điểm", 5));
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
              width: size.width/3.5,
              decoration: BoxDecoration( color: choosingPos == e.id ? Colors.black87 : Colors.grey.shade200,
                  borderRadius:
                      BorderRadius.all(Radius.circular(size.width / 30)),
                  // border: Border(
                  //     bottom: BorderSide(
                  //         color: choosingPos == e.id
                  //             ? Colors.blue
                  //             : Colors.transparent,
                  //         width: 2)),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: size.width / 30,
              ),
              child: Center(
                child: Text(
                  e.name,
                  style: TextStyle(
                      color: choosingPos == e.id ? Colors.white : Colors.black,
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
