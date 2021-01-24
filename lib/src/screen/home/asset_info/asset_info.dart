import 'package:flutter/material.dart';
import 'package:wallet_apps/src/components/component.dart';

import '../../../../index.dart';

class AssetInfo extends StatefulWidget {
  final String accBalance;
  AssetInfo({@required this.accBalance});
  @override
  _AssetInfoState createState() => _AssetInfoState();
}

class _AssetInfoState extends State<AssetInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyScaffold(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            MyAppBar(
              title: "Asset",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: hexaCodeToColor(AppColors.cardColor),
                ),
                child: Row(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(right: 16),
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: SvgPicture.asset('assets/sld_logo.svg'),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          text: "Balance",
                          color: "#FFFFFF",
                          fontSize: 20,
                        ),
                        SizedBox(height: 5),
                        MyText(
                          text: widget.accBalance.substring(0, 9) + " KPI",
                          color: AppColors.secondary_text,
                          fontSize: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 5,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: hexaCodeToColor(AppColors.secondary)),
                  ),
                  MyText(
                    text: 'Activity',
                    fontSize: 27,
                    color: "#FFFFFF",
                    left: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.only(left: 16, bottom: 8),
              alignment: Alignment.centerLeft,
              child: MyText(
                text: 'Yesterday',
                fontSize: 15,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) => rowDecorationStyle(
                  child: Row(
                    children: <Widget>[
                      MyCircularImage(
                        padding: EdgeInsets.all(6),
                        margin: EdgeInsets.only(right: 20),
                        decoration: BoxDecoration(
                            color: hexaCodeToColor(AppColors.secondary),
                            borderRadius: BorderRadius.circular(40)),
                        imagePath: 'assets/sld_logo.svg',
                        width: 50,
                        height: 50,
                        colorImage: Colors.white,
                      ),

                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                text: "KPI",
                                color: "#FFFFFF",
                                fontSize: 18,
                              ),
                              MyText(text: "Koompi", fontSize: 15),
                            ],
                          ),
                        ),
                      ),

                      // Container(
                      //   width: 80,
                      //   margin: EdgeInsets.only(right: 20),
                      //   alignment: Alignment.center,
                      //   child: SizedBox(
                      //     height: 25,
                      //     child: LineChart(
                      //       portfolioChart
                      //     ),
                      //   ),
                      // ),

                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(right: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                  width: double.infinity,
                                  text:
                                      "0", //portfolioData[0]["data"]['balance'],
                                  color: "#FFFFFF",
                                  fontSize: 18,
                                  textAlign: TextAlign.right,
                                  overflow: TextOverflow.ellipsis),
                              // MyText(
                              //   width: double.infinity,
                              //   text: "+",//"${!rate.isNegative ? '+' : ''}$rate",
                              //   textAlign: TextAlign.right,
                              //   color: AppColors.secondary_text,//!rate.isNegative ? AppColors.secondary_text : "#ff1900",
                              //   fontSize: 15
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
