import 'package:wallet_apps/index.dart';

class SlideItem extends StatelessWidget{

  final index;

  SlideItem(this.index);
  
  Widget build(BuildContext context){
    return Column(
      // horizontal).
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Image.asset(slideList[index].image, height: 285),
        ),
        CustomText(
          text: slideList[index].description
        )
      ],
    );
  }
}