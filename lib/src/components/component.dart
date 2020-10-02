import 'package:wallet_apps/index.dart';

class Component {
  
  static void popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static Future messagePermission({BuildContext context, String content, Function method}) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          title: Align(
            alignment: Alignment.center,
            child: Text("Message"),
          ),
          content: Padding(
            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
            child: Text("$content", textAlign: TextAlign.center),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Setting'),
              onPressed: method,
            ),
          ],
        );
      }
    );
  }
  
}

class MyFlatButton extends StatelessWidget{

  final String textButton;
  final String buttonColor;
  final FontWeight fontWeight;
  final double fontSize;
  final EdgeInsetsGeometry edgeMargin;
  final EdgeInsetsGeometry edgePadding;
  final bool hasShadow;
  final Function action;

  MyFlatButton({
    this.textButton, 
    this.buttonColor = AppColors.secondary, 
    this.fontWeight =  FontWeight.bold, 
    this.fontSize = 18, 
    this.edgeMargin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.edgePadding = const EdgeInsets.fromLTRB(0, 0, 0, 0), 
    this.hasShadow = false, 
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgePadding,
      margin: edgeMargin,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size5), 
        boxShadow: [
          if (hasShadow) BoxShadow(
            color: Colors.black54.withOpacity(0.3),
            blurRadius: 10.0,
            spreadRadius: 2.0,
            offset: Offset(2.0, 5.0),
          )
        ]
      ),
      child: FlatButton(
        color: hexaCodeToColor(buttonColor),
        disabledColor: Colors.grey[700],
        focusColor: hexaCodeToColor(AppColors.secondary),
        child: MyText(
          // left: 117, right: 116,
          top: 20, bottom: 20,
          text: textButton,
          color: action != null ? '#FFFFFF' : AppColors.textBtnColor,
          fontWeight: fontWeight,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed:action == null ? null : 
        (){
          action(context);
        }
      ),
    );
  }
}

class MyText extends StatelessWidget{

  final String text; final String color; final double fontSize; final FontWeight fontWeight;
  final double top; final double right; final double bottom; final double left;
  final double width; final double height; final TextAlign textAlign;

  MyText({
    this.text, this.color = AppColors.textColor, this.fontSize = 18, this.fontWeight = FontWeight.normal,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0,
    this.width, this.height, this.textAlign = TextAlign.center
  });
  
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: SizedBox(
        width: this.width,
        height: this.height,
        child: Text(
            this.text,
            style: TextStyle(
              fontWeight: this.fontWeight,
              color: Color(AppUtils.convertHexaColor(this.color)),
              fontSize: this.fontSize
            ),
            textAlign: this.textAlign
          )
      ),
    );
  }
}

class MyLogo extends StatelessWidget{

  final String logoPath; final String color; final double width; final double height;

  final double top; final double right; final double bottom; final double left;

  MyLogo({
    @required this.logoPath, 
    this.color = "#FFFFFF", 
    this.width = 60, 
    this.height = 60,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0
  });

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      child: SvgPicture.asset(logoPath, width: width, height: height, color: hexaCodeToColor(this.color))
    );
  }
}

class MyCircularImage extends StatelessWidget{
  
  final String boxColor;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final String imagePath;
  final double width;
  final double height;
  final bool enableShadow;
  final BoxDecoration decoration;
  final Color colorImage;

  MyCircularImage({
    this.boxColor = AppColors.secondary,
    this.margin = const EdgeInsets.fromLTRB(0, 16.0, 0, 0),
    this.padding = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.imagePath,
    this.width,
    this.height,
    this.enableShadow,
    this.decoration,
    this.colorImage
  });

  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      padding: padding,
      decoration: decoration,
      child: SvgPicture.asset(imagePath, color: colorImage,)
    );
  }
}

class MyAppBar extends StatelessWidget{

  final double  pLeft; final double pTop; final double pRight; final double pBottom;
  final EdgeInsetsGeometry margin;
  final String title;
  final Function onPressed;

  MyAppBar({
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
    this.margin = const EdgeInsets.fromLTRB(0, 15, 0, 0),
    @required this.title,
    this.onPressed
  });
  
