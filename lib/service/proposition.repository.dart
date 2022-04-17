import 'package:dio/dio.dart';
import 'package:life_friends/env/constants.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/error/api_error.dart';
import 'package:life_friends/model/error/type_error.dart';
import 'package:life_friends/model/proposition.dart';

class PropositionRepository {
  final Dio _dio = Dio();
  final String url = "$domaine/proposition";
  final String token;

  PropositionRepository({
    required this.token,
  });

  _getOptions(String token) => Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

  Future<APIResponse<bool>> addProposition(Proposition proposition) async {
    try {
      final response = await _dio.post(
        url,
        data: proposition.toJson(),
        options: _getOptions(token),
      );
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
          title: 'Erreur lors de la connexion',
          content: error.toString(),
        ),
      );
    }
  }
}
