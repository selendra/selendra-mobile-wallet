import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:wallet_apps/index.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget {
  final List portList;
  final WalletSDK sdk;
  final Keyring keyring;

  QrScanner({this.portList, this.sdk, this.keyring});

  @override
  State<StatefulWidget> createState() {
    return QrScannerState();
  }
}

class QrScannerState extends State<QrScanner> {
  final GlobalKey qrKey = GlobalKey();

  Backend _backend = Backend();

  void _onQrViewCreated(QRViewController controller) {
    controller.scannedDataStream.listen((scanData) async {
      controller.pauseCamera();
      await Future.delayed(Duration(seconds: 2), () async {
        _backend.mapData = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubmitTrx(scanData.code, false,
                    widget.portList, widget.sdk, widget.keyring)));

        Navigator.pop(context, _backend.mapData);
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: BodyScaffold(
      height: MediaQuery.of(context).size.height,
      bottom: 0,
      child: Column(
        children: [
          MyAppBar(
            title: "Transaction",
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
              flex: 5,
              child: QRView(
                key: qrKey,
                onQRViewCreated: _onQrViewCreated,
                overlay: QrScannerOverlayShape(
                    borderColor: Colors.red, borderRadius: 10, borderWidth: 10),
              )),
        ],
      ),
    ));
  }
}
