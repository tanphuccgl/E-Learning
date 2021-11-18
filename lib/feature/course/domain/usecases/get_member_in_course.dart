import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/models/get_member_in_course_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/repositories/get_member_in_course_repo.dart';



class GetMemberInCourse implements UseCase<GetMemberInCourseResponse, GetMemberInCourseParams> {
  final GetMemberInCourseRepository memberInCourseRepository;

  GetMemberInCourse(this.memberInCourseRepository);

  @override
  Future<Either<Failure, GetMemberInCourseResponse>> call(GetMemberInCourseParams params) async {
    return await memberInCourseRepository.getMemberInCourse(
        params.idCourse!, params.keySearchName!);
  }
}

class GetMemberInCourseParams extends Equatable {
  final String? idCourse ;
  final String? keySearchName;

  GetMemberInCourseParams({this.idCourse, this.keySearchName});

  @override
  // TODO: implement props
  List<Object> get props => [idCourse!, keySearchName!];
}
