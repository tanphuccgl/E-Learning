import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/card_widget.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/domain/usecase/get_all_teacher.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/manager/get_all_teacher/get_all_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/pages/change_info_user_page.dart';
import 'package:thuc_tap_tot_nghiep/feature/user/presentation/widgets/delete_teacher.dart';

class DeleteUserPage extends StatefulWidget {
  static const String routeName="/DeleteUserPage";
  const DeleteUserPage({Key? key}) : super(key: key);

  @override
  _DeleteUserPageState createState() => _DeleteUserPageState();
}

class _DeleteUserPageState extends State<DeleteUserPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(context: context, title: "Delete User"),
      body: Container(
        width: size.width,
        child: Padding(
          padding: EdgeInsets.only(
            left: size.width / 25,
            right: size.width / 25,
          ),
          child: Column(
            children: <Widget>[
              card(
                  title: "Delete Teacher",
                  colorCard: Colors.red,
                  colorText: Colors.white,
                  context: context,
                  function: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (_) => sl<GetAllTeacherBloc>(),
                              child: DeleteTeacherPage(title: "Delete Teacher"),
                            )));
                  }), card(
                  title: "Delete Student",
                  colorCard: Colors.red,
                  colorText: Colors.white,
                  context: context,
                  function: ()
                  {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (_) => sl<GetAllTeacherBloc>(),
                              child: DeleteTeacherPage(title: "Delete Student"),
                            )));
                  }),

            ],
          ),
        ),
      ),
    );
  }
}
