import 'package:wallet_apps/index.dart';

class TrxComponent {

  static Widget trxTitle(List trx){
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 24, left: 16),
      child: trx.length != 0 ? MyText(text: trx[0]['date'], color: "#FFFFFF") : MyText(text: "Empty", color: "#FFFFFF"),
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
            child: Row(
              children: <Widget>[
                /* Asset Icons */
                !trx[index].containsKey("asset_code") 
                ? MyCircularImage(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.only(right: 16),
                  imagePath: 'assets/stellar.svg',
                  width: 40,
                  height: 40
                )
                : MyCircularImage(
                  padding: EdgeInsets.all(6),
                  boxColor: AppColors.secondary,
                  imagePath: 'assets/stellar.svg',
                  width: 40,
                  height: 40
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
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Divider(color: hexaCodeToColor(AppColors.textColor), height: 1.0),
        ),
        TrxComponent.trxTitle(trx),
        TrxComponent.trxList(trx, tab: tab),
      ],
    ) : Container();
  }
}