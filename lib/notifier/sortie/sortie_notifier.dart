import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/service/sortie.repository.dart';

class SortieNotifier extends ChangeNotifier {
  final List<Sortie> _mesSorties = [];
  final String _userId;

  APIResponse<List<Sortie>>? sorties;
  APIResponse<List<int>>? participants;

  APIResponse<Sortie>? uniqueSortie;

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

  Future loadOneSortie(
      {bool clearSortie = false, required String sortieId}) async {
    if (clearSortie) {
      uniqueSortie = null;
    }

    try {
      var apiResponse = await SortieRepository().getOneSortie(sortieId);
      if (apiResponse.isSuccess) {
        uniqueSortie =
            APIResponse(data: apiResponse.data, type: apiResponse.type);
      } else {}
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }
}
