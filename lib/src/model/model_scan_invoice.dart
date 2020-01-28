import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/widgets.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';

class ModelScanInvoice {
  
  final formStateScanInvoice = GlobalKey<FormState>();

  TextEditingController controlBillNO = TextEditingController(text: ""), 
    controlAmount = TextEditingController(text: ""), 
    controlLocation = TextEditingController(text: ""),
    controlApproveCode = TextEditingController(text: "");

  FocusNode nodeBill = FocusNode(), nodeAmount = FocusNode(), nodeApproveCode = FocusNode();

  SimpleAutoCompleteTextField textField;

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  List<String> listNameOfBranches = [], listIdOfBranch = [];

  String shopName;
  Map<String, dynamic> imageUri; 
  
  File imageCapture;
}