import 'package:flutter/material.dart';
import 'package:wallet_apps/src/bloc/bloc.dart';
import 'package:wallet_apps/src/model/model_document.dart';
import './upload_documents_body.dart';

class UploadDocuments extends StatefulWidget {

  final ModelDocument _modelDocuments;

  UploadDocuments(this._modelDocuments);

  @override
  State<StatefulWidget> createState() {
    return UploadDocumentsState();
  }
}

class UploadDocumentsState extends State<UploadDocuments> {

  Bloc _bloc = Bloc();

  void popScreen() {

  }

  void navigatePage() {

  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: documentsBodyWidget(context, _bloc, widget._modelDocuments, popScreen, navigatePage) 
    );
  }
}