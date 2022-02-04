import 'package:dio/dio.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/login_service.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/api/back/auth_token.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/api.service.dart';

class FriendRepository extends ApiService {
  final String url = "$domaine/friend";
  final Dio _dio = Dio();

  FriendRepository(Dio dio, LoginService loginService)
      : super(dio, loginService);

  Future<APIResponse<Friend>> loadConnectedFriend(AuthToken? authToken) async {
    var urlFriend = "$url/${authToken!.userId}";
    return APIResponse<Friend>(data: Friend.fromJson(await getData(urlFriend)));
  }

  Future<APIResponse<List<Friend>>> getFriends() async {
    var retour = await getData(url);
    print(retour);
    List<Friend> list = [];
    try {
      final response = await _dio.get(url);
      for (var element in response.data) {
        list.add(Friend.fromJson(element));
      }
      return APIResponse(data: list);
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
              title: 'Erreur lors de la connexion',
              content: error.toString()));
    }
  }

  Future<APIResponse<List<Sortie>>> getMySorties(String id) async {
    List<Sortie> list = [];
    try {
      final response = await _dio.get("$url/$id/sorties");
      for (var element in response.data) {
        list.add(Sortie.fromJson(element));
      }
      return APIResponse(data: list);
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
              title: 'Erreur lors de la connexion',
              content: error.toString()));
    }
  }
}
