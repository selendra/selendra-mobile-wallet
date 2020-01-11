import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';
import 'package:flutter/material.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:wallet_apps/src/model/model_scan_invoice.dart';

Widget invoiceBodyWidget(
  BuildContext _context,
  ModelScanInvoice _modelScanInvoice,
  Function shopChanged, Function textChanged,  Function toSummaryInvoice, Function popScreen,
) {
  return scaffoldBGDecoration(
    16, 16, 16, 0, 
    color1, color2, 
    Column(
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
              containerTitle("Invoice Information", double.infinity, Colors.white, FontWeight.bold), /* Title AppBar */
            ],
          )
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.only(left: 24.0, right: 24.0, top: 34.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded( /* Store Location */
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12.0),
                        child: SimpleAutoCompleteTextField(
                          key: _modelScanInvoice.key,
                          style: TextStyle(color: Colors.white),
                          suggestions: _modelScanInvoice.listNameOfBranches,
                          controller: _modelScanInvoice.controlLocation,
                          clearOnSubmit: true,
                          textSubmitted: (text) {
                            shopChanged(text);
                          },
                          decoration: InputDecoration(
                            labelText: "Store Location",
                            fillColor: getHexaColor("FFFFFF").withOpacity(0.15), filled: true,
                            contentPadding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 24.0, right: 24.0),
                            labelStyle: TextStyle(color: Colors.white),
                            /* Border side */
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _modelScanInvoice.controlLocation.text != "" ? getHexaColor("#95989A") : Colors.transparent, 
                                width: 1.0
                              ),
                            ),
                            focusedBorder: outlineInput(getHexaColor(borderColor)),
                            /* Error Handler */
                            border: errorOutline(),
                            focusedErrorBorder: errorOutline(),
                            suffixIcon: Icon(OMIcons.search, color: whiteNormalColor,)
                          ),
                        )
                        // Theme(a
                        //   data: ThemeData(cardColor: whiteNormalColor, cardTheme: CardTheme(color: Colors.white)),
                        //   child: textField
                          // DropDownField(
                          //   hintText: "Choose country",
                          //   items: countries,
                          // )
                          // DropdownButton(
                          //   value: shopName,
                          //   items: listOfBranches == null ? null : listOfBranches.map((list){
                          //     return DropdownMenuItem(
                          //       child: Text('${list['branchName']}', style: TextStyle(color: Colors.white),),
                          //       value: list['_id'],
                          //     );
                          //   }).toList(),
                          //   onChanged: (branchId) {
                          //     shopChanged(branchId);
                          //   },
                          // ),
                        // ),
                      ),
                    ),

                    /* X Button */
                    Container(
                      child: IconButton(
                        iconSize: 24.0,
                        color: whiteNormalColor,
                        icon: Icon(OMIcons.close),
                        onPressed: () {
                          _modelScanInvoice.controlLocation.clear();
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelScanInvoice.bloc,
                    _context, 
                    "Bills number", null, 'invoiceInfoScreen', 
                    false, 
                    TextField.noMaxLength,
                    TextInputType.text, TextInputAction.next,
                    _modelScanInvoice.controlBillNO, 
                    _modelScanInvoice.nodeBill, 
                    textChanged,
                    null
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    _modelScanInvoice.bloc, 
                    _context, 
                    "Amount", null, 'invoiceInfoScreen', 
                    false, 
                    TextField.noMaxLength,
                    TextInputType.number, TextInputAction.done, 
                    _modelScanInvoice.controlAmount, 
                    _modelScanInvoice.nodeAmount, 
                    textChanged, 
                    null
                  ),
                ),
                customFlatButton(
                  _modelScanInvoice.bloc, 
                  _context, 
                  "Next", "invoiceInfoScreen", blueColor,
                  FontWeight.bold, 18.0, 
                  EdgeInsets.only(top: size10, bottom: 0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ),
                  toSummaryInvoice
                )
              ],
            ),
          ),
        )
      ],
    ) 
  );
}