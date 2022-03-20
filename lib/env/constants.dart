import 'package:flutter/material.dart';
import 'package:life_friends/model/type_proposition.dart';
import 'package:life_friends/model/typesortie.dart';

const String domaine = "http://10.0.2.2:8080";
//const String domaine = "http://192.168.1.11:20000";
//const String domaine = "http://ns329111.ip-37-187-107.eu:20000";

const Gradient gNewSortie = LinearGradient(colors: [
  Color(0xFF5c8dff),
  Color(0xFF44d1ee),
]);

const Gradient gNextSorties = LinearGradient(colors: [
  Color(0xFF3b4254),
  Color(0xFFc2c2c1),
]);

const Gradient gMesSorties = LinearGradient(colors: [
  Color(0xFF307e51),
  Color(0xFF71f4c2),
]);

const Gradient gMessagerie =
    LinearGradient(colors: [Color(0xFFffd747), Color(0xFFff0000)]);

const Gradient gPropositions = LinearGradient(colors: [
  Color(0xFF7e3030),
  Color(0xFF8e71f4),
]);

//Proposition de sortie
List<TypeSortie> listeTypesSorties = [
  TypeSortie(
    id: 1,
    type: "Cinéma",
  ),
  TypeSortie(
    id: 2,
    type: "Sport",
  ),
  TypeSortie(
    id: 3,
    type: "Activité",
  ),
];

//Proposition de modif
List<TypeProposition> typePropositions = [
  TypeProposition(
    id: 1,
    type: "Amélioration de l'app",
  ),
  TypeProposition(
    id: 2,
    type: "Bug trouvé",
  ),
  TypeProposition(
    id: 3,
    type: "Nouvelle fonctionnalité",
  ),
];
