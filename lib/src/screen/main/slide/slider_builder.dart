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
    print(value);
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
        child: Stack(
          children: [
            PageView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemCount: slideList.length,
              onPageChanged: onChanged,
              itemBuilder: (context, int index){
                return SlideItem(index);
              }
            ),
            // Slider Dot And Arrow Forward
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 30),
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
                      )
                    )
                  ),
                  if (enableButton) Align(
                    alignment: Alignment.bottomRight,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 700),
                      curve: Curves.bounceIn,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 30), 
                        child: InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomText(text: 'Get Start', color: AppColors.secondary, fontWeight: FontWeight.bold),
                              // Icon(LineAwesomeIcons.alternate_long_arrow_right, color: Color(AppUtils.convertHexaColor(AppColors.secondary_text)),)
                            ],
                          ),
                        )
                      ),
                    )
                  )
                ] 
              ),
            )
          ]
        )
      ),
    );
  }
}