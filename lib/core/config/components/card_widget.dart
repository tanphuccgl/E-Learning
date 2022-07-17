import 'package:flutter/cupertino.dart';

Widget card(
    {String? title,
    Function()? function,
    BuildContext? context,
    Color? colorCard,
    Color? colorText}) {
  Size size = MediaQuery.of(context!).size;

  return Padding(
    padding: EdgeInsets.all(size.width / 30),
    child: GestureDetector(
      onTap: function,
      child: Container(
        width: size.width,
        height: size.width / 5,
        decoration: BoxDecoration(
            color: colorCard,
            borderRadius: BorderRadius.all(Radius.circular(size.width / 20)),
            boxShadow: [
              BoxShadow(
                  color: colorCard!.withOpacity(0.9),
                  offset: Offset(0, 4),
                  blurRadius: 4)
            ]),
        child: Center(
            child: Text(
          title!,
          style: TextStyle(
              color: colorText,
              fontWeight: FontWeight.w700,
              fontSize: size.width / 20),
        )),
      ),
    ),
  );
}
