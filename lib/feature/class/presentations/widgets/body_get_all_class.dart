import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thuc_tap_tot_nghiep/core/config/components/spinkit.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_event.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/presentations/manager/get_all_class/get_all_class_state.dart';

class BodyGetAllClass extends StatefulWidget {
  BodyGetAllClass({Key? key}) : super(key: key);

  @override
  _BodyGetAllClassState createState() => _BodyGetAllClassState();
}

class _BodyGetAllClassState extends State<BodyGetAllClass> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<GetAllClassBloc, GetAllClassState>(
      builder: (context, state) {
        if (state is Empty) {
          BlocProvider.of<GetAllClassBloc>(context).add(GetGetAllClassE());
        } else if (state is Loading) {
          return SpinkitLoading();
        } else if (state is Loaded) {
          return _list(list: state.data!.reversed.toList());
        } else if (state is Error) {
          return Container(
            child: Text("Lỗi hệ thống"),
          );
        }
        return Container();
      },
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
                children: [Text("No"), Text("Name Class"), Text("Grade Class")],
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
                      return _item(data: list?[index], number: index + 1);
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

  Widget _item({GetAllClassData? data, int? number}) {
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
            child: Text(data!.lv.toString()),
            width: size.width / 15,
          )
        ],
      ),
    );
  }
}
