import 'package:wallet_apps/index.dart';

class TrxComponent {

  static Widget trxTitle(List trx){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
      child: trx.length != 0 ? Text(trx[0]['date']) : Text("Empty"),
    );
  }

  static Widget trxList(List trx, String tab){
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: trx.length,
      itemBuilder: (context, index){
        // print(length);
        return index != 0 ? GestureDetector(
          onTap: () {
            Navigator.push(context, transitionRoute(TrxHistoryDetails(trx[index], tab)));
          },
          child: Padding(
            padding: EdgeInsets.only(bottom: 15.0),
            child: Row( 
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 9.5),
                  width: 31.0, 
                  height: 31.0,
                  child: CircleAvatar(
                    backgroundImage: AssetImage(AppConfig.logoTrxHistroy)
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: trx[index].containsKey("asset_code") 
                  ? Text(trx[index]["asset_code"])
                  : Text("XLM"),
                ),
                Expanded(
                  flex: 0,
                  child: trx[index].containsKey('amount') ? Text(
                    trx[index]['amount'], 
                    style: TextStyle(color: getHexaColor(AppColors.greenColor)),
                  ) : Container(),
                )
              ],
            )
          ),
        ) : Container();
      }
    );
  }

  static Widget trxListByMonth(List trx, String tab){
    return trx.length != 0 ? Column( // Prevent The Month Have Have No Trx
      children: <Widget>[
        Divider(color: Colors.grey, height: 1.0),
        TrxComponent.trxTitle(trx),
        TrxComponent.trxList(trx, tab),
      ],
    ) : Container();
  }
}