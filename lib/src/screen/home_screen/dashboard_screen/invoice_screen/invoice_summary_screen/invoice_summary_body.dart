import 'package:flutter/material.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_reuse_widget.dart';

Widget invoiceSummaryBodyWidget(
  BuildContext _context,
  ModelScanInvoice _modelScanInvoice,
  Function onChanged, Function verifyInvoice, Function popScreen
) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        containerAppBar( /* App Bar */
          _context, 
          Row( /* Sub AppBar */
            children: <Widget>[
              iconAppBar( /* Menu Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen
              ),
              containerTitle("Invoice Summary", double.infinity, Colors.white, FontWeight.bold), /* Title AppBar */
            ],
          )
        ),
        Card( /* Summary Invoice */
          margin: EdgeInsets.only(top: 34.0, left: 0, right: 0, bottom: 0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Container( /* Invoice */
                  width: double.infinity,
                  color: Colors.white,
                  margin: EdgeInsets.only(bottom: 9.0),
                  child: Image.network(_modelScanInvoice.imageUri['uri']), height: 172,
                ),
                invoiceSummary("Store location", _modelScanInvoice.controlAmount.text, FontWeight.normal) /* Store Location */,
                invoiceSummary("Bills number", _modelScanInvoice.controlBillNO.text, FontWeight.bold) /* Bill Number */,
                invoiceSummary("Amount", "\$${_modelScanInvoice.controlAmount.text}", FontWeight.bold) /* Receipt Amount */,
              ],
            ),
          ),
        ),
        Container( /* Authorization Code */
          margin: EdgeInsets.only(left: 27, right: 27.0, top: 27.0),
          child: inputField(
            _modelScanInvoice.bloc, 
            _context, 
            "Authorization code", null, "invoiceSummary", 
            true, 
            TextInputType.text, TextInputAction.done,
            _modelScanInvoice.controlApproveCode, 
            _modelScanInvoice.nodeApproveCode, 
            onChanged, 
            verifyInvoice
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 27, right: 27.0, top: 27.0),
          child: customFlatButton(
            _modelScanInvoice.bloc, 
            _context, 
            "Submit", "submitReceiptScreen", blueColor, 
            FontWeight.normal,
            size18,
            EdgeInsets.only(top: size10, bottom: size10),
            EdgeInsets.only(top: size15, bottom: size15),
            BoxShadow(
              color: Color.fromRGBO(0,0,0,0.54),
              blurRadius: 5.0
            ),
            verifyInvoice
          )
          // SliderButton(
          //   boxShadow: BoxShadow(color: Colors.transparent, blurRadius: 0.0),
          //   buttonColor: Colors.black54,
          //   icon: Align(alignment: Alignment.center, child: Icon(Icons.arrow_forward_ios, color: whiteNormalColor,),),
          //   label: Text('Slide to submit !'),
          //   action: () {
              // verifyInvoice(_modelScanInvoice.bloc, _context);
          //   },
          // ),
        )
      ],
    ),
  );
}