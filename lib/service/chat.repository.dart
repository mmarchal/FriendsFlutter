import 'package:dio/dio.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/login_service.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/chat.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/message.dart';
import 'package:life_friends/service/api.service.dart';

class ChatRepository extends ApiService {
  final String url = "$domaine/chat";
  final Dio _dio = Dio();

  ChatRepository(Dio dio, LoginService loginService) : super(dio);

  Future<APIResponse<List<Chat>>> getChannels(String idFriend) async {
    List<Chat> list = [];
    try {
      final response = await _dio.get("$url/$idFriend");
      for (var element in response.data) {
        list.add(Chat.fromJson(element));
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

  Future<APIResponse<bool>> createOneToOneChannel(
      {required int meId,
      required int friendLinkId,
      required String nameChannel}) async {
    String urlCreation = "$url/$meId/$friendLinkId/$nameChannel";
    try {
      final response = await _dio.post(urlCreation);
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
              content: error.toString()));
    }
  }

  Future<APIResponse<bool>> createMessageByChannelId(
      {required String channelId, required Message message}) async {
    try {
      final response =
          await _dio.post("$url/message/$channelId", data: message.toJson());
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
              content: error.toString()));
    }
  }
}
