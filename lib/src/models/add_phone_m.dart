import 'package:wallet_apps/index.dart';

class AddPhoneModel{

  bool enable = false;

  String countryCode = "+855";

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();

  String validateResponse;

  TextEditingController phone = TextEditingController();

  FocusNode nodePhone = FocusNode();
}