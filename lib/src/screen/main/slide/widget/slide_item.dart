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
          width: 286,
          height: 250,
          child: Image.asset(slideList[index].image, height: 285),
        ),
        FittedBox(
          child: SizedBox(
            width: 224,
            child: CustomText(
              text: slideList[index].description
            )
          )
        )
      ],
    );
  }
}