import 'package:flutter/material.dart';

/// chọn loại điểm
Widget typePoint(
    {BuildContext? context,
    String? typePointValue,
    Function()? function,
    bool? isClick}) {
  Size size = MediaQuery.of(context!).size;

  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Type Point",
        style: TextStyle(
            color: Colors.black,
            fontSize: size.width / 20,
            fontWeight: FontWeight.w600),
      ),
      SizedBox(
        height: size.width / 20,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: function,
            child: Container(
              height: size.width / 10,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: isClick == true ? Colors.lightBlueAccent : Colors.white,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width / 30)),
                border: Border.all(color: Colors.lightBlueAccent, width: 2),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: size.width / 30,
              ),
              child: Center(
                child: Text(
                  "Number Point",
                  style: TextStyle(
                      color: isClick == true
                          ? Colors.white
                          : Colors.lightBlueAccent,
                      fontWeight: FontWeight.w700,
                      fontSize: size.width / 25),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: function,
            child: Container(
              height: size.width / 10,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: isClick == true ? Colors.white : Colors.lightBlueAccent,
                borderRadius:
                    BorderRadius.all(Radius.circular(size.width / 30)),
                border: Border.all(
                    color: isClick == true
                        ? Colors.lightBlueAccent
                        : Colors.transparent,
                    width: 2),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: size.width / 30,
              ),
              child: Center(
                child: Text(
                  "Text Point",
                  style: TextStyle(
                      color: isClick == true
                          ? Colors.lightBlueAccent
                          : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: size.width / 25),
                ),
              ),
            ),
          )
        ],
      )
    ],
  );
}
