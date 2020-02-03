import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary_body.dart';
import 'package:wallet_apps/src/bloc/validator_mixin.dart';

class InvoiceSummary extends StatefulWidget{

  final ModelScanInvoice _modelScanInvoice;

  InvoiceSummary(this._modelScanInvoice);

  @override
  State<StatefulWidget> createState() {
    return InvoiceSummaryState();
  }
}

class InvoiceSummaryState extends State<InvoiceSummary>  {

  @override
  void initState() {
    super.initState();
  }

  void onChanged(String value) {
    widget._modelScanInvoice.formState2.currentState.validate();
  } 

  void onSubmit(BuildContext context){
    if (widget._modelScanInvoice.enable2 == true) confirmInvoice(context);
  }

  void confirmInvoice(BuildContext context) async {
    dialogLoading(context); /* Loading Process */
    Map<String, dynamic> _response = await addReceipt(widget._modelScanInvoice);
    if (!_response.containsKey("error")){ /* Display Messager To Dialog Box */
      await dialog(context, Text(_response["message"]), Icon(Icons.done_outline, color: getHexaColor(blueColor),)); /* Show Response */
      Navigator.pop(context);
      Navigator.pushAndRemoveUntil(
        context, 
        MaterialPageRoute(builder: (context) => Dashboard()), 
        ModalRoute.withName('/')
      );
    } else { /* Display Error To Dialog Box */
      Navigator.pop(context);
      await dialog(context, Text(_response["error"]["message"]), Icon(Icons.warning));
    }
  }

  String validateApproveCode(String value){
    if (widget._modelScanInvoice.nodeApproveCode.hasFocus){
      widget._modelScanInvoice.responseApproveCode = instanceValidate.validateInvoice(value);
      enableButton();
      if (widget._modelScanInvoice.responseApproveCode != null) return widget._modelScanInvoice.responseApproveCode += "auth code";
    }
    return widget._modelScanInvoice.responseApproveCode;
  }

  void enableButton(){
    if (widget._modelScanInvoice.controlApproveCode.text != '') setState(() => widget._modelScanInvoice.enable2 = true);
    else if (widget._modelScanInvoice.enable2 == true) setState(() => widget._modelScanInvoice.enable2 = false);
  }

  void popScreen() {
    Navigator.pop(context);
  }

  Widget build(BuildContext _context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16, 16, 16, 0, 
        color1, color2,
        Stack(
          children: <Widget>[
            invoiceSummaryBodyWidget(
              _context,
              widget._modelScanInvoice,
              onChanged, onSubmit, validateApproveCode,
              confirmInvoice,
              popScreen
            )
          ],
        )
      ),
    );
  }
}