/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (get_icon.dart) Last Modified on 1/3/23, 5:11 PM
 *
 */

import 'package:flutter/material.dart';

class GetIcon extends StatefulWidget {
  final String category;
  const GetIcon({Key? key, required this.category}) : super(key: key);

  @override
  State<GetIcon> createState() => _GetIconState();
}

class _GetIconState extends State<GetIcon> {

  IconData getIcon() {
    if (widget.category == "Automotive") {
      return Icons.directions_car;
    }  //technology, cooking, sports, home, other
    else if (widget.category == "Technology") {
      return Icons.computer;
    } else if (widget.category == "Cooking") {
      return Icons.restaurant;
    } else if (widget.category == "Sports") {
      return Icons.sports;
    } else if (widget.category == "Home") {
      return Icons.home;
    } else {
      return Icons.help;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Icon(getIcon());
  }
}
