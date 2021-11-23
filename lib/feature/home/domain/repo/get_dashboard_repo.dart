import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/class/data/models/get_all_class_response_model.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/data/models/get_dashboard_res.dart';

abstract class GetDashboardRepository {
  Future<Either<Failure, GetDashboardResponse>> getDashboard();
}
