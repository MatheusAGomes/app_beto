import 'package:app_beto/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/licao.dart';
import '../shared/constance/enviroment.dart';
part 'user-repository.g.dart';

@RestApi(baseUrl: Environment.BASE_URL)
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @POST("/users")
  Future<void> postLicao(@Body() User user);
  @GET("/users")
  Future<List<User>> getUsers();
}
