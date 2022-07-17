import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/repositories/get_member_in_course_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/data/models/get_all_lecture_of_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/lecture/domain/repo/get_all_lecture_of_course_repo.dart';

class GetAllLecture
    implements UseCase<GetAllLectureResponse, GetAllLectureParams> {
  final GetAllLectureRepository lectureInCourseRepository;

  GetAllLecture(this.lectureInCourseRepository);

  @override
  Future<Either<Failure, GetAllLectureResponse>> call(
      GetAllLectureParams params) async {
    return await lectureInCourseRepository.getAllLecture(params.idCourse!);
  }
}

class GetAllLectureParams extends Equatable {
  final String? idCourse;

  GetAllLectureParams({
    this.idCourse,
  });

  @override
  // TODO: implement props
  List<Object> get props => [
        idCourse!,
      ];
}
