import 'package:wallet_apps/index.dart';

class MyBottomSheet{

  dynamic response;
  
  Future<dynamic> trxOptions({
    BuildContext context,
    List portfolioList,
    Function resetHomeData
  }) {
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: hexaCodeToColor(AppColors.bgdColor)
        ),
        height: 153,
        child: Column(
          children: [

            Align(
              alignment: Alignment.center,
              child: MyText(
                color: "#FFFFFF",
                top: 20,
                bottom: 33,
                text: "Transaction options",
              ),
            ),
            
            Row(
              children: [

                Expanded(
                  child: MyBottomSheetItem(
                    subTitle: "Scan wallet",
                    isIconButton: false,
                    action: () async {
                      TrxOptionMethod.scanQR(context, portfolioList, resetHomeData);
                    },
                  ),
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: LineAwesomeIcons.add_to_shopping_cart,
                    subTitle: "Fill wallet", 
                    action: () {
                      TrxOptionMethod.navigateFillAddress(context, portfolioList, resetHomeData);
                    }
                  )
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: LineAwesomeIcons.phone,
                    subTitle: "Invite friend", 
                    action: () {
                      TrxOptionMethod.selectContact(context, portfolioList, resetHomeData);
                    }
                  )
                )
              ],
            )
          ],
        ),
      );
    });
  }

  Future<dynamic> notification({
    BuildContext context
  }) {
    return showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
      return Container(
        decoration: BoxDecoration(
          color: hexaCodeToColor(AppColors.bgdColor)
        ),
        height: MediaQuery.of(context).size.height - 107,
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: MyText(
                color: "#FFFFFF",
                top: 20,
                bottom: 33,
                text: "Notification",
              ),
            ),

            Expanded(
              child: Center(
                child: SvgPicture.asset('assets/not_found.svg', width: 285, height: 278)
              ),
            )
          ],
        ),
      );
    },
    );
  }
}