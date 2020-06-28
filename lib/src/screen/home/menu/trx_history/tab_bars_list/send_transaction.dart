import 'package:wallet_apps/index.dart';

Widget sendBody(List<dynamic> _trx, String _walletKey, InstanceTrxOrder _instanceTrxOrder) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TrxComponent.trxListByMonth(_instanceTrxOrder.m12, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m11, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m10, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m9, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m8, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m7, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m6, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m5, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m4, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m3, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m2, "Send"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m1, "Send")
      ],
    )
  );
}