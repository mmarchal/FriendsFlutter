import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/api/back/auth_token.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';

class FriendRepository {
  final String url = "$domaine/friend";
  final Dio _dio = Dio();
  final String token;

  FriendRepository({
    required this.token,
  });

  _getOptions(String token) => Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

  Future<APIResponse<Friend>> loadConnectedFriend(AuthToken? authToken) async {
    var urlFriend = "$url/${authToken!.userId}";
    try {
      final response = await _dio.get(
        urlFriend,
        options: _getOptions(token),
      );
      return APIResponse(
        data: Friend.fromJson(response.data),
      );
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
          content: error.toString(),
        ),
      );
    }
  }

  Future<APIResponse<bool>> updateLoginPicture(
    int friendId,
    XFile imageImporte,
  ) async {
    MultipartFile file = await MultipartFile.fromFile(imageImporte.path);
    var urlFriend = "$url/$friendId/upload/profile-image";
    try {
      final response = await _dio.post(urlFriend, data: file);
      return APIResponse(data: response.data);
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
          content: error.toString(),
        ),
      );
    }
  }

  Future<APIResponse<List<Friend>>> getFriends() async {
    List<Friend> list = [];
    try {
      final response = await _dio.get(url, options: _getOptions(token));
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
          content: error.toString(),
        ),
      );
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
            return APIResponse(
              error: APIError.fromJson(error.response?.data),
            );
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

  Future<APIResponse<Friend>> updateUser(Friend friend) async {
    try {
      final response = await _dio.put(url, data: friend.toJson());
      return APIResponse<Friend>(data: Friend.fromJson(response.data));
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
          content: error.toString(),
        ),
      );
    }
  }
}
