import 'package:wallet_apps/index.dart';

Widget invoiceBody(
  BuildContext _context,
  ModelScanInvoice _modelScanInvoice,
  Function shopChanged, Function onChanged, Function onSubmit,
  Function validateLocation, Function validateBillNO, Function validateAmount, Function validateAllField,
  Function toSummaryInvoice, Function popScreen,
) {
  return Column(
    children: <Widget>[
      MyAppBar(
        title: "Transaction option"
      ),
      Form(
        key: _modelScanInvoice.formState1,
        child: Expanded(
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
                          focusNode: _modelScanInvoice.nodeLocation,
                          textSubmitted: validateLocation,
                          decoration: InputDecoration(
                            labelText: "Store Location",
                            fillColor: hexaCodeToColor("FFFFFF").withOpacity(0.15), filled: true,
                            contentPadding: EdgeInsets.only(top: 25.0, bottom: 25.0, left: 24.0, right: 24.0),
                            labelStyle: TextStyle(color: Colors.white),
                            /* Border side */
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: _modelScanInvoice.controlLocation.text != "" ? hexaCodeToColor("#95989A") : Colors.transparent, 
                                width: 1.0
                              ),
                            ),
                            focusedBorder: myTextInputBorder(hexaCodeToColor(AppColors.borderColor)),
                            /* Error Handler */
                            border: errorOutline(),
                            focusedErrorBorder: errorOutline(),
                            suffixIcon: Icon(Icons.search, color: AppColors.whiteNormalColor,)
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
                    Container( /* Clear Butoon Symbol X To Clear Location */
                      child: IconButton( 
                        iconSize: 24.0,
                        color: AppColors.whiteNormalColor,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          _modelScanInvoice.controlLocation.clear();
                          validateAllField();
                        },
                      ),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    context: _context, 
                    labelText: "Bills number", 
                    widgetName: 'invoiceInfoScreen', 
                    textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                    controller: _modelScanInvoice.controlBillNO, 
                    focusNode: _modelScanInvoice.nodeBillNo, 
                    validateField: validateBillNO, 
                    onChanged: onChanged, 
                    action: onSubmit
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 12.0),
                  child: inputField(
                    context: _context, 
                    labelText: "Amount", 
                    widgetName: 'invoiceInfoScreen', 
                    textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
                    inputAction: TextInputAction.done,
                    controller: _modelScanInvoice.controlAmount, 
                    focusNode: _modelScanInvoice.nodeAmount, 
                    validateField: validateAmount, 
                    onChanged: onChanged, 
                    action: onSubmit
                  ),
                ),
                customFlatButton(
                  _context, 
                  "Next", "invoiceInfoScreen", AppColors.blueColor,
                  FontWeight.bold, 18.0, 
                  EdgeInsets.only(top: size10, bottom: 0),
                  EdgeInsets.only(top: size15, bottom: size15),
                  BoxShadow(
                    color: Color.fromRGBO(0,0,0,0.54),
                    blurRadius: 5.0
                  ),
                  _modelScanInvoice.enable1 == false ? null : toSummaryInvoice
                )
              ],
            ),
          ),
        ),
      )
    ],
  ) ;
}