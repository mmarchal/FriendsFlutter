import 'package:dio/dio.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';

class SortieRepository {
  final Dio _dio = Dio();
  final String url = "$domaine/sortie";
  final String token;

  SortieRepository({
    required this.token,
  });

  _getOptions(String token) => Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

  Future<APIResponse<List<Sortie>>> getSorties() async {
    List<Sortie> list = [];
    try {
      final response = await _dio.get(
        url,
        options: _getOptions(token),
      );
      for (var element in response.data) {
        list.add(Sortie.fromJson(element));
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
          content: error.toString(),
        ),
      );
    }
  }

  Future<APIResponse<bool>> addOuting(Sortie sortie) async {
    try {
      final responseLogin = await _dio.post(
        url,
        data: sortie.toJson(),
        options: _getOptions(token),
      );
      bool response = responseLogin.data;
      return APIResponse(data: response);
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

  Future<APIResponse<bool>> addFriendToOuting(
      Friend friend, Sortie sortie) async {
    String? idFriend = friend.uid;
    int? idSortie = sortie.id;
    try {
      final responseLogin = await _dio.put(
        "$url/$idSortie/$idFriend",
        options: _getOptions(token),
      );
      bool response = responseLogin.data;
      return APIResponse(data: response);
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

  Future<APIResponse<Sortie>> getOneSortie(String sortieId) async {
    try {
      final responseDio = await _dio.get(
        "$url/$sortieId",
        options: _getOptions(token),
      );
      return APIResponse(data: Sortie.fromJson(responseDio.data));
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
}
