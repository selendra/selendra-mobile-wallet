import 'package:wallet_apps/index.dart';

class FirebaseRemote {
  String iosAppId;
  String androidAppId;
  String content;
  String latestVersion;
  int parseVersion;
  // RemoteConfig _remoteConfig;

  // Future initRemoteConfig() async {
  //   _remoteConfig = await RemoteConfig.instance;
  //   await _remoteConfig.fetch(expiration: Duration(milliseconds: 0));
  //   await _remoteConfig.activateFetched();
  //   iosAppId = _remoteConfig.getString('ios_app_id');
  //   androidAppId = _remoteConfig.getString('android_app_id');
  //   content = _remoteConfig.getString('content');
  //   latestVersion = _remoteConfig.getString('latest_version');
  // }
}
