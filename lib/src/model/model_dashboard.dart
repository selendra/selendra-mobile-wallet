import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallet_apps/index.dart';

class ModelDashboard {

  bool isProgress = false, isQueried = false, loadingHome = true;

  bool visible = false;

  AnimationController animationController;

  Animation degOneTranslationAnimation;

  Map<String, dynamic> userData;
  String barcode;
  List<dynamic> portfolioList = [];
  GlobalKey<ScaffoldState> scaffoldKey;
  dynamic result; dynamic portFolioResponse; dynamic response;

  final GlobalKey<AnimatedCircularChartState> chartKey =  new GlobalKey<AnimatedCircularChartState>();
  double remainDataChart = 100;
  List<CircularSegmentEntry> circularChart;

  final RefreshController refreshController = RefreshController();
}
