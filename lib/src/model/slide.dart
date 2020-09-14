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
    image: "assets/images/images_slide/transaction.png", 
    title: "Transaction",
    description: "Send money to each other fast and easy"
  ),
  SlideModel(
    image: "assets/images/images_slide/portfolio.png",
    title: 'Portfolio', 
    description: 'Track your portfolio'
  ),
  SlideModel(
    image: "assets/images/images_slide/trx_history.png",
    title: "History",
    description: "Track your transaction history"
  ) 
];