import 'package:flutter/material.dart';
import 'package:slider_button/slider_button.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_invoice.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:wallet_apps/src/screen/home_screen/dashboard_screen/invoice_screen/invoice_summary_screen/invoice_reuse_widget.dart';

Widget invoiceSummaryBodyWidget(
  Bloc bloc,
  BuildContext context,
  TextEditingController _controllerCode,
  FocusNode _nodeCode,
  ModelInvoice modelInvoice,
  Function onChanged, Function verifyInvoice, Function popScreen
) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: <Widget>[
        containerAppBar( /* App Bar */
          context, 
          Row( /* Sub AppBar */
            children: <Widget>[
              iconAppBar( /* Menu Button */
                Icon(Icons.arrow_back, color: Colors.white,),
                Alignment.centerLeft,
                EdgeInsets.all(0),
                popScreen
              ),
              containerTitleAppBar("Invoice Summary"), /* Title AppBar */
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
                  child: Image.asset("assets/invoice.png", height: 172,),
                ),
                invoiceSummary("Store location", "TOUS les JOURS Kampuchea Krom", FontWeight.normal) /* Store Location */,
                invoiceSummary("Bills number", "15004341", FontWeight.bold) /* Bill Number */,
                invoiceSummary("Amount", "\$15.75", FontWeight.bold) /* Receipt Amount */,
              ],
            ),
          ),
        ),
        Container( /* Authorization Code */
          margin: EdgeInsets.only(left: 27, right: 27.0, top: 27.0),
          child: inputField(
            bloc, 
            context, 
            "Authorization code", null, "invoiceSummary", 
            true, 
            TextInputType.text, TextInputAction.done,
            _controllerCode, 
            _nodeCode, 
            onChanged, 
            verifyInvoice
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 27.0),
          child: SliderButton(
            boxShadow: BoxShadow(color: Colors.transparent, blurRadius: 0.0),
            buttonColor: Colors.black54,
            icon: Align(alignment: Alignment.center, child: Icon(Icons.arrow_forward_ios, color: whiteNormalColor,),),
            label: Text('Slide to submit !'),
            action: () {
              verifyInvoice(bloc, context);
            },
          ),
        )
      ],
    ),
  );
}