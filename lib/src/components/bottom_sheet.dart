import 'package:polkawallet_sdk/storage/keyring.dart';
import 'package:polkawallet_sdk/polkawallet_sdk.dart';
import 'package:wallet_apps/index.dart';

class MyBottomSheet {
  dynamic response;

  Future<dynamic> trxOptions({
    BuildContext context,
    List portfolioList,
    Function resetHomeData,
    WalletSDK sdk,
    Keyring keyring,
  }) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Container(
            decoration:
                BoxDecoration(color: hexaCodeToColor(AppColors.bgdColor)),
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
                            await TrxOptionMethod.scanQR(context, portfolioList,
                                resetHomeData, sdk, keyring);
                          } catch (e) {
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
                              TrxOptionMethod.navigateFillAddress(context,
                                  portfolioList, resetHomeData, sdk, keyring);
                            })),
                    Expanded(
                        child: MyBottomSheetItem(
                            icon: "icons/contact.svg",
                            subTitle: "Invite friend",
                            action: () {
                              TrxOptionMethod.selectContact(
                                  context, portfolioList, resetHomeData);
                            }))
                  ],
                )
              ],
            ),
          );
        });
  }

  Future<dynamic> notification({BuildContext context}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(color: hexaCodeToColor(AppColors.bgdColor)),
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
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/no_data.svg', height: 200),
                  MyText(text: "There are no notification found")
                ],
              ))
            ],
          ),
        );
      },
    );
  }
}
