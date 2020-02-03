import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary.dart';
import './invoice_info_body.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

class InvoiceInfo extends StatefulWidget{

  final ModelScanInvoice _modelScanInvoice;

  InvoiceInfo(this._modelScanInvoice);
  @override
  State<StatefulWidget> createState() {
    return InvoiceInfoState();
  }
}

class InvoiceInfoState extends State<InvoiceInfo> {

  @override
  initState(){
    getAllBranches();
    getOnlyBranchesName();
    super.initState();
  }

  /* ---------------Rest Api--------------- */
  void getOnlyBranchesName() async {
    var _response = await getAllBranches();
    for (int i = 0; i < _response.length; i++){
      widget._modelScanInvoice.listNameOfBranches.add(_response[i]['branches_name']);
      // _modelScanInvoice.listIdOfBranch.add(_response[i]['_id']);
    }
    setState(() { });
  }

  void onChanged(String changed) {
    widget._modelScanInvoice.formState1.currentState.validate();
    if (widget._modelScanInvoice.controlLocation.text != "") validateAllField(); /* Validate All Field To Enable Button Submit */
  }

  void onSubmit(BuildContext context){
    if (widget._modelScanInvoice.nodeBillNo.hasFocus){
      FocusScope.of(context).requestFocus(widget._modelScanInvoice.nodeAmount);
    } else if (widget._modelScanInvoice.enable1 == true){
      toSummaryInvoice();
    }
  }

  void shopChanged(String branchName) async {
    // print(branchName);
    // // getIdFromBranchName(branchName);
    // await Future.delayed(Duration(milliseconds: 100), (){
    //   setState(() {
    //     widget._modelScanInvoice.controlLocation.text = branchName;
    //   });
    // });
    // print(widget._modelScanInvoice.controlLocation.text);
  }

  void getIdFromBranchName(String branchName) {
    // int index = listOfBranches.indexOf(branchName);
    // modelInvoice.branchesid = listIdOfBranch[index];
  }

  void validateLocation(String value) async {
    await Future.delayed(Duration(milliseconds: 100), (){
      setState(() {
        widget._modelScanInvoice.controlLocation.text = value;
      });
    });
    validateAllField();
  }

  String validateBillNO(String value){
    if (widget._modelScanInvoice.nodeBillNo.hasFocus){
      widget._modelScanInvoice.responseBillNO = instanceValidate.validateInvoice(value);
      validateAllField(); /* Validate All Field To Enable Button Submit */
      if (widget._modelScanInvoice.responseBillNO != null) return widget._modelScanInvoice.responseBillNO += "bill number";
    }
    return widget._modelScanInvoice.responseBillNO;
  }

  String validateAmount(String value){
    if (widget._modelScanInvoice.nodeAmount.hasFocus){
      widget._modelScanInvoice.responseAmount = instanceValidate.validateInvoice(value);
      validateAllField(); /* Validate All Field To Enable Button Submit */
      if (widget._modelScanInvoice.responseAmount != null) return widget._modelScanInvoice.responseAmount += "amount";
    }
    return widget._modelScanInvoice.responseAmount;
  }

  void validateAllField(){
    if (
      widget._modelScanInvoice.controlLocation.text != '' &&
      widget._modelScanInvoice.controlBillNO.text != '' &&
      widget._modelScanInvoice.controlAmount.text != ''
    ) setState(() => widget._modelScanInvoice.enable1 = true );
    else if (widget._modelScanInvoice.enable1 == true ) setState(() => widget._modelScanInvoice.enable1 = false );

  }

  void toSummaryInvoice() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceSummary(widget._modelScanInvoice)));
  }
  
  void popScreen() => Navigator.pop(context);

  void dispose() {
    widget._modelScanInvoice.controlLocation.clear();
    widget._modelScanInvoice.controlAmount.clear();
    widget._modelScanInvoice.controlBillNO.clear();
    super.dispose();
  }
  
  Widget build(BuildContext _context) {
    return Scaffold(
      body: invoiceBodyWidget(
        _context,
        widget._modelScanInvoice,
        shopChanged, onChanged, onSubmit,
        validateLocation, validateBillNO, validateAmount, validateAllField,
        toSummaryInvoice, popScreen
      ),
    );
    // AlertDialog(
    //   title: Align(alignment: Alignment.center, child: titleAppBar("Confirm Receipt")),
    //   content: ,
    // );
  }
}