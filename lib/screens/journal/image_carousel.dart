import 'dart:typed_data';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class JournalImageCarousel extends StatelessWidget {
  final List<Uint8List> images;

  JournalImageCarousel(this.images);

  @override
  Widget build(BuildContext context) {
    print("image carousel $images");
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CarouselSlider.builder(
        options: CarouselOptions(
          height: 200,
          autoPlay: true,
          enlargeCenterPage: true,
          viewportFraction: 1,
        ),
        itemBuilder: (BuildContext context, int index, int realIndex) {
          return Container(
              color: Colors.black,
              width: double.infinity,
              height: 200,
              child: FittedBox(
                  child: Image.memory(images[index], fit: BoxFit.fill)));
        },
        itemCount: images.length,
      ),
    );
  }
}
