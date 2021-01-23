import 'package:wallet_apps/index.dart';

class InvoiceSummary extends StatefulWidget {
  final ModelScanInvoice _modelScanInvoice;

  InvoiceSummary(this._modelScanInvoice);

  @override
  State<StatefulWidget> createState() {
    return InvoiceSummaryState();
  }
}

class InvoiceSummaryState extends State<InvoiceSummary> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  PostRequest _postRequest = PostRequest();

  @override
  void initState() {
    AppServices.noInternetConnection(_globalKey);
    super.initState();
  }

  void onChanged(String value) {
    widget._modelScanInvoice.formState2.currentState.validate();
  }

  void onSubmit(BuildContext context) {
    if (widget._modelScanInvoice.enable2 == true) confirmInvoice(context);
  }

  void confirmInvoice(BuildContext context) async {
    dialogLoading(context); /* Loading Process */
    Map<String, dynamic> _response =
        await _postRequest.addReceipt(widget._modelScanInvoice);
    if (!_response.containsKey("error")) {
      /* Display Messager To Dialog Box */
      await dialog(
          context,
          Text(_response["message"]),
          Icon(
            Icons.done_outline,
            color: hexaCodeToColor(AppColors.blueColor),
          )); /* Show Response */
      Navigator.pop(context);
      Navigator.pushNamedAndRemoveUntil(
          context, Home.route, ModalRoute.withName('/'));
    } else {
      /* Display Error To Dialog Box */
      Navigator.pop(context);
      await dialog(
          context, Text(_response["error"]["message"]), warningTitleDialog());
    }
  }

  String validateApproveCode(String value) {
    if (widget._modelScanInvoice.nodeApproveCode.hasFocus) {
      widget._modelScanInvoice.responseApproveCode =
          instanceValidate.validateInvoice(value);
      enableButton();
      if (widget._modelScanInvoice.responseApproveCode != null)
        return widget._modelScanInvoice.responseApproveCode += "auth code";
    }
    return widget._modelScanInvoice.responseApproveCode;
  }

  void enableButton() {
    if (widget._modelScanInvoice.controlApproveCode.text != '')
      setState(() => widget._modelScanInvoice.enable2 = true);
    else if (widget._modelScanInvoice.enable2 == true)
      setState(() => widget._modelScanInvoice.enable2 = false);
  }

  void popScreen() {
    Navigator.pop(context);
  }

  Widget build(BuildContext _context) {
    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(
          child: invoiceSummaryBody(
              _context,
              widget._modelScanInvoice,
              onChanged,
              onSubmit,
              validateApproveCode,
              confirmInvoice,
              popScreen)),
    );
  }
}
