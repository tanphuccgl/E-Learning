import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';

import 'package:thuc_tap_tot_nghiep/feature/home/data/models/get_dashboard_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/home/domain/repo/get_dashboard_repo.dart';

class GetDashboard implements UseCase<GetDashboardResponse, NoParams> {
  final GetDashboardRepository? getDashboardRepository;

  GetDashboard(this.getDashboardRepository);

  @override
  Future<Either<Failure, GetDashboardResponse>> call(NoParams params) async {
    return await getDashboardRepository!.getDashboard();
  }
}
