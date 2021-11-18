import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thuc_tap_tot_nghiep/core/network/network_info.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/data_sources/get_course_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/data_sources/get_member_in_course_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/repositories/get_course_repo_impl.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/data/repositories/get_member_in_course_repo_impl.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/repositories/get_course_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/repositories/get_member_in_course_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/domain/usecases/get_member_in_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_course/get_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/course/presentations/manager/get_member_in_course/get_member_in_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/get_exercise_by_course_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/get_exercise_by_id_account_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/data_source/get_info_exercise_remote.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/repositories/get_exercise_by_course_repo_impl.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/repositories/get_exercise_by_id_account_repo_impl.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/data/repositories/get_info_exercise_repo_impl.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_exercise_by_course_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_exercise_by_id_account_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/repositories/get_info_exercise_repo.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/usecase/get_exercise_by_course.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/usecase/get_exercise_by_id_account.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/domain/usecase/get_info_exercise.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_course/get_exercise_by_course_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_exercise_by_id_account/get_exercise_by_id_account_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/exercise/presentation/manager/get_info_exercise/get_info_exercise_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/data_sources/list_teacher_remote_data_source.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/data/repositories/list_teacher_repository_impl.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/domain/repositories/list_teacher_repository.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/domain/usecases/get_list_teacher.dart';
import 'package:thuc_tap_tot_nghiep/feature/list_teacher/presentations/manager/list_teacher_bloc.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/data_sources/login_local_data_source.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/data_sources/login_remote_data_source.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/data/repositories/login_repository_impl.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/domain/repositories/login_repository.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/domain/usecases/get_current_user.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/domain/usecases/post_login.dart';
import 'package:thuc_tap_tot_nghiep/feature/sign_in/presentations/manager/login_bloc.dart';

final sl = GetIt.instance;
Future<void> init() async {
  ///
  //login
  sl.registerFactory(
    () => LoginBloc(
      lg: sl(),
      cu: sl(),
    ),
  );
  //list teacher
  sl.registerFactory(() => ListTeacherBloc(pr: sl()));
  sl.registerFactory(() => GetCourseBloc(pr: sl()));
  sl.registerFactory(() => GetMemberInCourseBloc(pr: sl()));
  sl.registerFactory(() => GetExerciseByCourseBloc(pr: sl()));
  sl.registerFactory(() => GetExerciseByIdAccountBloc(pr: sl()));
  sl.registerFactory(() => GetInfoExerciseBloc(pr: sl()));





  ///use case
  //login
  sl.registerLazySingleton(() => PostLogin(loginRepository: sl()));
  sl.registerLazySingleton(() => GetCurrentUser(loginRepository: sl()));
  //list teacher
  sl.registerLazySingleton(() => GetListTeacher(sl()));
  sl.registerLazySingleton(() => GetCourse(sl()));
  sl.registerLazySingleton(() => GetMemberInCourse(sl()));
  sl.registerLazySingleton(() => GetExerciseByCourse(sl()));
  sl.registerLazySingleton(() => GetExerciseByIdAccount(sl()));
  sl.registerLazySingleton(() => GetInfoExercise(sl()));







  ///repo
  //login
  sl.registerLazySingleton<LoginRepository>(() => LoginRepositoryImpl(
      networkInfo: sl(),
      loginLocalDataSource: sl(),
      loginRemoteDataSource: sl()));
  //list teacher
  sl.registerLazySingleton<ListTeacherRepository>(
      () => ListTeacherRepositoryImpl(
            listTeacherRemoteDataSource: sl(),
            networkInfo: sl(),
          ));
  sl.registerLazySingleton<GetCourseRepository>(
          () => GetCourseRepositoryImpl(
        getCourseRemoteDataSource:  sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<GetMemberInCourseRepository>(
          () => GetMemberInCourseRepositoryImpl(
        getMemberInCourseRemoteDataSource:   sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<GetExerciseByCourseRepository>(
          () => GetExerciseByCourseRepositoryImpl(
       getExerciseByCourseRemoteDataSource :   sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<GetExerciseByIdAccountRepository>(
          () => GetExerciseByIdAccountRepositoryImpl(
        getExerciseByIdAccountRemoteDataSource :   sl(),
        networkInfo: sl(),
      ));
  sl.registerLazySingleton<GetInfoExerciseRepository>(
          () => GetInfoExerciseRepositoryImpl(
        getInfoExerciseRemoteDataSource :   sl(),
        networkInfo: sl(),
      ));

  ///data source
  //login
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl(sharedPreferences: sl()));
  //list teacher
  sl.registerLazySingleton<ListTeacherRemoteDataSource>(
      () => ListTeacherRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<GetCourseRemoteDataSource>(
          () => GetCourseRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<GetMemberInCourseRemoteDataSource>(
          () => GetMemberInCourseRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<GetExerciseByCourseRemoteDataSource>(
          () => GetExerciseByCourseRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<GetExerciseByIdAccountRemoteDataSource>(
          () => GetExerciseByIdAccountRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<GetInfoExerciseRemoteDataSource>(
          () => GetInfoExerciseRemoteDataSourceImpl(client: sl()));

  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
