import 'package:wallet_apps/index.dart';

class SlideDot extends StatelessWidget{

  final bool isActive;
  
  SlideDot(this.isActive);

  Widget build(BuildContext context){
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 6),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? Color(AppUtils.convertHexaColor(AppColors.secondary)) : Colors.grey,
        borderRadius: BorderRadius.all(Radius.circular(12))
      ),
    );
  }
}