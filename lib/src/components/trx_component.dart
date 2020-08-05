import 'package:wallet_apps/index.dart';

class TrxComponent {

  static Widget trxTitle(List trx){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
      child: trx.length != 0 ? Text(trx[0]['date']) : Text("Empty"),
    );
  }

  static Widget trxList(List trx, {String tab}){
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
          child: rowDecorationStyle(
            marginTop: 5.0,
            child: 
            Row(
              children: <Widget>[
                /* Asset Icons */
                Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 35.0,
                  height: 35.0,
                  child: !trx[index].containsKey("asset_code") ? Image.asset(
                    "assets/images/stellar_xlm_logo.png",
                    color: Colors.white
                  )
                  : Image.asset('assets/images/stellar_xlm_logo.png')
                  // CircleAvatar(
                  //   backgroundColor: Colors.black26,
                  //   backgroundImage: AssetImage(
                  //     portfolioData[index].containsKey("asset_code") ? AppConfig.logoPortfolio : "assets/images/stellar_xlm_logo.png",
                  //   ),
                  // )
                ),

                DbdStyle.textStylePortfolio(
                  trx[index].containsKey("asset_code")
                  ? trx[index]["asset_code"]
                  : "XLM",
                  "#EFF0F2"
                ),

                /* Asset Code */
                Expanded(child: Container()),
                trx[index].containsKey('amount') 
                ? DbdStyle.textStylePortfolio(trx[index]["balance"], "#00FFE8") /* Balance */
                : Container()
              ],
            )
          ),
        ) : Container();
      }
    );
  }

  static Widget trxListByMonth(List trx, {String tab}){
    return trx.length != 0 ? Column( // Prevent The Month Have Have No Trx
      children: <Widget>[
        Divider(color: Colors.grey, height: 1.0),
        TrxComponent.trxTitle(trx),
        TrxComponent.trxList(trx, tab: tab),
      ],
    ) : Container();
  }
}