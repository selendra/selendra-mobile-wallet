import 'package:wallet_apps/index.dart';

class SlideBuilder extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SlideBuilderState();
  }
}

class SlideBuilderState extends State<SlideBuilder>{

  int _currentPage = 0; bool enableButton = false;

  final PageController _pageController = PageController(initialPage: 0);

  final GlobalKey global = new GlobalKey<ScaffoldState>();
  
  void onChanged(int value){
    setState((){
      if (value == 2){
        enableButton = true;
      } else if (enableButton) {
        enableButton = false;
      }

      _currentPage = value;
    });
  }

  @override
  void dispose(){
    super.dispose();
  }

  Widget build(BuildContext context){
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [

            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                controller: _pageController,
                itemCount: slideList.length,
                onPageChanged: onChanged,
                itemBuilder: (context, int index){
                  return SlideItem(index);
                }
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Expanded(
                    child: !enableButton ? AnimatedContainer(
                      alignment: Alignment.bottomLeft,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.bounceIn,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: MyText(text: 'Skip', textAlign: TextAlign.left, color: "#FFFFFF", fontWeight: FontWeight.bold),
                      ),
                    ) : Container(),
                  ),

                  Expanded(
                    child: SizedBox(
                      height: 30,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for(int i =  0; i < slideList.length; i++)
                            if ( i == _currentPage)
                              SlideDot(true)
                            else 
                              SlideDot(false),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: enableButton ? AnimatedContainer(
                      alignment: Alignment.bottomRight,
                      duration: Duration(milliseconds: 700),
                      curve: Curves.bounceIn,
                      child: InkWell(
                        onTap: (){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            MyText(text: 'Get Start', textAlign: TextAlign.right, color: AppColors.secondary, fontWeight: FontWeight.bold),
                            // Icon(LineAwesomeIcons.alternate_long_arrow_right, color: Color(AppUtils.convertHexaColor(AppColors.secondary_text)),)
                          ],
                        ),
                      ),
                    ) : Container(),
                  )
                ] 
              ),
            )
          ],
        ),
      )
    );
  }
}