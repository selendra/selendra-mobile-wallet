import 'package:wallet_apps/index.dart';

Widget getWalletBody(
  BuildContext context,
  GlobalKey<ScaffoldState> _globalKey,
  GlobalKey _keyQrShare,
  String _wallet,
  GetWalletFunction _function
){
  return Column(
    children: <Widget>[
      containerAppBar( /* AppBar */
        context, 
        Row(
          children: <Widget>[
            iconAppBar( /* Arrow Back Button */
              Icon(Icons.arrow_back, color: Colors.white,),
              Alignment.centerLeft,
              EdgeInsets.all(0),
              (){
                _function.popScreen(context);
              },
              context: context
            ),
            containerTitle("Receive Token", double.infinity, Colors.white, FontWeight.w400)
          ],
        )
      ),
      _wallet == null 
      ? Expanded(child: Center(child: Text("No Wallet", style: TextStyle(fontSize: 20.0),)),) 
      : Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(width: 1, color: Colors.white.withOpacity(0.2)),
              color: getHexaColor(AppConfig.darkBlue50),
            ),
            margin: EdgeInsets.only(top: 40.0, bottom: 40.0), 
            child: Container( /* Generate QR Code */
              width: double.infinity,
              padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  qrCodeGenerator(_wallet, AppConfig.logoQrEmbedded, _keyQrShare),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text('$_wallet',textAlign: TextAlign.center,)
                  )
                ],
              ),
            )
          ),
          FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.share, color: Colors.white,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("SHARE MY CODE", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            onPressed: (){
              _function.qrShare(_keyQrShare, _wallet);
            },
          ),
          FlatButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.content_copy, color: Colors.white,),
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text("COPY ADDRESS", style: TextStyle(color: Colors.white),),
                )
              ],
            ),
            onPressed: (){
              Clipboard.setData(ClipboardData(text: _wallet)); /* Copy Text */
              _function.snackBar('Copied', _globalKey);
            },
          )
        ],
      )
    ],
  );
}