import 'package:dio/dio.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/friend.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/api.service.dart';

class SortieRepository extends ApiService {
  final Dio _dio = Dio();
  late String domain;

  SortieRepository(Dio dio, String domain) : super(dio, domain);

  Future<APIResponse<List<Sortie>>> getSorties() async {
    List<Sortie> list = [];
    try {
      final response = await _dio.get("$domain/sortie");
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
              content: error.toString()));
    }
  }

  Future<APIResponse<bool>> addOuting(Sortie sortie) async {
    try {
      final responseLogin =
          await _dio.post("$domain/sortie", data: sortie.toJson());
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
              content: error.toString()));
    }
  }

  Future<APIResponse<bool>> addFriendToOuting(
      Friend friend, Sortie sortie) async {
    int? idFriend = friend.id;
    int? idSortie = sortie.id;
    try {
      final responseLogin =
          await _dio.put("$domain/sortie/$idSortie/$idFriend");
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
              content: error.toString()));
    }
  }

  Future<APIResponse<Sortie>> getOneSortie(String sortieId) async {
    try {
      final responseDio = await _dio.get("$domain/sortie/$sortieId");
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
              content: error.toString()));
    }
  }
}
