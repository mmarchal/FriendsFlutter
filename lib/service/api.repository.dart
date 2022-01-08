import 'package:dio/dio.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/friend.dart';

class ApiRepository {
  final String domaine = "http://10.0.2.2:7070";

  final Dio _dio;

  ApiRepository(this._dio);

  Friend _initFriend(
      {required String prenom,
      required String login,
      required String password,
      required String email}) {
    return Friend(
        prenom: prenom, login: login, email: email, password: password);
  }

  Future<APIResponse<Friend>>? login(
      {required String login, required String password}) {
    return null;
  }

  Future<APIResponse<bool>> insertFriend(
      {required String prenom,
      required String login,
      required String password,
      required String email}) async {
    Friend friend = _initFriend(
        prenom: prenom, login: login, password: password, email: email);
    var url = '$domaine/friend';
    try {
      final response = await _dio.post(url, data: friend.toJson());
      return APIResponse(data: response.data);
    } on DioError catch (error) {
      if (error.response != null) {
        switch (error.response?.statusCode) {
          case 401:
            return APIResponse(type: TypeError.tokenExpired);
          case 404:
            return APIResponse(type: TypeError.notFound);
          default:
            return APIResponse(error: APIError.fromJson(error.response?.data));
        }
      } else {
        return APIResponse(type: TypeError.noInternet);
      }
    } catch (error) {
      return APIResponse(
          error: APIError(
              systemMessage: '',
              title: 'Erreur lors de la création de compte',
              content: error.toString()));
    }
  }
}
