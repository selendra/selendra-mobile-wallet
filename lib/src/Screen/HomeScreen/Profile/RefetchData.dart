import 'package:flutter/material.dart';

Widget reFetchData(dynamic bodyWidget, Function refetchFunction){
  refetchFunction();
  return bodyWidget;
}