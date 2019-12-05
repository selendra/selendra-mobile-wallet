import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:wallet_apps/src/provider/reuse_widget.dart';

Widget slideShow(){
  List<String> imageList = [
    "https://zeetomic-doc.s3-ap-southeast-1.amazonaws.com/promo/001.jpg",
    "https://zeetomic-doc.s3-ap-southeast-1.amazonaws.com/promo/002.jpg",
    "https://zeetomic-doc.s3-ap-southeast-1.amazonaws.com/promo/003.jpg"
  ];
  return CarouselSlider(
    autoPlay: true,
    enlargeCenterPage: true,
    items: imageList.map((i) {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size5),
          color: getHexaColor(borderColor)
        ),
        child: Image.network(i)
      );
    }).toList(),
  );
}
