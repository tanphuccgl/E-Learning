import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/type_file.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/pick_multi_file.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/thumbnail.dart';


class ListFiles extends StatefulWidget {
  final List<PlatformFile>? list;

  const ListFiles({Key? key,this.list}) : super(key: key);

  @override
  ListFilesState createState() => ListFilesState();
}

class ListFilesState extends State<ListFiles> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height:
      widget.list!.length > 4 ? size.width / 1.4 : widget.list!.length * size.width / 6,
      width: size.width,
      child: ListView.separated(
          reverse: true,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                openFile(file: widget.list?[index]);
              },
              child: Container(
                height: size.width / 7,
                width: size.width / 10,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TypeFile.fileImage.contains(widget.list?[index].extension)
                            ? Container(
                          height: size.width / 10,
                          width: size.width / 10,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: FileImage(
                                      File("${widget.list?[index].path}"),
                                      scale: 1),
                                  fit: BoxFit.cover)),
                        )
                            : Container(
                          height: size.width / 10,
                          width: size.width / 10,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      "assets/icons/${thumbnail(image: widget.list?[index].extension)}"),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(
                          width: size.width / 15,
                        ),
                        _detailFile(file: widget.list?[index],context: context),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.highlight_remove),
                      onPressed: () {
                        setState(() {
                          widget.list?.remove(widget.list?[index]);
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          itemCount: widget.list!.length),
    );
  }
}





Widget _detailFile({PlatformFile? file,BuildContext? context}) {
  Size size = MediaQuery.of(context!).size;
  final kb = file!.size / 1024;
  final mb = kb / 1024;
  final fileSize =
  mb >= 1 ? "${mb.toStringAsFixed(2)} MB" : "${kb.toStringAsFixed(2)} KB";
  return Container(
    height: size.width / 7,
    width: size.width / 1.7,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${file.name}",
          style: TextStyle(color: Colors.black, fontSize: size.width / 20),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: size.width / 5,
              child: Text(
                "$fileSize",
                style:
                TextStyle(color: Colors.black, fontSize: size.width / 25),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
            SizedBox(
              width: size.width / 10,
            ),
            Text(
              "${file.extension}",
              style:
              TextStyle(color: Colors.black, fontSize: size.width / 25),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        )
        // Text("${list[index].extension}"),
        // Text("$fileSize"),
      ],
    ),
  );
}
