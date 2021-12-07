import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog1.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/alert_dialog2.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/core/config/injection_container.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/data_sources/remove_class.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_state.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/widgets/appbar_custom.dart';

class RemoveClassPage extends StatefulWidget {
  static const String routeName = "/RemoveClassPage";

  const RemoveClassPage({
    Key? key,
  }) : super(key: key);

  @override
  _RemoveClassPageState createState() => _RemoveClassPageState();
}

class _RemoveClassPageState extends State<RemoveClassPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GetAllClassBloc>(),
      child: BlocBuilder<GetAllClassBloc, GetAllClassState>(
          builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<GetAllClassBloc>(context).add(GetGetAllClassE());
        } else if (state is Loaded) {
          return Scaffold(
              appBar: appBar(context: context, title: "Remove Class"),
              body: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: _list(list: state.data),
                ),
              ));
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Error) {
          return Center(
            child: Text("Lỗi hệ thống"),
          );
        }
        return Container();
      }),
    );
  }

  Widget _list({List<GetAllClassData>? list}) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: Padding(
        padding: EdgeInsets.only(
          left: size.width / 25,
          right: size.width / 25,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width,
              height: size.width / 7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("No"),
                  Text("Name Class"),
                  Text("Grade Class"),
                  Text("Remove Class")
                ],
              ),
            ),
            Container(
              width: size.width,
              height: size.width / 0.65,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.separated(
                    itemBuilder: (context, index) {
                      return _item(
                          data: list?[index],
                          number: index + 1,
                          onPressed: () {
                            AlertDialog2.yesAbortDialog(
                                context: context,
                                title: "REMOVE CLASS",
                                body:
                                    "Are you sure you want to delete class ${list?[index].nameClass}?",
                                onPressed: () {
                                  removeClass(
                                      idClass: list?[index].iId,
                                      failure: () => showCancelDelete(),
                                      success: () => showSuccessDelete());
                                });
                          });
                    },
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.black,
                        ),
                    itemCount: list!.length),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCancelDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
        },
        title: "ERROR",
        description: "There are students in this class");
  }

  void showSuccessDelete() {
    return showPopup(
        context: context,
        function: () {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RemoveClassPage()));
        },
        title: "SUCCESS",
        description: "Delete successful");
  }

  Widget _item({GetAllClassData? data, int? number, Function()? onPressed}) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.width / 8,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("$number"),
          Container(
            child: Text(data!.nameClass!),
            width: size.width / 4,
          ),
          Container(
            child: Text(data.lv.toString()),
            width: size.width / 10,
          ),
          Container(
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.highlight_remove),
            ),
            width: size.width / 5,
          )
        ],
      ),
    );
  }
}
