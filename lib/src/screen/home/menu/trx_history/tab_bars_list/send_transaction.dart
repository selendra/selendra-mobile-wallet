import 'package:wallet_apps/index.dart';

Widget sendBody(List<dynamic> _trx, String _walletKey, InstanceTrxOrder _instanceTrxOrder) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TrxComponent.trxListByMonth(_instanceTrxOrder.m12, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m11, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m10, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m9, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m8, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m7, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m6, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m5, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m4, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m3, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m2, tab: "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m1, tab: "Send")
      ],
    )
  );
}