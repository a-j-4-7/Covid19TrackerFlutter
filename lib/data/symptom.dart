 import 'package:flutter/foundation.dart';

class Symptom{


   final String title;
   final String image;

   Symptom({@required this.title, this.image});

    static List<Symptom> getSymptoms(){
      List<Symptom> list = [];
      list.add(Symptom(title: "Fever"));
      list.add(Symptom(title: "Cough"));
      list.add(Symptom(title: "Shortness \nof breath"));
      list.add(Symptom(title: "Chills/ \nShaking"));
      list.add(Symptom(title: "Headache"));
      list.add(Symptom(title: "Bodyache"));
      list.add(Symptom(title: "Sore throat"));
      list.add(Symptom(title: "Loss of smell and taste"));
      return list;
    }


 }