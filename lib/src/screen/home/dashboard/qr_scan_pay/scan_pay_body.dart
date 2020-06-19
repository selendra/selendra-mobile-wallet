import 'package:wallet_apps/index.dart';

Widget scanPayBodyWidget(
  BuildContext context,
  bool enableInput,
  dynamic dialog,
  ModelScanPay _modelScanPay,
  Function validateWallet, Function validateAmount, Function validateMemo,
  Function onChanged, Function onSubmit,
  Function payProgress, Function validateInput, Function clickSend, Function resetAssetsDropDown,
  PopupMenuItem Function(Map<String, dynamic>) item
) {
  return Form(
    key: _modelScanPay.formStateKey,
    child: Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: inputField(
            context: context, 
            labelText: "Receiver address", 
            widgetName: 'sendTokenScreen',
            textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)], 
            inputType: TextInputType.number, 
            controller: _modelScanPay.controlReceiverAddress, 
            focusNode: _modelScanPay.nodeReceiverAddress, 
            validateField: validateWallet, 
            onChanged: onChanged, 
            enableInput: enableInput,
            action: onSubmit
          )
        ),
        Container( /* Type of payment */
          margin: EdgeInsets.only(top: 20.0),
          child: customDropDown(
            _modelScanPay.asset != null ? _modelScanPay.asset : "Asset name", 
            _modelScanPay.portfolio, 
            _modelScanPay, 
            resetAssetsDropDown,
            item
          ),
        ),
        /* User Fill Out Amount */
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: inputField(
            context: context, 
            labelText: "Amount", 
            widgetName: 'sendTokenScreen',
            textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)], 
            inputType: TextInputType.number, 
            controller: _modelScanPay.controlAmount, 
            focusNode: _modelScanPay.nodeAmount, 
            validateField: validateAmount, 
            onChanged: onChanged, 
            action: onSubmit
          )
        ),
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: inputField(
            context: context, 
            labelText: "Memo",
            widgetName: "sendTokenScreen", 
            textInputFormatter: [LengthLimitingTextInputFormatter(TextField.noMaxLength)], 
            inputAction: TextInputAction.done,
            controller: _modelScanPay.controlMemo, 
            focusNode: _modelScanPay.nodeMemo, 
            validateField: validateMemo, 
            onChanged: onChanged, 
            action: onSubmit
          ),
        ),
        /* Button Send */
        Container(
          margin: EdgeInsets.only(top: 20.0),
          child: customFlatButton(
            context, 
            "Send", "sendTokenScreen", AppColors.blueColor, 
            FontWeight.bold,
            size18,
            EdgeInsets.only(top: size10, bottom: size10),
            EdgeInsets.only(top: size15, bottom: size15),
            BoxShadow(
              color: Color.fromRGBO(0,0,0,0.0),
              blurRadius: 0.0
            ), 
            _modelScanPay.enable == false ? null : clickSend
          ),
        )
      ],
    ),
  );
}