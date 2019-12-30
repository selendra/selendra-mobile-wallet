import 'package:flutter/widgets.dart';

class ModelScanPay{
  /* Scan Pay */
  String pin;
  String asset;
  String wallet;
  String amount;
  String memo;
  bool isSuccessPin = false, isPay = false;
  ModelScanPay modelPay = ModelScanPay();
  List portFolio = [];

  TextEditingController controlAmount = TextEditingController();
  TextEditingController controlMemo = TextEditingController();

  FocusNode nodeAmount = FocusNode();
  FocusNode nodeMemo = FocusNode();
}