import 'package:app/core/theme/app_theme.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MotivationalQuotesCarousel extends StatelessWidget {
  final List<String> quotes = [
    "Believe in yourself and all that you are. Know that there is something inside you that is greater than any obstacle.",
    "You are stronger than you know. More capable than you ever dreamed. And you are loved more than you could possibly imagine.",
    "It's okay to not be okay. Just remember that it's not okay to stay that way.",
    "Your mental health is a priority. Your happiness is an essential. Your self-care is a necessity.",
    "Take a deep breath. It’s just a bad day, not a bad life.",
  ];

  MotivationalQuotesCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 200,
      child: CarouselSlider.builder(
        itemCount: quotes.length,
        itemBuilder: (context, index, realIndex) {
          return Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              // color: Colors.white,
              gradient: containerGradient,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                quotes[index],
                style: const TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          aspectRatio: 2.0,
          pauseAutoPlayOnTouch: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: Duration(seconds: 2),
          viewportFraction: 0.8,
        ),
      ),
    );
  }
}
