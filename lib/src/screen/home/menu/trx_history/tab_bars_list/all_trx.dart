import 'package:wallet_apps/index.dart';

Widget allTrxBody(List<dynamic> _trxHistory, InstanceTrxOrder _instanceTrxOrder) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TrxComponent.trxListByMonth(_instanceTrxOrder.m12, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m11, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m10, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m9, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m8, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m7, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m6, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m5, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m4, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m3, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m2, tab: "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m1, tab: "All")
      ],
    )
  );
}