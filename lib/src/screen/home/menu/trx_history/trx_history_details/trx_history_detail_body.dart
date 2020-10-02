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
              // rowInformation("Receipt no: ", trxInfo['receipt_no']),
              trxInfo['type'] == 'create_account' 
              ? rowInformation("Amount: ", trxInfo['starting_balance'])
              : rowInformation("Amount: ", trxInfo['amount'] ?? "0.00"),
              // rowInformation("Location: ", trxInfo['location']),
              trxInfo['type'] == "create_account" 
              ? rowInformation("Type:", trxInfo['type']) /* If Trx Type As Create Account */
              : rowInformation("Type: ", trxInfo['type'] == "payment" ? "Payment" : "Fee"),
              rowInformation("From: ", trxInfo['type'] == "payment" ? trxInfo['from'] : ""),
              rowInformation("To: ", trxInfo['type'] == "payment" ? trxInfo['to'] : ""),
              rowInformation("Date: ", AppUtils.timeStampToDateTime(trxInfo['created_at'])),
              // Divider(height: 1, color: Colors.white.withOpacity(0.1), thickness: 1.0,),
            ],
          ),
        )
      ],
    );
  }
} 