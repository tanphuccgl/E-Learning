import 'package:dartz/dartz.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';


abstract class GetInformationAnswerRepository {
  Future<Either<Failure, GetInformationAnswerResponse>> getInformationAnswer(
      int  idAccount
      , int idAnswer );
}
