import 'package:wallet_apps/index.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with WidgetsBindingObserver {
  GlobalKey<ScaffoldState> globalKey;

  ModelLogin _modelLogin = ModelLogin();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  @override
  void initState() {
    globalKey = GlobalKey<ScaffoldState>();
    AppServices.noInternetConnection(globalKey);
    _modelLogin.label = 'phone';

    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  void onChanged(String valueChanged) {
    _modelLogin.formState.currentState
        .validate(); /* Trigger Global Key To Call Function Validate */
  }

  String validateInput(String value) {
    /* Initial Validate */
    if (_modelLogin.label == "email") {
      if (_modelLogin.nodeEmails.hasFocus) {
        /* If Email Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validateEmails(value);
        if (_modelLogin.responseEmailPhone == null &&
            _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable == true)
          setState(() => _modelLogin.enable = false);
      }
    } else {
      if (_modelLogin.nodePhoneNums.hasFocus) {
        /* If Phone Number Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validatePhone(value);
        if (_modelLogin.responseEmailPhone == null &&
            _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable == true)
          setState(() => _modelLogin.enable = false);
      }
    }
    return _modelLogin.responseEmailPhone;
  }

  String validatePassword(String value) {
    /* Validate User Password Input */
    if (_modelLogin.nodePasswords.hasFocus) {
      _modelLogin.responsePassword = instanceValidate.validatePassword(value);
      if (_modelLogin.responseEmailPhone == null &&
          _modelLogin.responsePassword == null)
        enableButton();
      else if (_modelLogin.enable == true)
        setState(() => _modelLogin.enable = false);
    }
    return _modelLogin.responsePassword;
  }

  void enableButton() {
    /* Validate Button */
    if (_modelLogin.label == 'email') {
      if (_modelLogin.controlEmails.text != '' &&
          _modelLogin.controlPasswords.text != '')
        setState(() => _modelLogin.enable = true);
    } else {
      if (_modelLogin.controlPhoneNums.text != '' &&
          _modelLogin.controlPasswords.text != '')
        setState(() => _modelLogin.enable = true);
    }
  }

  void showPassword() {
    setState(() {
      if (_modelLogin.hidePassword == false)
        _modelLogin.hidePassword = true;
      else
        _modelLogin.hidePassword = false;
    });
  }

  void tabBarSelectChanged(int index) {
    /* Tab Bar Select Change Label */
    if (index == 1) {
      /* Tab On Email */
      _modelLogin.controlPhoneNums.clear(); /* Make Emtpy Field */
      _modelLogin.nodePhoneNums.unfocus();

      _modelLogin.controlPasswords.clear();
      _modelLogin.nodePasswords.unfocus();

      setState(() {
        _modelLogin.enable = false;
      });
      _modelLogin.label = "email";
    } else {
      _modelLogin.controlEmails.clear();
      _modelLogin.nodeEmails.unfocus();

      _modelLogin.controlPasswords.clear(); // Make Emtpy Field
      _modelLogin.nodePasswords.unfocus();

      setState(() {
        _modelLogin.enable = false;
      });
      _modelLogin.label = "phone";
    }
    setState(() {});
  }

  void onSubmit() {
    if (_modelLogin.nodeEmails.hasFocus || _modelLogin.nodePhoneNums.hasFocus) {
      FocusScope.of(context).requestFocus(_modelLogin.nodePasswords);
    } else if (_modelLogin.enable) {
      submitLogin();
    }
  }

  /* -----------------------Login Method-------------------- */

  // Check Internet Before Validate And Finish Validate
  void submitLogin() async {
    // Display Dialog Loading
    dialogLoading(context);

    _modelLogin.nodePasswords.unfocus();

    // Connection timed out
    AppServices.timerOutHandler(_backend.response, timeCounter);

    try {
      if (_modelLogin.label == "email") {
        await loginByEmail();
      } else {
        await loginByPhone();
      }
    } on SocketException catch (e) {
      await Future.delayed(Duration(milliseconds: 300), () {});
      AppServices.openSnackBar(globalKey, e.message);
    } catch (e) {
      await dialog(context, Text("${e.message}", textAlign: TextAlign.center),
          "Message");
    }
  }

  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;
    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();
    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      Navigator.pop(context);
      // globalKey.currentState.showSnackBar();
      snackBar(globalKey, "Connection timed out");
    }
  }

  Future<void> loginByPhone() async {
    // Rest Api
    await _postRequest
        .loginByPhone(_modelLogin.controlPhoneNums.text,
            _modelLogin.controlPasswords.text)
        .then((value) async {
      // Do Below Statement When Rest Api Successfully Under 10 seconds
      if (AppServices.myNumCount < 10) {
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
        }
        await navigator();
      }
    });
  }

  Future<void> loginByEmail() async {
    // Rest Api
    await _postRequest
        .loginByEmail(
            _modelLogin.controlEmails.text, _modelLogin.controlPasswords.text)
        .then((value) async {
      // Do Below Statement When Rest Api Successfully Under 10 seconds
      if (AppServices.myNumCount < 10) {
        _backend.response = value;
        if (_backend.response != null) {
          // Navigator.pop(context);
          _backend.mapData = json.decode(_backend.response.body);
        }
        await navigator();
      }
    });
  }

  Future<void> navigator() async {
    // Close Loading
    Navigator.pop(context);

    await StorageServices.fetchData('total_rate')
        .then((value) => print("Login total rate $value"));

    if (_backend.response.statusCode != 502) {
      if (_backend.mapData.containsKey("error")) {
        await dialog(
            context,
            textAlignCenter(text: _backend.mapData['error']["message"]),
            textMessage());
      } else {
        // If Successfully
        if (_backend.mapData.containsKey("token")) {
          _backend.mapData.addAll({"isLoggedIn": true});
          await StorageServices.setData(_backend.mapData, 'user_token');

          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(builder: (context) => Home()),
          //   ModalRoute.withName('/')
          // );
        }
        // If Incorrect Email
        else {
          await dialog(
              context,
              textAlignCenter(text: _backend.mapData["message"]),
              textMessage());
        }
      }
    } else {
      await dialog(context, textAlignCenter(text: "Something gone wrong !"),
          textMessage());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      body: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: BodyScaffold(
            height: MediaQuery.of(context).size.height,
            child: LoginBody(
              modelLogin: _modelLogin,
              validateInput: validateInput,
              validatePassword: validatePassword,
              tabBarSelectChanged: tabBarSelectChanged,
              showPassword: showPassword,
              submitLogin: submitLogin,
              onChanged: onChanged,
              onSubmit: onSubmit,
            )),
      ),
    );
  }
}
