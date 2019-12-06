class ModelInvoice {
  String uuid;
  String branchesid;
  String invoiceno;
  String amount;

  Map<String, dynamic> bodyReceipt(ModelInvoice modelInvoice) {
    if (modelInvoice.uuid != null && modelInvoice.branchesid != null && modelInvoice.invoiceno != null && modelInvoice.amount != null) {
      Map<String, dynamic> body = {
        "uuid": modelInvoice.uuid,
        "branchesid": modelInvoice.branchesid,
        "invoiceno": modelInvoice.invoiceno,
        "amount": modelInvoice.amount
      };
      return body;
    } else {
      return {};
    }
  }
}