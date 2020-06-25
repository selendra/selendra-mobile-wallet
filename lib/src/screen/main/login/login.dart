import 'package:wallet_apps/index.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  
  ModelLogin _modelLogin = ModelLogin();

  @override
  void initState() {
    AppServices.noInternetConnection(_modelLogin.globalKey);
    super.initState();
  }

  void onChanged(String label, String valueChanged) {
    _modelLogin.formState2.currentState.validate(); /* Trigger Global Key To Call Function Validate */
  }

  String validateInput(String value) { /* Initial Validate */
    if (_modelLogin.label == "email") {
      if (_modelLogin.nodeEmails.hasFocus) {
        /* If Email Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validateEmails(value);
        if (_modelLogin.responseEmailPhone == null && _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable2 == true)
          setState(() => _modelLogin.enable2 = false);
      }
    } else {
      if (_modelLogin.nodePhoneNums.hasFocus) {
        /* If Phone Number Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validatePhone(value);
        if (_modelLogin.responseEmailPhone == null && _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable2 == true)
          setState(() => _modelLogin.enable2 = false);
      }
    }
    return _modelLogin.responseEmailPhone;
  }

  String validatePassword(String value) { /* Validate User Password Input */
    if (_modelLogin.nodePasswords.hasFocus) {
      _modelLogin.responsePassword = instanceValidate.validatePassword(value);
      if (
        _modelLogin.responseEmailPhone == null &&
        _modelLogin.responsePassword == null
      ) enableButton();
      else if (_modelLogin.enable2 == true) setState(() => _modelLogin.enable2 = false);
    }
    return _modelLogin.responsePassword;
  }

  void enableButton() { /* Validate Button */
    if (_modelLogin.label == 'email') {
      if (_modelLogin.controlEmails.text != '' &&
          _modelLogin.controlPasswords.text != '')
        setState(() => _modelLogin.enable2 = true);
    } else {
      if (_modelLogin.controlPhoneNums.text != '' &&
          _modelLogin.controlPasswords.text != '')
        setState(() => _modelLogin.enable2 = true);
    }
  }

  void showPassword(bool securePassword){
    setState(() {
      _modelLogin.securePassword = securePassword;
    });
  }

  void tabBarSelectChanged(int index) { /* Tab Bar Select Change Label */
    if (index == 1) { /* Tab On Email */
      _modelLogin.controlPhoneNums.clear(); /* Make Emtpy Field */
      _modelLogin.nodePhoneNums.unfocus();

      _modelLogin.controlPasswords.clear();
      _modelLogin.nodePasswords.unfocus();

      setState(() {
        _modelLogin.enable1 = false;
      });
      _modelLogin.label = "email";
    } else {
      _modelLogin.controlEmails.clear();
      _modelLogin.nodeEmails.unfocus();

      _modelLogin.controlPasswords.clear(); // Make Emtpy Field
      _modelLogin.nodePasswords.unfocus();

      setState(() {
        _modelLogin.enable1 = false;
      });
      _modelLogin.label = "phone";
    }
    setState(() {});
  }

  void submitLogin(BuildContext context) async { /* Check Internet Before Validate And Finish Validate*/
    if (_modelLogin.nodeEmails.hasFocus || _modelLogin.nodePhoneNums.hasFocus) {
      FocusScope.of(context).requestFocus(_modelLogin.nodePasswords);
    } else if (_modelLogin.enable2 == true) {
      /* Prevent Submit On Smart Keyboard */ /* Submit Login */
      dialogLoading(context);
      var response;
      try {
        if (_modelLogin.label == "email") {
          response = await _modelLogin.bloc.loginMethod(
            context,
            _modelLogin.controlEmails.text,
            _modelLogin.controlPasswords.text,
            "/loginbyemail",
            "email"
          );
        } else {
          response = await _modelLogin.bloc.loginMethod(
            context,
            "${_modelLogin.countryCode}${AppServices.removeZero(_modelLogin.controlPhoneNums.text)}",
            _modelLogin.controlPasswords.text,
            "/loginbyphone",
            "phone"
          );
        }
      } on SocketException catch (e) {
        await Future.delayed(Duration(milliseconds: 300), () {
          setState(() {});
        });
        Navigator.pop(context);
        AppServices.mySnackBar(_modelLogin.globalKey, AppText.contentConnection);
      } catch (e) {}

      if (response == true) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
          ModalRoute.withName('/')
        );
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _modelLogin.globalKey,
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: paddingScreenWidget( /* Body Widget */
          context,
          SafeArea(
            child: Stack(
              children: <Widget>[
                loginBody(
                  context,
                  _modelLogin,
                  validateInput,
                  validatePassword,
                  onChanged,
                  tabBarSelectChanged,
                  showPassword,
                  submitLogin
                ),
              ],
            ),
          )
        ),
      )
    );
  }
}
