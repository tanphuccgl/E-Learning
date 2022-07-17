import 'package:flutter/material.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/presentation/widgets/bottom_navi_bar_cus.dart';

class NotifiPage extends StatefulWidget {
  static const String routeName = "/NotifiPage";
  const NotifiPage({Key? key}) : super(key: key);

  @override
  _NotifiPageState createState() => _NotifiPageState();
}

class _NotifiPageState extends State<NotifiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        index: 1,
      ),
    );
  }
}
