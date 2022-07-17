import 'package:flutter/material.dart';

Widget filter({BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;
  return Padding(
    padding: EdgeInsets.only(top: size.width / 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _searchBar(context: context),
        //   _sort(context: context),
      ],
    ),
  );
}

///sắp xếp theo
Widget _sort({BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return GestureDetector(
    onTap: () {
      print("tap noti");
    },
    child: Container(
      height: size.width / 10,
      width: size.width / 10,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(size.width / 30))),
      child: Icon(
        Icons.sort,
      ),
    ),
  );
}

///thanh tìm kiếm
Widget _searchBar({BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
      width: size.width / 1.2,
      height: size.width / 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(size.width / 30),
        ),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width / 20,
          ),
          Icon(
            Icons.search,
            color: Colors.black,
            size: size.width / 15,
          ),
          SizedBox(
            width: size.width / 30,
          ),
          Text(
            "Find course",
            style: TextStyle(
                color: Colors.black,
                fontSize: size.width / 20,
                fontWeight: FontWeight.w400),
          )
        ],
      ));
}
