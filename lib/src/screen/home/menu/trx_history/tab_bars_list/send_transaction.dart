import 'package:wallet_apps/index.dart';

Widget sendBody(List<dynamic> _trxHistory, String _walletKey, InstanceTrxOrder _instanceTrxOrder) {
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: Column( // Prevent The Month Have Have No Trx
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Divider(color: hexaCodeToColor(AppColors.textColor), height: 1.0),
              ),
              // TrxComponent.trxTitle(_trxHistory),
              TrxComponent.trxList(_trxHistory, tab: 'Send'),
            ],
          ),
        )
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m12, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m11, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m10, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m9, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m8, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m7, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m6, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m5, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m4, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m3, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m2, tab: "Send"),
        // TrxComponent.trxListByMonth(_instanceTrxOrder.m1, tab: "Send")
      ],
    )
  );
}