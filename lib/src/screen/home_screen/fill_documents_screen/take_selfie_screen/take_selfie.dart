import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_document.dart';
import 'package:wallet_apps/src/screen/home_screen/fill_documents_screen/take_selfie_screen/take_selfie_body.dart';

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