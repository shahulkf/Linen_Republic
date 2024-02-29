import 'package:flutter/material.dart';
import 'package:linen_republic/features/home/model/product_model.dart';

const height10 = SizedBox(
  height: 10,
);
const height20 = SizedBox(
  height: 20,
);
const height30 = SizedBox(
  height: 30,
);
const height40 = SizedBox(
  height: 40,
);

const onBoardItems = [
  {
    'image': 'assets/pexels-cottonbro-studio-7764066.jpg',
    'title': 'Take Advantages of The offer Shopping',
    'subtitle':
        'Publish your photos to make yourself more beautiful with this app.'
  },
  {
    'image': 'assets/pexels-luca-nardone-3651597.jpg',
    'title': 'Take Advantages of The offer Shopping',
    'subtitle':
        'Publish your photos to make yourself more beautiful with this app.'
  },
  {
    'image': 'assets/pexels-spencer-selover-775355.jpg',
    'title': 'Take Advantages of The offer Shopping',
    'subtitle':
        'Publish your photos to make yourself more beautiful with this app.'
  },
];

final banners = [
  Image.asset(
    'assets/banner1.jpeg',
    fit: BoxFit.cover,
  ),
  Image.asset(
    'assets/banner2.jpeg',
    fit: BoxFit.cover,
  ),
  Image.asset(
    'assets/banners.jpeg',
    fit: BoxFit.fitWidth,
  ),
];

const categories = ['All', 'Classic', 'Vintage', 'Printed'];

final products = [
  ProductModel(
      image: ['assets/linen_shirt_1.jpeg'],
      title: 'Linen Club',
      description: 'Men Slim Fit Shirt',
      rating: 3.2,
      price: 999),
  ProductModel(
      image: ['assets/linen_shirt_1.jpeg'],
      title: 'Linen Club',
      description: 'Men Slim Fit Shirt',
      rating: 3.2,
      price: 899),
  ProductModel(
      image: ['assets/linen_shirt_1.jpeg'],
      title: 'Linen Club',
      description: 'Men Slim Fit Shirt',
      rating: 3.2,
      price: 2999),
  ProductModel(
      image: ['assets/linen_shirt_1.jpeg'],
      title: 'Linen Club',
      description: 'Men Slim Fit Shirt',
      rating: 3.2,
      price: 799),
  ProductModel(
      image: ['assets/linen_shirt_1.jpeg'],
      title: 'Linen Club',
      description: 'Men Slim Fit Shirt',
      rating: 3.2,
      price: 3999),
];
