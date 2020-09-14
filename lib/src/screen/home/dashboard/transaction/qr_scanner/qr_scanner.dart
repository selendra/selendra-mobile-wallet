import 'package:wallet_apps/index.dart';

class QrScanner extends StatefulWidget{

  final List portList;

  QrScanner({this.portList});

  @override
  State<StatefulWidget> createState() {
    return QrScannerState();
  }
}

class QrScannerState extends State<QrScanner>{
  
  final GlobalKey qrKey = GlobalKey();

  void _onQrViewCreated(QRViewController controller){
    controller.scannedDataStream.listen((scanData) async {
      print("Listening $scanData");
    //   qrData = scanData;
      controller.pauseCamera();
      await Future.delayed(Duration(seconds: 2), (){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubmitTrx(scanData, false, widget.portList)));
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: scaffoldBGDecoration(
        left: 0, right: 0,
        bottom: 0,
        child: Column(
          children: [
            containerAppBar( /* AppBar */
              context,
              Row( /* Sub AppBar */
                children: <Widget>[
                  iconAppBar( /* Menu Button */
                    Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                    Alignment.centerLeft,
                    EdgeInsets.all(0),
                    // Trigger To Open Drawer
                    (){ 
                      Navigator.pop(context);
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text("Transaction", style: TextStyle(fontSize: 18.0),)
                        )
                        // Image.asset(
                        //   AppConfig.logoAppBar,
                        //   height: 25.0,
                        //   color: Colors.white,
                        // ),
                      ],
                    ),
                  ),
                ],
              )
            ),
            Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQrViewCreated,
                overlay: QrScannerOverlayShape(
                  borderColor: Colors.red,
                  borderRadius: 10,
                  borderWidth: 10
                ),
              )
            ),
          ],
        )
      )
    );
  }
}