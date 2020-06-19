import 'package:wallet_apps/index.dart';

class TakeSelfie extends StatefulWidget {

  final ModelDocument _modelDocuments;

  TakeSelfie(this._modelDocuments);

  @override
  State<StatefulWidget> createState() {
    return TakeSelfieState();
  }
}

class TakeSelfieState extends State<TakeSelfie> {

  Bloc _bloc = Bloc();

  void popScreen () {

  }

  void navigatePage() {
    
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: selfieBodyWidget(context, _bloc, widget._modelDocuments, popScreen, navigatePage),
    );
  }
}