import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ListFile extends StatelessWidget {
  final PlatformFile? file;
  const ListFile({Key? key,this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: Text("${file?.name}"),);
  }
}
