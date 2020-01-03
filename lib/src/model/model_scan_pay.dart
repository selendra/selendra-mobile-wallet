import 'package:flutter/widgets.dart';

class ModelScanPay{
  /* Scan Pay */
  String pin;
  String asset;
  String destination;
  bool isSuccessPin = false, isPay = false;
  List portfolio = [];

  TextEditingController controlAmount = TextEditingController();
  TextEditingController controlMemo = TextEditingController();

  FocusNode nodeAmount = FocusNode();
  FocusNode nodeMemo = FocusNode();
  
}