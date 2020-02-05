import 'package:flutter/widgets.dart';

class ModelScanPay{

  final formStateKey = GlobalKey<FormState>();
  /* Scan Pay */
  String pin;
  String asset;
  String destination;
  String responseAmount, responseMemo;
  String loadingDot = "";
  bool isSuccessPin = false, isPay = false, enable = false;
  List portfolio = [];

  TextEditingController controlAmount = TextEditingController();
  TextEditingController controlMemo = TextEditingController();

  FocusNode nodeAmount = FocusNode();
  FocusNode nodeMemo = FocusNode();
  
}