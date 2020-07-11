import 'package:wallet_apps/index.dart';

Widget getWalletBody(
  BuildContext context,
  String _wallet, double wallets,
  Function snackBar, Function popScreen
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
              popScreen,
            ),
            containerTitle("Receive Token", double.infinity, Colors.white, FontWeight.w400)
          ],
        )
      ),
      _wallet == null 
      ? Expanded(child: Center(child: Text("No Wallet", style: TextStyle(fontSize: 20.0),)),) 
      : Flexible(
        child: Card(
          elevation: 2,
          margin: EdgeInsets.only(top: 40.0, bottom: 40.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          child: Container( /* Generate QR Code */
            width: double.infinity,
            padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
            child: qrCodeGenerate(_wallet, AppConfig.logoQrEmbedded),
          )
        ),
      ),
      Text("$wallets"),
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
          snackBar('Copied');
        },
      )
      // Container(
      //   color: Colors.red,
      //   padding: EdgeInsets.only(left: 16.0, right: 16.0),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.max,
      //     children: <Widget>[
      //       Card(
      //         elevation: 2,
      //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      //         margin: EdgeInsets.only(bottom: 10.0),
      //         child: Container( /* Generate QR Code */
      //           margin: EdgeInsets.only(bottom: 30.0),
      //           child: qrCodeGenerate(_wallet, AppConfig.logoQrEmbedded),
      //         )
      //       ),
      //       // FlatButton(
      //       //   child: Row(
      //       //     mainAxisAlignment: MainAxisAlignment.center,
      //       //     children: <Widget>[
      //       //       Icon(Icons.share, color: Colors.white,),
      //       //       Container(
      //       //         padding: EdgeInsets.only(left: 10.0),
      //       //         child: Text("SHARE MY CODE", style: TextStyle(color: Colors.white),),
      //       //       )
      //       //     ],
      //       //   ),
      //       //   onPressed: (){
                
      //       //   },
      //       // ),
      //       // FlatButton(
      //       //   child: Row(
      //       //     mainAxisAlignment: MainAxisAlignment.center,
      //       //     children: <Widget>[
      //       //       Icon(Icons.content_copy, color: Colors.white,),
      //       //       Container(
      //       //         padding: EdgeInsets.only(left: 10.0),
      //       //         child: Text("COPY ADDRESS", style: TextStyle(color: Colors.white),),
      //       //       )
      //       //     ],
      //       //   ),
      //       //   onPressed: (){
      //       //     Clipboard.setData(ClipboardData(text: _wallet)); /* Copy Text */
      //       //     snackBar('Copied');
      //       //   },
      //       // )
      //     ],
      //   )
      // )
    ],
  );
}