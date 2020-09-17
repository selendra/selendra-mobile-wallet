import 'package:wallet_apps/index.dart';

class GetWalletBody extends StatelessWidget{

  final GlobalKey keyQrShare;
  final GlobalKey<ScaffoldState> globalKey;
  final String wallet;
  final GetWalletMethod method;

  GetWalletBody({
    this.keyQrShare,
    this.globalKey,
    this.wallet,
    this.method
  });
  
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        MyAppBar(
          title: "Receive token",
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        wallet == null 
        ? Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/not_found.svg', width: 285, height: 278),
              MyText(
                top: 10,
                text: "No wallet"
              )
            ],
          )
        )
        : Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: hexaCodeToColor(AppColors.cardColor),
                ),
                margin: EdgeInsets.only(bottom: 45.0, left: 16.0, right: 16.0), 
                child: Container( /* Generate QR Code */
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      qrCodeGenerator(wallet, AppConfig.logoQrEmbedded, keyQrShare),
                      MyText(
                        top: 27,
                        width: 327,
                        text: '$wallet',
                        color: AppColors.secondary_text,
                      )
                    ],
                  ),
                )
              ),

              Container(
                margin: EdgeInsets.only(bottom: 21),
                child: FlatButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.share, color: Colors.white, size: 30),
                      Container(
                        padding: EdgeInsets.only(left: 10.0),
                        child: MyText(
                          text: "SHARE MY CODE",
                          color: "#FFFFFF"
                        ),
                      )
                    ],
                  ),
                  onPressed: (){
                    method.qrShare(keyQrShare, wallet);
                  },
                )
              ),
              FlatButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.content_copy, color: Colors.white, size: 30),
                    Container(
                      padding: EdgeInsets.only(left: 10.0),
                      child: MyText(
                        text: "COPY ADDRESS",
                          color: "#FFFFFF"
                      )
                    )
                  ],
                ),
                onPressed: (){
                  Clipboard.setData(ClipboardData(text: wallet)); /* Copy Text */
                  method.snackBar('Copied', globalKey);
                },
              )
            ],
          ),
        )
      ],
    );
  }
}



Widget getWalletBody(
  BuildContext context,
  GlobalKey<ScaffoldState> globalKey,
  GlobalKey keyQrShare,
  String wallet,
  GetWalletMethod method
){
  ;
}