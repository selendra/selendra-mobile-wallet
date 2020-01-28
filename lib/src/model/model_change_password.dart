import 'package:flutter/widgets.dart';

class ModelChangePassword{
  final formStateChangePassword = GlobalKey<FormState>();

  TextEditingController controlOldPassword = TextEditingController();
  TextEditingController controlNewPassword = TextEditingController();
  TextEditingController controlConfirmPassword = TextEditingController();

  FocusNode nodeOldPassword = FocusNode();
  FocusNode nodeNewPassword = FocusNode();
  FocusNode nodeConfirmPassword = FocusNode();
}