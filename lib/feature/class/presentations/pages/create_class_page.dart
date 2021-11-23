import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class CreateClassPage extends StatefulWidget {
  static const String routeName="/CreateClassPage";
  const CreateClassPage({Key? key}) : super(key: key);

  @override
  _CreateClassPageState createState() => _CreateClassPageState();
}

class _CreateClassPageState extends State<CreateClassPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Create Class",context: context),
      body: Container(),
    );
  }
}
