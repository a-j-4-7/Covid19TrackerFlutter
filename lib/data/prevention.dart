 import 'package:flutter/foundation.dart';

class Prevention{

   final String title;
   final String image;

   Prevention({@required this.title, this.image});

   static List<Prevention> getPrevention(){
     List<Prevention> list = List();
     list.add(Prevention(title: 'Wash \nhands'));
     list.add(Prevention(title: 'Social \nDistancing'));
     list.add(Prevention(title: 'Use \nMasks'));
     list.add(Prevention(title: 'Stay \nAt Home'));
    return list;
   }


}