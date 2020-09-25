import 'package:wallet_apps/index.dart';

class MyPieChartRow extends StatelessWidget{

  final Color color;
  final String centerText;
  final String endText;

  MyPieChartRow({
    this.color,
    this.centerText,
    this.endText
  });
  
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10)
                  ),
                ),

                MyText(
                  left: 11,
                  text: centerText,
                  fontSize: 16.0,
                  color: "#FFFFFF",
                )
              ],
            ),
          ),

          Flexible(
            child: MyText(
              text: endText,
              fontSize: 16.0,
            ),
          ),
        ],
      ),
    );
  }
}