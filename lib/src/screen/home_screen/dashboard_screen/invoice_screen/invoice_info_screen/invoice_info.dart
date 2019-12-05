import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_receipt.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary.dart';
import './invoice_info_body.dart';

class ReceiptVerify extends StatefulWidget{
  final String uuid;

  ReceiptVerify(this.uuid);

  @override
  State<StatefulWidget> createState() {
    return ReceiptVerifyState();
  }
}

class ReceiptVerifyState extends State<ReceiptVerify> {

  Bloc bloc = Bloc();

  TextEditingController _controllerBill = TextEditingController(text: ""), 
    _controllerAmount = TextEditingController(text: ""), 
    _controllerStore = TextEditingController(text: "");

  FocusNode _nodeBill = FocusNode(), _nodeAmount = FocusNode();

  SimpleAutoCompleteTextField textField;

  GlobalKey<AutoCompleteTextFieldState<String>> key = GlobalKey();

  List<String> listOfBranches = [], listIdOfBranch = [];

  String shopName;
  
  ModelReceipt modelReceipt = ModelReceipt();

  @override
  initState(){
    modelReceipt.uuid = widget.uuid;
    requestListOfBranches();
    super.initState();
  }

  void requestListOfBranches() async {
    var response = await listBranches();
    for (int i = 0; i < response.length; i++){
      listOfBranches.add(response[i]['branchName']);
      listIdOfBranch.add(response[i]['_id']);
    }
  }

  void textChanged(String label, String changed) {
    setState(() {
      if (label == "Bills number") modelReceipt.receiptno = changed;
      else if (label == "Amount")  modelReceipt.amount = changed;
    });
  }

  void shopChanged(String branchName) async {
    getIdFromBranchName(branchName);
    await Future.delayed(Duration(milliseconds: 100), (){
      setState(() {
        _controllerStore.text = branchName;
      });
    });
  }

  void confirmReceipt(Bloc bloc, BuildContext context) async {
    dialogLoading(context);
    Map<String, dynamic> dataResponse = await submitConfirmReceipt(modelReceipt);
    Navigator.pop(context);
    if (dataResponse != null) {
      await dialog(context, Text(dataResponse['message']), Icon(OMIcons.doneOutline, color: getHexaColor(highThenBackgroundColor),));
      Navigator.pop(context);
    }
  }

  void getIdFromBranchName(String branchName) {
    int index = listOfBranches.indexOf(branchName);
    modelReceipt.branchesid = listIdOfBranch[index];
  }

  void toSummaryInvoice() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceSummary()));
  }
  
  void popScreen() => Navigator.pop(context);
  
  Widget build(BuildContext context) {
    return Scaffold(
      body: receiptBodyWidget(
        bloc, 
        context, 
        shopName, _controllerStore, _controllerBill, _controllerAmount, 
        key, 
        listOfBranches, 
        _nodeBill, _nodeAmount,
        shopChanged, textChanged, toSummaryInvoice, popScreen
      ),
    );
    // AlertDialog(
    //   title: Align(alignment: Alignment.center, child: titleAppBar("Confirm Receipt")),
    //   content: ,
    // );
  }
}