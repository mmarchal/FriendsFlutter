import 'package:dio/dio.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/login_service.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/api/back/api_back.dart';
import 'package:life_friends/model/connect.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/password.dart';
import 'package:life_friends/service/api.service.dart';

class ApiRepository extends ApiService {
  final Dio _dio = Dio();

  ApiRepository(Dio dio, LoginService loginService) : super(dio, loginService);

  Friend _initFriend(
      {required String prenom,
      required String login,
      required String password,
      required String email}) {
    return Friend(
        prenom: prenom, login: login, email: email, password: password);
  }

  Future<APIResponse<ApiBack>> login(
      {required String login, required String password}) async {
    Connect connect = Connect(username: login, password: password);
    var urlLogin = '$domaine/token';
    try {
      final responseLogin = await _dio.post(urlLogin, data: connect.toJson());
      ApiBack apiBack = ApiBack.fromJson(responseLogin.data);
      return APIResponse(data: apiBack);
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
              title: 'Erreur lors de la création de compte',
              content: error.toString()));
    }
  }

  Future<APIResponse<Friend>> getFriend(String id) async {
    var url = '$domaine/friend/$id';
    return APIResponse(data: await getData(url));
  }

  Future<APIResponse<bool>> getForgotPassword(String user) async {
    var url = '$domaine/friend/getTempPassword';
    try {
      final response = await _dio.post(url, data: user);
      return APIResponse(data: response.data);
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
              title: 'Erreur lors de l\'oublie de mot de passe',
              content: error.toString()));
    }
  }

  Future<APIResponse<bool>> checkingTempPassword(
      String user, String temp) async {
    var url = '$domaine/friend/checkingTempPassword/$user';
    try {
      final response = await _dio.post(url, data: temp);
      return APIResponse(data: response.data);
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
              title: 'Erreur lors de l\'oublie de mot de passe',
              content: error.toString()));
    }
  }

  Future<APIResponse<bool>> resetPassword(Password password) async {
    var url = '$domaine/friend/resetPassword';
    try {
      final response = await _dio.put(url, data: password.toJson());
      return APIResponse(data: response.data);
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
              title: 'Erreur lors de l\'oublie de mot de passe',
              content: error.toString()));
    }
  }
}
