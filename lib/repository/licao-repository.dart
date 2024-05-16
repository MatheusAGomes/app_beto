import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/licao.dart';
import '../shared/constance/enviroment.dart';
part 'licao-repository.g.dart';

@RestApi(baseUrl: Environment.BASE_URL)
abstract class LicaoApi {
  factory LicaoApi(Dio dio, {String baseUrl}) = _LicaoApi;

  @GET("/licoes")
  Future<List<Licao>> getLicoes(@Header('hidden-loader') bool load);

  @POST("/licoes")
  Future<void> postLicao(@Body() Licao licao);
}
