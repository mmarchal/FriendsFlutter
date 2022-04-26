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
  ApiRepository(Dio dio, LoginService loginService) : super(dio);

  Friend _initFriend(
      {required String uid,
      required String prenom,
      required String password,
      required String email}) {
    return Friend(
      prenom: prenom,
      email: email,
      password: password,
      uid: uid,
      login: email,
    );
  }

  Future<APIResponse<ApiBack>> login(
      {required String login, required String password}) async {
    Connect connect = Connect(username: login, password: password);
    var urlLogin = '$domaine/token';
    try {
      final responseLogin = await dio.post(urlLogin, data: connect.toJson());
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
          content: error.toString(),
        ),
      );
    }
  }

  Future<APIResponse<Friend>> insertFriend({
    required String uid,
    required String prenom,
    required String password,
    required String email,
  }) async {
    Friend friend = _initFriend(
      prenom: prenom,
      password: password,
      email: email,
      uid: uid,
    );
    var url = '$domaine/friend/create';
    try {
      final response = await dio.post(url, data: friend.toJson());
      return APIResponse(data: Friend.fromJson(response.data));
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
          content: error.toString(),
        ),
      );
    }
  }

  Future<APIResponse<Friend>> getFriend({
    required String id,
    required String token,
  }) async {
    var url = '$domaine/friend/$id';
    try {
      final response = await dio.get(
        url,
        options: Options(
          headers: {
            'accept': 'application/json',
            'authorization': 'Bearer $token',
          },
        ),
      );
      return APIResponse(data: Friend.fromJson(response.data));
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
    //return APIResponse(data: await getData(url));
  }

  Future<APIResponse<bool>> getForgotPassword(String user) async {
    var url = '$domaine/friend/getTempPassword';
    try {
      final response = await dio.post(url, data: user);
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
      final response = await dio.post(url, data: temp);
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
      final response = await dio.put(url, data: password.toJson());
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
