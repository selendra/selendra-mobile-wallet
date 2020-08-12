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
          child: Image.asset(slideList[index].image, height: 200),
        ),
        Text(
          slideList[index].title, 
          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Text(
          slideList[index].description,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}