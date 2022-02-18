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
    var api = await _sortieRepository.getSorties();
    listeSorties = api;
    notifyListeners();
  }

  Future loadMesSorties(
      {bool clearList = false, required String userId}) async {
    if (clearList) {
      _mesSorties.clear();
      sorties = null;
    }

    var apiResponse = await _friendRepository.getMySorties(userId);
    _mesSorties.addAll(apiResponse.data!);
    sorties = APIResponse(data: _mesSorties, type: apiResponse.type);
    notifyListeners();
  }

  Future loadOneSortie(
      {bool clearSortie = false, required String sortieId}) async {
    if (clearSortie) {
      uniqueSortie = null;
    }
    var apiResponse = await _sortieRepository.getOneSortie(sortieId);
    uniqueSortie = APIResponse(data: apiResponse.data, type: apiResponse.type);
    notifyListeners();
  }
}
