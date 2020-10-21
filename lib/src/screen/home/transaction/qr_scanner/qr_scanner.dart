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
      body: BodyScaffold(
        child: Column(
          children: [
            MyAppBar(
              title: "Transaction",
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
        ),
      )
    );
  }
}