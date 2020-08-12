import 'package:wallet_apps/index.dart';

class SlideBuilder extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SlideBidlderState();
  }
}

class SlideBidlderState extends State<SlideBuilder>{

  final PageController _pageController = PageController(initialPage: 0);
  
  void onChanged(int value){
    
  }

  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context){
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      itemCount: slideList.length,
      onPageChanged: onChanged,
      itemBuilder: (context, int index){
        return SlideItem(index);
      }
    );
  }
}