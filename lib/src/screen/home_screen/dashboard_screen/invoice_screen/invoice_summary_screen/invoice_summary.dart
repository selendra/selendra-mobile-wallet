import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/dashboard.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary_body.dart';

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
    // _modelScanInvoice = widget.modelInvoice;
    super.initState();
  }

  void textChanged(String change) {

  } 

  void confirmInvoice(Bloc _bloc, BuildContext _context) async {
    dialogLoading(_context); /* Loading Process */
    var _response = await addReceipt(widget._modelScanInvoice);
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
    // Map<String, dynamic> dataResponse = await submitInvoice(_modelScanInvoice);
    // Navigator.pop(context);
    // if (dataResponse != null) {
    //   await dialog(context, Text(dataResponse['message']), Icon(OMIcons.doneOutline, color: getHexaColor(highThenBackgroundColor),));
    //   Navigator.pop(context);
    // }
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
              textChanged,
              confirmInvoice,
              popScreen
            )
          ],
        )
      ),
    );
  }
}