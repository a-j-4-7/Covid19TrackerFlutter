 import 'package:flutter/foundation.dart';

class Prevention{

   final String title;
   final String image;

   Prevention({@required this.title, this.image});

   static List<Prevention> getPrevention(){
     List<Prevention> list = List();
     list.add(Prevention(title: 'Wash \nhands'));
     list.add(Prevention(title: 'Social \ndistance'));
     list.add(Prevention(title: 'Cover cough \n& sneezes'));
     list.add(Prevention(title: 'Clean & \ndisinfect'));
     list.add(Prevention(title: 'Use \nmasks'));
     list.add(Prevention(title: 'Use \nsanitizers'));
     list.add(Prevention(title: 'Stay \nat Home'));
    return list;
   }


}