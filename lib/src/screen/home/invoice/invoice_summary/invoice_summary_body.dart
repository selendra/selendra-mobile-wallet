import 'package:wallet_apps/index.dart';

Widget invoiceSummaryBody(
  BuildContext _context,
  ModelScanInvoice _modelScanInvoice,
  Function onChanged, Function onSubmit, Function validateApproveCode,
  Function confirmInvoice, Function popScreen
) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyAppBar(
          title: "Invoice Summary"
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
                  child: Image.file(_modelScanInvoice.imageCapture), 
                    height: 172,
                ),
                invoiceSummary("Store location", _modelScanInvoice.controlAmount.text, FontWeight.normal) /* Store Location */,
                invoiceSummary("Bills number", _modelScanInvoice.controlBillNO.text, FontWeight.bold) /* Bill Number */,
                invoiceSummary("Amount", "\$${_modelScanInvoice.controlAmount.text}", FontWeight.bold) /* Receipt Amount */,
              ],
            ),
          ),
        ),
        Form(
          key: _modelScanInvoice.formState2,
          child: Container( /* Authorization Code */
            margin: EdgeInsets.only(left: 27, right: 27.0, top: 27.0),
            child: inputField(
              context: _context, 
              labelText: "Authorization code", 
              widgetName: "invoiceSummary", 
              obcureText: true, 
              textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)],
              inputAction: TextInputAction.done,
              controller: _modelScanInvoice.controlApproveCode, 
              focusNode: _modelScanInvoice.nodeApproveCode, 
              validateField: validateApproveCode, 
              onChanged: onChanged, 
              action: onSubmit
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 27, right: 27.0, top: 27.0),
          child: customFlatButton( 
            _context, 
            "Submit", "submitReceiptScreen", AppColors.blueColor, 
            FontWeight.normal,
            size18,
            EdgeInsets.only(top: size10, bottom: size10),
            EdgeInsets.only(top: size15, bottom: size15),
            BoxShadow(
              color: Color.fromRGBO(0,0,0,0.54),
              blurRadius: 5.0
            ),
            _modelScanInvoice.enable2 == false ? null : confirmInvoice
          ),
          // SliderButton(
          //   boxShadow: BoxShadow(color: Colors.transparent, blurRadius: 0.0),
          //   buttonColor: Colors.black54,
          //   icon: Align(alignment: Alignment.center, child: Icon(Icons.arrow_forward_ios, color: whiteNormalColor,),),
          //   label: Text('Slide to submit !'),
          //   action: () {
              // confirmInvoice(_modelScanInvoice.bloc, _context);
          //   },
          // ),
        )
      ],
    ),
  );
}