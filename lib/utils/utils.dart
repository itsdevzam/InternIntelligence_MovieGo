

import 'package:flutter/cupertino.dart';

class utils{

  static const String AppName = "Movie Go";

  ///Helper Functions
  static double getDeviceWidth(BuildContext context){
    return MediaQuery.sizeOf(context).width*1;
  }
  static double getDeviceHeight(BuildContext context){
    return MediaQuery.sizeOf(context).height*1;
  }

}