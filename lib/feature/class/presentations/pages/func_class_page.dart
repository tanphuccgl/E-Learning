import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/card_widget.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/create_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/edit_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/get_all_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/pages/remove_class_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class FuncClassPage extends StatefulWidget {
  static const String routeName = "/FuncClassPage";

  const FuncClassPage({Key? key}) : super(key: key);

  @override
  _FuncClassPageState createState() => _FuncClassPageState();
}

class _FuncClassPageState extends State<FuncClassPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(title: "Class", context: context),
      body: Container(
          width: size.width,
          height: size.height,
          child: Padding(
            padding: EdgeInsets.only(
                left: size.width / 25,
                right: size.width / 25,
                top: size.width / 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                card(
                    title: "List Class",
                    colorCard: Colors.blue,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetAllClassPage()));
                    }),
                card(
                    title: "Create Class",
                    colorCard: Colors.green,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CreateClassPage()));
                    }),
                /// edit class
                // card(
                //     title: "Edit Class",
                //     colorCard: Colors.amber,
                //     colorText: Colors.white,
                //     context: context,
                //     function: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //               builder: (context) => EditClassPage()));
                //     }),
                card(
                    title: "Remove Class",
                    colorCard: Colors.red,
                    colorText: Colors.white,
                    context: context,
                    function: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (_) => sl<GetAllClassBloc>(),
                                child: RemoveClassPage(),
                              )));
                    }),
                // _card(title: "Class"),
                // _card(title: "Class"),
                // _card(title: "Class"),
                // _card(title: "Class"),
              ],
            ),
          )),
    );
  }
}
