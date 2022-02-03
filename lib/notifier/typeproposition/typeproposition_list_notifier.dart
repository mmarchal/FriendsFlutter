import 'package:flutter/widgets.dart';
import 'package:life_friends/model/api/api_response.dart';
import 'package:life_friends/model/type_proposition.dart';
import 'package:life_friends/service/typeproposition.repository.dart';

class TypePropositionListNotifier extends ChangeNotifier {
  final List<TypeProposition> _list = [];
  final TypePropositionRepository typePropositionRepository;

  List<TypeProposition>? listeTypes;

  TypePropositionListNotifier(this.typePropositionRepository);

  Future loadTypesPropositions({bool clearList = false}) async {
    if (clearList) _list.clear();
    APIResponse<List<TypeProposition>> response =
        await typePropositionRepository.getTypePropositions();
    if (response.isSuccess) {
      _list.addAll(response.data!);
      listeTypes = _list;
    }
    notifyListeners();
  }
}
