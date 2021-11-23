import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:thuc_tap_tot_nghiep/core/error/failures.dart';
import 'package:thuc_tap_tot_nghiep/core/usecase/usecase.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/data/models/get_info_answer_res.dart';
import 'package:thuc_tap_tot_nghiep/feature/answer/domain/repo/info_answer_repo.dart';


class GetInformationAnswer implements UseCase<GetInformationAnswerResponse, GetInformationAnswerParams> {
  final GetInformationAnswerRepository getInformationAnswerRepository;

  GetInformationAnswer(this.getInformationAnswerRepository);

  @override
  Future<Either<Failure, GetInformationAnswerResponse>> call(GetInformationAnswerParams params) async {
    return await getInformationAnswerRepository.getInformationAnswer(
        params.idAccount!, params.idAnswer!);
  }
}

class GetInformationAnswerParams extends Equatable {
  final int? idAccount ;
  final int? idAnswer ;

  GetInformationAnswerParams({this.idAnswer, this.idAccount});

  @override
  // TODO: implement props
  List<Object> get props => [idAnswer!, idAccount!];
}
