import 'package:wallet_apps/index.dart';

class SlideBuilder extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SlideBidlderState();
  }
}

class SlideBidlderState extends State<SlideBuilder>{

  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);
  
  void onChanged(int value){
    setState((){
      _currentPage = value;
    });
  }

  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context){
    return Column(
      children: [
        Expanded(
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
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
              Stack(
                alignment: AlignmentDirectional.topStart,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(bottom: 35),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for(int i =  0; i < slideList.length; i++)
                          if ( i == _currentPage)
                            SlideDot(true)
                          else 
                            SlideDot(false)
                      ],
                    )
                  )
                ],
              )
            ]
          )
        )
        // PageView.builder(
        //   scrollDirection: Axis.horizontal,
        //   controller: _pageController,
        //   itemCount: slideList.length,
        //   onPageChanged: onChanged,
        //   itemBuilder: (context, int index){
        //     return SlideItem(index);
        //   }
        // ),
        // Stack(
        //   alignment: AlignmentDirectional.topStart,
        //   children: <Widget>[
        //     Container(
        //       margin: const EdgeInsets.only(bottom: 35),
        //       child: Row(
        //         mainAxisSize: MainAxisSize.min,
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           for(int i =  0; i < slideList.length; i++)
        //             if ( i == _currentPage)
        //               SlideDot(true)
        //             else 
        //               SlideDot(false)
        //         ],
        //       )
        //     )
        //   ],
        // )
      ],
    );
  }
}