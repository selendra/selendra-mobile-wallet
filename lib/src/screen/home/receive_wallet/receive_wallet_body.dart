import 'package:wallet_apps/index.dart';

class ReceiveWalletBody extends StatelessWidget{

  final GlobalKey keyQrShare;
  final GlobalKey<ScaffoldState> globalKey;
  final HomeModel homeM;
  final GetWalletMethod method;

  ReceiveWalletBody({
    this.keyQrShare,
    this.globalKey,
    this.homeM,
    this.method
  });
  
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[

        MyAppBar(
          title: "Receive wallet",
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        homeM.userData['wallet'] == null 
        ? Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/no_data.svg', height: 200),

              MyText(
                text: "There are no wallet found"
              )
            ],
          )
        )
        : Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 45.0, left: 16.0, right: 16.0,),
                width: double.infinity,
                child: RepaintBoundary(
                  key: keyQrShare,
                  child: Container(
                    padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: hexaCodeToColor(AppColors.cardColor),
                    ), 
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [

                        qrCodeGenerator(homeM, AppConfig.logoQrEmbedded, keyQrShare),

                        MyText(
                          text: homeM.userData['first_name'] == '' && homeM.userData['mid_name'] == '' && homeM.userData['last_name'] == ''
                          ? 'User name'
                          : "${homeM.userData['first_name']} ${homeM.userData['mid_name']} ${homeM.userData['last_name']}",
                          bottom: 16,
                          top: 16,
                          color: "#FFFFFF",
                        ),

                        MyText(
                          width: 300,
                          text: "${homeM.userData['wallet']}",
                          color: AppColors.secondary_text,
                          fontSize: 16,
                          bottom: 16,
                        ),

                        MyText(
                          text: "Scan the qr code to perform transaction",
                          fontSize: 16,
                        ),
                      ],
                    )
                  ),
                ),
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
                    method.qrShare(keyQrShare, homeM.userData['wallet']);
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
                  Clipboard.setData(ClipboardData(text: homeM.userData['wallet'])); /* Copy Text */
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