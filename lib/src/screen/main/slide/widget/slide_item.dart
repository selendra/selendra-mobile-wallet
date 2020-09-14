import 'package:wallet_apps/index.dart';

class SlideItem extends StatelessWidget{

  final index;

  SlideItem(this.index);
  
  Widget build(BuildContext context){
    return Column(
      // horizontal).
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        MyIllustrate(
          imagePath: slideList[index].image,
        ),
        FittedBox(
          child: SizedBox(
            width: 224,
            child: MyText(
              text: slideList[index].description
            )
          )
        )
      ],
    );
  }
}