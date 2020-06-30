import 'package:wallet_apps/index.dart';

class CustomAnimation{

  static Widget flareAnimation(FlareControls flareControls, String path, String animation){
    return FlareActor(
      path,
      alignment: Alignment.center,
      fit: BoxFit.cover,
      animation: animation,
      controller: flareControls,
    );
  }
}