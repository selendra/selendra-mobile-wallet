import 'package:flutter/material.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_summary_body.dart';

class InvoiceSummary extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return InvoiceSummaryState();
  }
}

class InvoiceSummaryState extends State<InvoiceSummary>  {
  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        16, 16, 0, 0, 
        color1, color2,
        Stack(
          children: <Widget>[
            containerAppBar(
              context, 
              invoiceSummaryBodyWidget()
            )
          ],
        )
      ),
    );
  }
}