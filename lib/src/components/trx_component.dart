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
        return GestureDetector(
          onTap: () {
            Navigator.push(context, transitionRoute(TrxHistoryDetails(trx[index], tab)));
          },
          child: rowDecorationStyle(
            child: Row(
              children: <Widget>[

                MyCircularImage(
                  padding: EdgeInsets.all(6),
                  margin: EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                    color: hexaCodeToColor(AppColors.secondary),
                    borderRadius: BorderRadius.circular(40)
                  ),
                  imagePath: 'assets/sld_logo.svg',
                  width: 50,
                  height: 50,
                  colorImage: Colors.white,
                ),

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "SEL",
                          color: "#FFFFFF",
                          fontSize: 18,
                        ),
                        MyText(text: "Selendra", fontSize: 15),
                      ],
                    ),
                  ),
                ),

                MyText(
                  text: trx[index]["amount"].toString(), 
                  color: "#FFFFFF",
                  fontSize: 18,
                )
              ],
            )
          ),
        );
      }
    );
  }

  static Widget trxListByMonth(List trx, {String tab}){
    return trx.length != 0 ? Column( // Prevent The Month Have No Trx
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Divider(color: hexaCodeToColor(AppColors.textColor), height: 1.0),
        ),
        TrxComponent.trxTitle(trx),
        TrxComponent.trxList(trx, tab: tab),
      ],
    ) : Container(
      // child: Column( // Prevent The Month Have No Trx
      //   children: <Widget>[
      //     Container(
      //       margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
      //       child: Divider(color: hexaCodeToColor(AppColors.textColor), height: 1.0),
      //     ),
      //     TrxComponent.trxTitle(trx),
      //     TrxComponent.trxList(trx, tab: tab),
      //   ],
      // ),
    );
  }
}