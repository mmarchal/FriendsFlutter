import 'package:flutter/widgets.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/typesortie.dart';
import 'package:life_friends/service/typesortie.repository.dart';

class TypeSortieListNotifier extends ChangeNotifier {
  final List<TypeSortie> _list = [];
  final TypeSortieRepository typeSortieRepository;

  List<TypeSortie>? listeTypes;

  TypeSortieListNotifier(this.typeSortieRepository);

  Future loadTypesSorties({bool clearList = false}) async {
    if (clearList) _list.clear();
    APIResponse<List<TypeSortie>> response =
        await typeSortieRepository.getTypeSorties();
    if (response.isSuccess) {
      _list.addAll(response.data!);
      listeTypes = _list;
    }
    notifyListeners();
  }
}
