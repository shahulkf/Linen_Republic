import 'package:flutter/material.dart';
import 'package:linen_republic/features/home/model/product_model.dart';
import 'package:linen_republic/utils/responsive/responsive.dart';

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

const height50 = SizedBox(
  height: 50,
);
const height100 = SizedBox(
  height: 100,
);

const width5 = SizedBox(
  width: 5,
);
const width10 = SizedBox(
  width: 10,
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
