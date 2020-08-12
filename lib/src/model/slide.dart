import 'package:wallet_apps/index.dart';

class SlideModel{
  final String image;
  final String title;
  final String description;

  SlideModel({
    @required this.image,
    @required this.title,
    @required this.description
  });
}

final slideList = [
  SlideModel(
    image: "assets/images/images_slide/Transfer.png", 
    title: "Blockchain as a Customer Loyalty solution",
    description: "Customer loyalty programs allow companies to reward customers who make purchases frequently or on a specified period"
  ),
  SlideModel(
    image: "assets/images/images_slide/Card.png", 
    title: 'Crowdfunding And Vested',
    description: 'Our Platform enables any startup to create an asset and accept crowdfunding secured by the Zeetomic custodian account.'
  ),
  // SlideModel(
  //   image: "assets/images/images_slide/BitCoin.png", 
  //   title: "API for Payment Solutions",
  //   description: "With our robust API developers can access payment ecosystems for a more dynamic transition of value."
  // ) 
];