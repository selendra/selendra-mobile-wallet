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
                    icon: "sld_qr.svg",
                    action: () async {
                      try {
                        TrxOptionMethod.scanQR(context, portfolioList, resetHomeData);
                      } catch (e){
                        print(e.message);
                      }
                    },
                  ),
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: "icons/form.svg",
                    subTitle: "Fill wallet", 
                    action: () {
                      TrxOptionMethod.navigateFillAddress(context, portfolioList, resetHomeData);
                    }
                  )
                ),

                Expanded(
                  child: MyBottomSheetItem(
                    icon: "icons/contact.svg",
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
                child: SvgPicture.asset('assets/no_data.svg', width: 285, height: 278)
              ),
            )
          ],
        ),
      );
    },
    );
  }
}