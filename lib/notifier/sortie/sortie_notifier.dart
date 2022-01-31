import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/service/sortie.repository.dart';

class SortieNotifier extends ChangeNotifier {
  final List<Sortie> _mesSorties = [];
  final String _userId;

  APIResponse<List<Sortie>>? sorties;

  SortieNotifier(this._userId);

  Future loadMesSorties({bool clearList = false}) async {
    if (clearList) {
      _mesSorties.clear();
      sorties = null;
    }

    try {
      var apiResponse = await FriendRepository().getMySorties(_userId);
      if (apiResponse.isSuccess) {
        _mesSorties.addAll(apiResponse.data!);
        sorties = APIResponse(data: _mesSorties, type: apiResponse.type);
      } else {}
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
