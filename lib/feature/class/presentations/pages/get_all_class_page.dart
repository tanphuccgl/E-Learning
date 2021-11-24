import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/widgets/body_get_all_class.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class GetAllClassPage extends StatefulWidget {
  static const String routeName = '/GetAllClassPage';

  GetAllClassPage({Key? key}) : super(key: key);

  @override
  _GetAllClassPageState createState() => _GetAllClassPageState();
}

class _GetAllClassPageState extends State<GetAllClassPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context: context, title: "List Class"),
        body: BlocProvider(
          create: (_) => sl<GetAllClassBloc>(),
          child: BodyGetAllClass(),
        ));
  }
}
