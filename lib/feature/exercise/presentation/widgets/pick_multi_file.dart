import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';

Widget chooseFile(
    {String? title, BuildContext? context, Function()? function}) {
  Size size = MediaQuery.of(context!).size;

  return Container(
      height: size.width / 8,
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                title!,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: size.width / 20,
                    fontWeight: FontWeight.w600),
              ),
              Container(
                  height: size.width / 10,
                  width: size.width / 10,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius:
                          BorderRadius.all(Radius.circular(size.width / 40))),
                  child: IconButton(
                    icon: Icon(
                      Icons.upload_file,
                      color: Colors.black,
                    ),
                    onPressed: function,
                  ))
            ],
          ),
        ],
      ));
}

void openFile({PlatformFile? file}) {
  OpenFile.open(file?.path);
}
