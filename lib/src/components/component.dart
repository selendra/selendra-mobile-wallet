// import 'package:pull_to_refresh/pull_to_refresh.dart';
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
  final double width;
  final double height;

  MyFlatButton({
    this.textButton, 
    this.buttonColor = AppColors.secondary, 
    this.fontWeight =  FontWeight.bold, 
    this.fontSize = 18, 
    this.edgeMargin = const EdgeInsets.fromLTRB(0, 0, 0, 0),
    this.edgePadding = const EdgeInsets.fromLTRB(0, 0, 0, 0), 
    this.hasShadow = false, 
    this.width = double.infinity,
    this.height,
    @required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: edgePadding,
      margin: edgeMargin,
      width: width,
      height: height,
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
          pTop: 20,
          pBottom: 20,
          text: textButton,
          color: action != null ? '#FFFFFF' : AppColors.textBtnColor,
          fontWeight: fontWeight,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        onPressed: action
      ),
    );
  }
}

class MyText extends StatelessWidget{

  final String text; final String color; final double fontSize; final FontWeight fontWeight;
  final double top; final double right; final double bottom; final double left;
  final double pTop; final double pRight; final double pBottom; final double pLeft;
  final double width; final double height; final TextAlign textAlign;
  final TextOverflow overflow;

  MyText({
    this.text, this.color = AppColors.textColor, this.fontSize = 18, this.fontWeight = FontWeight.normal,
    this.top = 0, this.right = 0, this.bottom = 0, this.left = 0,
    this.pLeft = 0, this.pRight = 0, this.pTop = 0, this.pBottom = 0,
    this.width, this.height, this.textAlign = TextAlign.center,
    this.overflow,
  });
  
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.fromLTRB(this.left, this.top, this.right, this.bottom),
      padding: EdgeInsets.fromLTRB(pLeft, pTop, pRight, pBottom),
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
          textAlign: this.textAlign,
          overflow: overflow,
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
  final double imageWidth;
  final double imageHeight;
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
    this.imageWidth,
    this.imageHeight,
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
      child: SvgPicture.asset(imagePath, color: colorImage, width: imageWidth, height: imageHeight)
    );
  }
}

class MyAppBar extends StatelessWidget{

  final double  pLeft; final double pTop; final double pRight; final double pBottom;
  final EdgeInsetsGeometry margin;
  final String title;
  final Function onPressed;
  final Color color;

  MyAppBar({
    this.pLeft = 0,
    this.pTop = 0,
    this.pRight = 0,
    this.pBottom = 0,
    this.margin = const EdgeInsets.fromLTRB(0, 16, 0, 0),
    @required this.title,
    this.color,
    this.onPressed
  });
  
  Widget build(BuildContext context) {
    return Container(
      height: 65.0, 
      width: MediaQuery.of(context).size.width, 
      margin: margin,
      color: hexaCodeToColor(AppColors.cardColor),
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
    this.left = 0, this.top = 0, this.right = 0, this.bottom = 16,
    this.child,
    this.height,
    this.width,
  });
  
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        color: Color(AppUtils.convertHexaColor(AppColors.bgdColor)),
        padding: EdgeInsets.fromLTRB(left, top, right, bottom),
        child: SafeArea(
          child: this.child
        ),
      )
    );
  }
}

class MyIconButton extends StatelessWidget{

  final String icon;
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
    return Container(
      padding: padding,
      child: GestureDetector(
        onTap: onPressed,
        child: SvgPicture.asset(
          'assets/icons/$icon', 
          width: 30, 
          height: 30, 
          color: Colors.white
        ),
      ),
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
        // holeLabel: amount,
        // labelStyle:TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, ),
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
  final int rate;

  MyColumnBuilder({@required this.data, this.margin, this.rate});
  
  Widget build(BuildContext context){
    return Container(
      margin: margin,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        itemCount: data.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return portFolioItemRow(data, index, rate);
        },
      )
    );
  }
}

class MyRowHeader extends StatelessWidget{

  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
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

/* Trigger Snack Bar Function */
void snackBar(GlobalKey<ScaffoldState> globalKey, String contents) {
  final snackbar = SnackBar(
    duration: Duration(seconds: 2),
    content: Text(contents),
  );
  globalKey.currentState.showSnackBar(snackbar);
}

class MyPinput extends StatelessWidget {

  final String obscureText;
  final GetWalletModel getWalletM;
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function onChanged;
  final Function onSubmit;

  MyPinput({
    this.obscureText = '⚪',
    this.getWalletM,
    this.controller,
    this.focusNode,
    this.onChanged,
    this.onSubmit,
  });

  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      margin: EdgeInsets.only(bottom: 30),
      child: PinPut(
        obscureText: obscureText,
        focusNode: focusNode,
        controller: controller,
        fieldsCount: 4,

        selectedFieldDecoration: getWalletM.pinPutDecoration.copyWith(
          color: Colors.grey.withOpacity(0.5),
          border: Border.all(color: Colors.grey, width: 1)
        ),

        submittedFieldDecoration: getWalletM.error 
        ? getWalletM.pinPutDecoration.copyWith(
          border: Border.all(width: 1, color: Colors.red)
        ) 
        : getWalletM.pinPutDecoration,

        followingFieldDecoration: getWalletM.error 
        ? getWalletM.pinPutDecoration.copyWith(
          border: Border.all(width: 1, color: Colors.red)
        )
        : getWalletM.pinPutDecoration,

        eachFieldConstraints: getWalletM.boxConstraint,
        textStyle: TextStyle(
          fontSize: 18,
          color: Colors.white
        ),
        onChanged: onChanged,
        onSubmit: onSubmit,
      ),
    );
  }
}