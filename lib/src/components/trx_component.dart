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

                // Stellar Icons
                !trx[index].containsKey("asset_code") 
                ? MyCircularImage(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: hexaCodeToColor(AppColors.secondary),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  imagePath: 'assets/stellar.svg',
                  width: 40,
                  height: 40,
                  colorImage: Colors.white,
                )

                // Another Crypto Images
                : MyCircularImage(
                  padding: EdgeInsets.all(6),
                  boxColor: AppColors.secondary,
                  decoration: BoxDecoration(
                    color: hexaCodeToColor(AppColors.secondary),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  imagePath: 'assets/stellar.svg',
                  width: 40,
                  height: 40,
                  colorImage: Colors.white,
                ),

                MyText(
                  text: trx[index].containsKey("asset_code")
                  ? trx[index]["asset_code"]
                  : "XLM",
                  color: "#EFF0F2",
                  fontSize: 16,
                ),

                /* Asset Code */
                Expanded(child: Container()),

                trx[index].containsKey('amount') 
                ? MyText(
                  text: trx[index]["balance"], 
                  color: "#00FFE8",
                  fontSize: 16,
                ) /* Balance */
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