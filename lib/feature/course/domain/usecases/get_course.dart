import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_couse_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/repositories/get_course_repo.dart';


class GetCourse implements UseCase<GetCourseResponse, GetCourseParams> {
  final GetCourseRepository courseContentsRepository;

  GetCourse(this.courseContentsRepository);

  @override
  Future<Either<Failure, GetCourseResponse>> call(GetCourseParams params) async {
    return await courseContentsRepository.getCourse(
        params.keySearchNameCourse!, params.idAccount!);
  }
}

class GetCourseParams extends Equatable {
  final String? keySearchNameCourse;
  final String? idAccount;

  GetCourseParams({this.keySearchNameCourse, this.idAccount});

  @override
  // TODO: implement props
  List<Object> get props => [keySearchNameCourse!, idAccount!];
}
