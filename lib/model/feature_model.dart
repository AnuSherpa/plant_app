import 'package:flutter/material.dart';

class FeatureModel {
  final String plantTitle, plantSubTitle, image, location, offer, contact;
  final double price, rating;

  FeatureModel({
    this.plantTitle,
    this.plantSubTitle,
    this.image,
    this.price,
    this.rating,
    this.location,
    this.offer,
    this.contact,
  });
}
