import 'package:wallet_apps/index.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> with WidgetsBindingObserver {

  GlobalKey<ScaffoldState> globalKey = GlobalKey<ScaffoldState>();
  
  ModelLogin _modelLogin = ModelLogin();

  PostRequest _postRequest = PostRequest();

  Backend _backend = Backend();

  List<MyInputField> listInput = [];

  @override
  void initState() {
    // AppServices.noInternetConnection(globalKey);
    _modelLogin.label = 'phone';

    // Initialize Text Input
    listInput.addAll({
      MyInputField(
        labelText: "Phone",
        prefixText: "+855 ",
        textInputFormatter: [
          LengthLimitingTextInputFormatter(9),
          WhitelistingTextInputFormatter.digitsOnly
        ],
        // modelLogin.label == "email"
        //   ?  /* If Label Equal Email Just Control Length Input Format */
        //   : , /* Else Add Condition 0-9 Only */
        inputType: TextInputType.phone,
        controller: _modelLogin.controlPhoneNums,
        focusNode: _modelLogin.nodePhoneNums,
        validateField: validateInput,
        onChanged: onChanged,
        action: submitLogin
      ),
      MyInputField(
        labelText: "Email",
        prefixText: null,
        textInputFormatter: [
          LengthLimitingTextInputFormatter(TextField.noMaxLength)
        ],
        // modelLogin.label == "email"
        //   ?  /* If Label Equal Email Just Control Length Input Format */
        //   : , /* Else Add Condition 0-9 Only */
        inputType: TextInputType.emailAddress,
        controller: _modelLogin.controlPhoneNums,
        focusNode: _modelLogin.nodePhoneNums,
        validateField: validateInput,
        onChanged: onChanged,
        action: submitLogin
      )
    });
    
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){

  }

  void onChanged(String valueChanged) {
    _modelLogin.formState.currentState.validate(); /* Trigger Global Key To Call Function Validate */
  }

  String validateInput(String value) { /* Initial Validate */
    if (_modelLogin.label == "email") {
      if (_modelLogin.nodeEmails.hasFocus) {
        /* If Email Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validateEmails(value);
        if (_modelLogin.responseEmailPhone == null && _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable == true)
          setState(() => _modelLogin.enable = false);
      }
    } else {
      if (_modelLogin.nodePhoneNums.hasFocus) {
        /* If Phone Number Field Has Focus */
        _modelLogin.responseEmailPhone = instanceValidate.validatePhone(value);
        if (_modelLogin.responseEmailPhone == null && _modelLogin.responsePassword == null)
          enableButton();
        else if (_modelLogin.enable == true)
          setState(() => _modelLogin.enable = false);
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
      else if (_modelLogin.enable == true) setState(() => _modelLogin.enable = false);
    }
    return _modelLogin.responsePassword;
  }

  void enableButton() { /* Validate Button */
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

  void focusRequest(){
    if (_modelLogin.nodeEmails.hasFocus || _modelLogin.nodePhoneNums.hasFocus) {
      FocusScope.of(context).requestFocus(_modelLogin.nodePasswords);
    } else if (_modelLogin.enable) {
      submitLogin(context);
    }
  }

  /* -----------------------Login Method-------------------- */

  // Check Internet Before Validate And Finish Validate
  void submitLogin(BuildContext context) async { 

    // Display Dialog Loading
    dialogLoading(context);

    // Connection timed out
    AppServices.timerOutHandler(_backend.response, timeCounter);

    try {
      if (_modelLogin.label == "email") {
        await loginByEmail();
      } else {
        await loginByPhone();
      }
    } on SocketException catch (e) {
      await Future.delayed(Duration(milliseconds: 300), () {
        setState(() {});
      });
      Navigator.pop(context);
      AppServices.mySnackBar(globalKey, AppText.contentConnection);
    } catch (e) {}
  }

  void timeCounter(Timer timer) async {
    // Assign Timer Number Counter To myNumCount Variable
    AppServices.myNumCount = timer.tick;
    // Cancel Timer When Rest Api Successfully
    if (_backend.response != null) timer.cancel();
    // Display TimeOut With SnackBar When Over 10 Second
    if (AppServices.myNumCount == 10) {
      Navigator.pop(context);
      globalKey.currentState.showSnackBar(SnackBar(content: Text('Connection timed out'),));
    }
  }

  Future<void> loginByPhone() async {
    
    // Rest Api
    await _postRequest.loginByPhone(_modelLogin.controlPhoneNums.text, _modelLogin.controlPasswords.text).then((value) async {
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
    await _postRequest.loginByEmail(_modelLogin.controlEmails.text, _modelLogin.controlPasswords.text).then((value) async {
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

    if (_backend.response.statusCode != 502) {
      if (_backend.mapData.containsKey("error")) {
        await dialog( context, textAlignCenter(text: _backend.mapData['error']["message"]), textMessage());
      } else { 
        // If Successfully
        if (_backend.mapData.containsKey("token")) {
          _backend.mapData.addAll({
            "isLoggedIn": true
          });
          await StorageServices.setData(_backend.mapData, 'user_token');
          
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
            ModalRoute.withName('/')
          );
        }
        // If Incorrect Email 
        else { 
          await dialog( context, textAlignCenter(text: _backend.mapData["message"]), textMessage());
        }
      }
    } else {
      await dialog(context, textAlignCenter(text: "Something gone wrong !"), textMessage());
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: LoginBody(
            listInput: listInput,
            modelLogin: _modelLogin,
            validateInput: validateInput,
            validatePassword:validatePassword,
            tabBarSelectChanged: tabBarSelectChanged,
            showPassword: showPassword,
            submitLogin: submitLogin,
            onChanged: onChanged,
          ),
        )
      ),
    );
  }
}
