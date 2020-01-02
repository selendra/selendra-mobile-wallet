import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_invoice.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary.dart';
import './invoice_info_body.dart';

class InvoiceInfo extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return InvoiceInfoState();
  }
}

class InvoiceInfoState extends State<InvoiceInfo> {

  ModelScanInvoice _modelScanInvoice = ModelScanInvoice();

  @override
  initState(){
    getAllBranches();
    fetchAllBranches();
    super.initState();
  }

  /* ---------------Rest Api--------------- */
  void fetchAllBranches() async {
    var _response = await getAllBranches();
    print(_response);
    for (int i = 0; i < _response.length; i++){
      _modelScanInvoice.listNameOfBranches.add(_response[i]['branches_name']);
      // _modelScanInvoice.listIdOfBranch.add(_response[i]['_id']);
    }
    setState(() { });
  }

  void textChanged(String label, String changed) {
    // setState(() {
    //   if (label == "Bills number") modelInvoice.invoiceno = changed;
    //   else if (label == "Amount")  modelInvoice.amount = changed;
    // });
  }

  void shopChanged(String branchName) async {
    // getIdFromBranchName(branchName);
    print(branchName);
    await Future.delayed(Duration(milliseconds: 100), (){
      setState(() {
        _modelScanInvoice.controlLocation.text = branchName;
      });
    });
  }

  void getIdFromBranchName(String branchName) {
    // int index = listOfBranches.indexOf(branchName);
    // modelInvoice.branchesid = listIdOfBranch[index];
  }

  void toSummaryInvoice() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => InvoiceSummary(_modelScanInvoice)));
  }
  
  void popScreen() => Navigator.pop(context);
  
  Widget build(BuildContext _context) {
    return Scaffold(
      body: invoiceBodyWidget(
        _context,
        _modelScanInvoice,
        shopChanged, textChanged, toSummaryInvoice, popScreen
      ),
    );
    // AlertDialog(
    //   title: Align(alignment: Alignment.center, child: titleAppBar("Confirm Receipt")),
    //   content: ,
    // );
  }
}