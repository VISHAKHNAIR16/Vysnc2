import 'package:flutter/material.dart';

class FeatureCard {
  final String imagePath;

  final String title;

  final Widget screen;

  FeatureCard(
      {required this.imagePath, required this.title, required this.screen});
}
