import 'package:wallet_apps/index.dart';

class TrxHistoryDetailsBody extends StatelessWidget{
  
  final String title;
  final Map<String, dynamic> trxInfo;
  final Function popScreen;

  TrxHistoryDetailsBody({
    this.title,
    this.trxInfo,
    this.popScreen
  });

  
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        
        MyAppBar(
          title: "$title Details",
          onPressed: popScreen,
        ),

        Container( /* Activity Information */
          margin: EdgeInsets.only(top: 30, left: 16, right: 16),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 2.0,
                offset: Offset(1.0, 1.0)
              )
            ],
            borderRadius: BorderRadius.circular(5.0),
            color: hexaCodeToColor(AppColors.cardColor),
          ),
          child: Column(
            children: <Widget>[
              rowInformation("Amount: ", trxInfo['amount']),
              rowInformation("Fee: ", trxInfo['fee']),
              rowInformation("From: ", trxInfo['sender']),
              rowInformation("To: ", trxInfo['destination']),
              rowInformation("Date: ", AppUtils.timeStampToDateTime(trxInfo['created_at'])),
            ],
          ),
        )
      ],
    );
  }
} 