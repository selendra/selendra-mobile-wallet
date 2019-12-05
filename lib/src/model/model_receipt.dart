class ModelReceipt {
  String uuid;
  String branchesid;
  String receiptno;
  String amount;

  Map<String, dynamic> bodyReceipt(ModelReceipt modelReceipt) {
    if (modelReceipt.uuid != null && modelReceipt.branchesid != null && modelReceipt.receiptno != null && modelReceipt.amount != null) {
      Map<String, dynamic> body = {
        "uuid": modelReceipt.uuid,
        "branchesid": modelReceipt.branchesid,
        "receiptno": modelReceipt.receiptno,
        "amount": modelReceipt.amount
      };
      return body;
    } else {
      return {};
    }
  }
}