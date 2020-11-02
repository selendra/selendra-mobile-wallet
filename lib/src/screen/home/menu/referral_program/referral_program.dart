import 'package:wallet_apps/index.dart';

class ReferralProgram extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReferralProgramState();
  }
}

class ReferralProgramState extends State<ReferralProgram> with WidgetsBindingObserver {

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: ReferralProgramBody(
          // modelReferralProgram: _modelReferralProgram,
          // validateInput: validateInput,
          // validatePassword:validatePassword,
          // tabBarSelectChanged: tabBarSelectChanged,
          // showPassword: showPassword,
          // submitReferralProgram: submitReferralProgram,
          // onChanged: onChanged,
          // onSubmit: onSubmit,
        )
      )
    );
  }
}
