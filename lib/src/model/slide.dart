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
  // SlideModel(
  //   image: "assets/images/images_slide/Transfer.png", 
  //   title: "Blockchain as a Customer Loyalty solution",
  //   description: ""
  // ),
  SlideModel(
    image: "assets/images/images_slide/transaction.png",
    title: 'Transaction', 
    description: 'Send token to each other.'
  ),
  SlideModel(
    image: "assets/images/images_slide/Card.png",
    title: "History",
    description: "Track your transaction history and activity."
  ) 
];