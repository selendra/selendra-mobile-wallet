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
          margin: EdgeInsets.only(bottom: 35),
          child: SvgPicture.asset(
            slideList[index].image, 
            width: 200, 
            height: 200
          ),
        ), 

        SizedBox(
          width: 224,
          child: MyText(
            text: slideList[index].description
          )
        )
      ],
    );
  }
}