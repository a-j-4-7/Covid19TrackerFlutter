 import 'package:flutter/foundation.dart';

class Symptom{


   final String title;
   final String image;

   Symptom({@required this.title, this.image});

    static List<Symptom> getSymptoms(){
      List<Symptom> list = [];
      list.add(Symptom(title: "Fever"));
      list.add(Symptom(title: "Cough"));
      list.add(Symptom(title: "Tiredness"));
      list.add(Symptom(title: "Difficulty \nbreathing"));
      list.add(Symptom(title: "Runny \nnose"));
      list.add(Symptom(title: "Chills/ \nShaking"));
      list.add(Symptom(title: "Headache"));
      list.add(Symptom(title: "Bodyache"));
      list.add(Symptom(title: "Sore \nthroat"));
      list.add(Symptom(title: "Loss of \nsmell"));
      list.add(Symptom(title: "Loss of \ntaste"));
      return list;
    }


 }