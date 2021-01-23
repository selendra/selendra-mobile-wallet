import 'package:wallet_apps/index.dart';
import 'package:wallet_apps/src/screen/main/contents_backup.dart';
import 'package:wallet_apps/src/screen/main/import_account/import_acc.dart';

class WelcomeBody extends StatelessWidget {
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height / 5,
          left: MediaQuery.of(context).size.width / 2 - 75,
          child:
              SvgPicture.asset('assets/sld_logo.svg', width: 150, height: 150),
        ),
        Positioned(
          bottom: 30,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              MyFlatButton(
                // width: 100,
                edgeMargin: EdgeInsets.only(left: 66, right: 66, bottom: 16),
                textButton: 'Create Account',
                action: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ContentsBackup()));
                },
              ),
              MyFlatButton(
                edgeMargin: EdgeInsets.only(left: 66, right: 66, bottom: 16),
                textButton: 'Import Account',
                action: () {
                  Navigator.pushNamed(context, Home.route);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ImportAcc())
                  // );
                },
              )
            ],
          ),
        ),
      ],
    );
  }
}
