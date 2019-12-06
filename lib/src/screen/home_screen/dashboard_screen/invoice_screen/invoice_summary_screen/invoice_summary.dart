import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/http_request/rest_api.dart';
import 'package:wallet_apps/src/model/model_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary_body.dart';

class InvoiceSummary extends StatefulWidget{

  // final ModelInvoice modelInvoice;

  // InvoiceSummary(this.modelInvoice);

  @override
  State<StatefulWidget> createState() {
    return InvoiceSummaryState();
  }
}

class InvoiceSummaryState extends State<InvoiceSummary>  {

  Bloc bloc = Bloc();

  TextEditingController _controllerCode = TextEditingController(text: "");

  FocusNode _nodeCode = FocusNode();

  ModelInvoice _modelInvoice;

  @override
  void initState() {
    // _modelInvoice = widget.modelInvoice;
    super.initState();
  }

  void textChanged(String change) {

  } 

  void confirmInvoice(Bloc bloc, BuildContext context) async {
    dialogLoading(context);
    Map<String, dynamic> dataResponse = await submitInvoice(_modelInvoice);
    Navigator.pop(context);
    if (dataResponse != null) {
      await dialog(context, Text(dataResponse['message']), Icon(OMIcons.doneOutline, color: getHexaColor(highThenBackgroundColor),));
      Navigator.pop(context);
    }
  }

  void popScreen() {
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      
      body: scaffoldBGDecoration(
        16, 16, 16, 0, 
        color1, color2,
        Stack(
          children: <Widget>[
            invoiceSummaryBodyWidget(
              bloc, 
              context, 
              _controllerCode,
              _nodeCode,
              _modelInvoice,
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