import 'package:wallet_apps/index.dart';

Widget receivedTrxBody(List<dynamic> _trxHistory, String _walletKey, InstanceTrxOrder _instanceTrxOrder) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TrxComponent.trxListByMonth(_instanceTrxOrder.m12, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m11, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m10, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m9, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m8, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m7, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m6, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m5, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m4, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m3, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m2, "Received"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m1, "Received")
      ],
    )
  );
}