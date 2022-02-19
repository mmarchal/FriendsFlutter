import 'package:dio/dio.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/typesortie.dart';
import 'package:life_friends/service/api.service.dart';

class TypeSortieRepository extends ApiService {
  final Dio _dio = Dio();
  late String domain;

  TypeSortieRepository(Dio dio, String domain) : super(dio, domain);

  Future<APIResponse<List<TypeSortie>>> getTypeSorties() async {
    List<TypeSortie> list = [];
    try {
      final response = await _dio.get("$domain/typesortie");
      for (var element in response.data) {
        list.add(TypeSortie.fromJson(element));
      }
      return APIResponse(data: list);
    } on DioError catch (error) {
      if (error.response != null) {
        switch (error.response?.statusCode) {
          case 401:
            return APIResponse(type: FriendTypeError.unauthorized);
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
              title: 'Erreur lors de la connexion',
              content: error.toString()));
    }
  }
}
