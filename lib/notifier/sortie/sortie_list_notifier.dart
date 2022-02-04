import 'package:flutter/material.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/sortie.dart';
import 'package:life_friends/service/friend.repository.dart';
import 'package:life_friends/service/sortie.repository.dart';

class SortieListNotifier extends ChangeNotifier {
  final FriendRepository _friendRepository;
  final SortieRepository _sortieRepository;

  final List<Sortie> allSorties = [];
  final List<Sortie> _mesSorties = [];

  APIResponse<List<Sortie>>? sorties;
  APIResponse<List<Sortie>>? listeSorties;
  APIResponse<List<int>>? participants;

  APIResponse<Sortie>? uniqueSortie;

  SortieListNotifier(this._friendRepository, this._sortieRepository);

  Future loadAllSorties({bool clearList = false}) async {
    if (clearList) {
      listeSorties = null;
    }

    try {
      var api = await _sortieRepository.getSorties();
      if (api.isSuccess) {
        listeSorties = api;
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future loadMesSorties(
      {bool clearList = false, required String userId}) async {
    if (clearList) {
      _mesSorties.clear();
      sorties = null;
    }

    try {
      var apiResponse = await _friendRepository.getMySorties(userId);
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
      var apiResponse = await _sortieRepository.getOneSortie(sortieId);
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
