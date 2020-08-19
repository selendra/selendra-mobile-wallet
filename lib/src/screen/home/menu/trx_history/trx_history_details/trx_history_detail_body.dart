import 'package:wallet_apps/index.dart';

Widget trxHistoryDetailsBody(
  String title, 
  BuildContext _context,
  Map<String, dynamic> _trxInfo,
  Function _popScreen
){
  return SafeArea(
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            containerAppBar( /* AppBar */
              _context, 
              Row(
                children: <Widget>[
                  iconAppBar( /* Arrow Back Button */
                    Icon(Icons.arrow_back, color: Colors.white,),
                    Alignment.centerLeft,
                    EdgeInsets.all(0),
                    _popScreen,
                  ),
                  containerTitle("$title Details", double.infinity, Colors.white, FontWeight.normal),
                ],
              )
            ),
            Container( /* Activity Information */ 
              margin: EdgeInsets.only(top: 30.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2.0,
                    offset: Offset(1.0, 1.0)
                  )
                ],
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
                color: getHexaColor(AppConfig.darkBlue50),
              ),
              child: Column(
                children: <Widget>[
                  // rowInformation("Receipt no: ", _trxInfo['receipt_no']),
                  _trxInfo['type'] == 'create_account' 
                  ? rowInformation("Amount: ", _trxInfo['starting_balance'])
                  : rowInformation("Amount: ", _trxInfo['amount'] ?? "0.00"),
                  // rowInformation("Location: ", _trxInfo['location']),
                  _trxInfo['type'] == "create_account" 
                  ? rowInformation("Type:", _trxInfo['type']) /* If Trx Type As Create Account */
                  : rowInformation("Type: ", _trxInfo['type'] == "payment" ? "Payment" : "Fee"),
                  rowInformation("From: ", _trxInfo['type'] == "payment" ? _trxInfo['from'] : ""),
                  rowInformation("To: ", _trxInfo['type'] == "payment" ? _trxInfo['to'] : ""),
                  rowInformation("Date: ", AppUtils.timeStampToDateTime(_trxInfo['created_at'])),
                  // Divider(height: 1, color: Colors.white.withOpacity(0.1), thickness: 1.0,),
                ],
              ),
            )
          ],
        ),
      )
    ),
  );
} 