  Widget build(BuildContext context) {
    return Container(
      height: 65.0, 
      width: MediaQuery.of(context).size.width, 
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            /* Menu Icon */
            alignment: Alignment.center,
            // padding: edgePadding,
            padding: EdgeInsets.only(left: 30),
            iconSize: 40.0,
            icon: Icon(LineAwesomeIcons.arrow_left, color: Colors.white, size: 30),
            onPressed: onPressed,
          ),
          MyText(
            color: "#FFFFFF",
            text: title,
            left: 15,
            fontSize: 22,
          )
        ],
      )
    );
  }
}

class BodyScaffold extends StatelessWidget{

  final double left, top, right, bottom;
  final Widget child;
  final double width;
  final double height;

  BodyScaffold({
    this.left = 0, this.top = 0, this.right = 0, this.bottom = 0,
    this.child,
    this.height,
    this.width,
  });
  
  Widget build(BuildContext context){
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // Minus 20 Pixel For Make Safe Area Bottom
          height: MediaQuery.of(context).size.height - 20,
          color: Color(AppUtils.convertHexaColor(AppColors.bgdColor)),
          padding: EdgeInsets.fromLTRB(left, top, right, bottom),
          child: this.child
        ),
      )
    );
  }
}

class MyIconButton extends StatelessWidget{

  final IconData icon;
  final double iconSize;
  final Function onPressed;
  final EdgeInsetsGeometry padding;

  MyIconButton({
    this.icon,
    this.iconSize = 30,
    this.padding = const EdgeInsets.all(0),
    this.onPressed
  });

  Widget build(BuildContext context) {
    return IconButton(
      padding: padding,
      icon: Icon(
        this.icon,
        size: iconSize,
        color: Colors.white
      ),
      onPressed: onPressed,
    );
  }
}

class MyCircularChart extends StatelessWidget{

  final String amount;
  final GlobalKey<AnimatedCircularChartState> chartKey;
  final EdgeInsetsGeometry margin;
  final List<CircularSegmentEntry> listChart;
  final Alignment alignment;
  final double width;
  final double height;

  MyCircularChart({
    this.amount,
    this.chartKey,
    this.margin = const EdgeInsets.only(bottom: 24.0),
    this.alignment,
    this.width = 300.0,
    this.height = 250.0,
    this.listChart
  });

  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: alignment,
      child: AnimatedCircularChart(
        holeRadius: 70.0,
        key: chartKey,
        duration: Duration(seconds: 1),
        // startAngle: 125.0,
        size: Size(width, height),
        percentageValues: true,
        holeLabel: amount,
        labelStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        edgeStyle: SegmentEdgeStyle.flat,
        initialChartData: <CircularStackEntry>[
          CircularStackEntry(
            listChart,
            rankKey: 'progress',
          ),
        ],
        chartType: CircularChartType.Radial,
      )
    );
  }
}

class MyColumnBuilder extends StatelessWidget{

  final List<dynamic> data;
  final EdgeInsetsGeometry margin;

  MyColumnBuilder({@required this.data, this.margin});
  
  Widget build(BuildContext context){
    return Container(
      margin: margin,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return portFolioItemRow(data, index);
        },
      )
    );
  }
}

class MyRowHeader extends StatelessWidget{

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 1.5),
              alignment: Alignment.centerLeft,
              child: MyText(
                text: "Your assets"
              )
            ),
          ),
          Expanded(
            child: Container(
              child: Align(
                alignment: Alignment.centerRight,
                child: MyText(
                  text: "QTY"
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyTabBar extends StatelessWidget{

  final List<Widget> listWidget;
  final Function onTap;

  MyTabBar({
    @required this.listWidget,
    @required this.onTap
  });

  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container( 
        margin: EdgeInsets.only(bottom: 16.0, right: 16.0),
        decoration: BoxDecoration(
          color: hexaCodeToColor(AppColors.cardColor),
          borderRadius: BorderRadius.circular(8)
        ),
        width: 125.0,
        height: 48,
        child: TabBar(
          unselectedLabelColor: hexaCodeToColor(AppColors.textColor),
          indicatorColor: hexaCodeToColor(AppColors.secondary_text),
          labelColor: hexaCodeToColor(AppColors.secondary_text),
          // labelStyle: TextStyle(fontSize: 30.0),
          tabs: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
              width: double.infinity,
              child: Icon(LineAwesomeIcons.phone, size: 23.0,),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              alignment: Alignment.center,
              child: Icon(LineAwesomeIcons.envelope, size: 23.0),
            )
          ],
          onTap: onTap,
        ),
      )
    );
  }
}