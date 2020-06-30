import 'package:wallet_apps/index.dart';

Widget allTrxBody(List<dynamic> _trxHistory, InstanceTrxOrder _instanceTrxOrder) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TrxComponent.trxListByMonth(_instanceTrxOrder.m12, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m11, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m10, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m9, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m8, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m7, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m6, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m5, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m4, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m3, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m2, "All"),
        TrxComponent.trxListByMonth(_instanceTrxOrder.m1, "All")
      ],
    )
  );
}