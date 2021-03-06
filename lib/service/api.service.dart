import 'package:dio/dio.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';

abstract class ApiService {
  final Dio dio;

  ApiService(this.dio);

  getData(String url, {Map<String, dynamic>? param}) async {
    var query = url;
    Options options = Options(
      headers: {
        'accept': 'application/json',
        'authorization': 'Bearer ',
      },
    );
    try {
      final response = await dio.get(query, options: options);
      return response.data;
    } on DioError catch (error) {
      if (error.response != null) {
        switch (error.response?.statusCode) {
          case 401:
            return APIResponse(type: FriendTypeError.noInternet);
          case 404:
            return APIResponse(type: FriendTypeError.notFound);
          default:
            return APIResponse(error: APIError.fromJson(error.response?.data));
        }
      } else {
        return APIResponse(type: FriendTypeError.noInternet);
      }
    } catch (error) {
      return APIResponse(
        error: APIError(
          systemMessage: '',
          title: 'Erreur rencontrĂ© !',
          content: error.toString(),
        ),
      );
    }
  }
}
