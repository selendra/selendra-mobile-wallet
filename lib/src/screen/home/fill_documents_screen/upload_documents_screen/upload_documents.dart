import './upload_documents_body.dart';
import 'package:wallet_apps/index.dart';

class UploadDocuments extends StatefulWidget {

  final ModelDocument _modelDocuments;

  UploadDocuments(this._modelDocuments);

  @override
  State<StatefulWidget> createState() {
    return UploadDocumentsState();
  }
}

class UploadDocumentsState extends State<UploadDocuments> {

  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  @override
  initState(){
    AppServices.noInternetConnection(_globalKey);
    super.initState();
  }

  Bloc _bloc = Bloc();

  void popScreen() {

  }

  void navigatePage() {

  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: scaffoldBGDecoration(
        child: documentsBodyWidget(context, _bloc, widget._modelDocuments, popScreen, navigatePage)
      ) 
    );
  }
}