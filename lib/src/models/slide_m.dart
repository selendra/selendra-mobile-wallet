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
    image: "assets/images_slide/transaction.svg", 
    title: "Transaction",
    description: "Send money to each other fast and easy"
  ),
  SlideModel(
    image: "assets/images_slide/portfolio.svg",
    title: 'Portfolio', 
    description: 'Track your portfolio'
  ),
  SlideModel(
    image: "assets/images_slide/trx_history.svg",
    title: "History",
    description: "Track your transaction history"
  ) 
];