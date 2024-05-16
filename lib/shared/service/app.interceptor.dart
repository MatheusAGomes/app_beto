import 'package:dio/dio.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../main.dart';
import 'toastService.dart';

class AppInterceptors extends Interceptor {
//  BuildContext? context;
  var controladorReq = 0;
  AppInterceptors();

  @override
  void onRequest(RequestOptions options,
      RequestInterceptorHandler interceptorHandler) async {
    if (options.headers['hidden-loader'] != true) {
      navigatorKey.currentContext?.loaderOverlay.show();
    }

    // final token = await Store.getString('auth');
    // if (token != null && options.baseUrl.contains(Environment.BASE_URL)) {
    //   options.headers['authorization'] = token;
    // }

    return interceptorHandler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    navigatorKey.currentContext?.loaderOverlay.hide();

    return handler.next(response);
  }

  @override
  void onError(DioError dioError,
      ErrorInterceptorHandler errorInterceptorHandler) async {
    navigatorKey.currentContext?.loaderOverlay.hide();

    String error = '';
    if (dioError.response != null) {
      final statusCode = dioError.response!.statusCode;

      switch (statusCode) {
        case 0:
          {
            error = 'Houve um erro';
            break;
          }
        case 401:
          {
            error = 'Acesso não permitido';
            break;
          }

        case 403:
          {
            if (dioError.requestOptions.baseUrl.contains('/login')) {
              if (dioError.response!.headers.value('invalid-reason') != null) {
                error = dioError.response!.headers
                    .value('invalid-reason')
                    .toString();
              } else {
                error = 'Usuario ou senha invalidos';
              }
            } else {
              // Provider.of<Auth>(Routes.navigatorKey.currentContext!,
              //         listen: false)
              //     .deslogar();
              error = 'Acesso nao permitido';
            }
          }
          break;

        case 404:
          {
            if (dioError.response!.requestOptions.path
                    .contains('mobile/brasil-classificacoes/empresas/') ||
                dioError.response!.requestOptions.path.contains(
                    'mobile/internacional-classificacoes/empresas;')) {
              error = 'Item não encontrado';
              break;
            }
            error = 'Página não encontrada';
          }
          break;

        default:
          {
            final data = dioError.response!.data;
            error = 'Houve um erro tente novamente';

            try {
              if (data.containsKey('userMessage') &&
                  data.containsKey('objects')) {
                int i = 0;
                error = '';
                for (i = data['objects'].length - 1; i >= 0; i--) {
                  error += data['objects'][i]['userMessage'];
                  if (i != 0) {
                    error += "\n";
                  }
                }
                // error += data['userMessage'];
              }
            } catch (e) {}
          }
          break;
      }
    } else {
      error = 'Houve um erro tente novamente';
    }

    if (error.isNotEmpty) ToastService.showToastError(error);

    return errorInterceptorHandler.next(DioError(
        requestOptions: dioError.requestOptions,
        response: dioError.response,
        type: dioError.type,
        error: error));
  }
}
