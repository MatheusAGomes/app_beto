import 'package:app_beto/models/licaoCompleta.dart';
import 'package:app_beto/models/user.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

import '../models/filho.dart';
import '../models/licao.dart';
import '../shared/constance/enviroment.dart';
part 'user-repository.g.dart';

@RestApi(baseUrl: Environment.BASE_URL)
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @POST("/authenticate")
  Future<Map<String, String>> authenticate(
      @Body() Map<String, String> userCredentials);
  //criar novo usuario
  @POST("/users")
  Future<Map<String, String>> postUser(@Body() User user);
  //pegar usuarios
  @GET("/users")
  Future<List<User>> getUsers();
  @GET("/users/{id}")
  Future<User> getUser(@Path('id') String id);
  //filhos de um usuario
  @GET("/users/{id}/filhos")
  Future<List<Filho>> getFilhos(@Path('id') String id);
  //novo filho
  @POST("/users/{id}/novofilho")
  Future<void> criarNovofilho(@Path('id') String id, @Body() Filho filho);

  @POST("/users/{id}/finalizarLicao/{idFilho}")
  Future<User> finalizarLicao(@Path('id') String id,
      @Path('idFilho') String idFilho, @Body() LicaoCompleta licaoCompleta);
}
