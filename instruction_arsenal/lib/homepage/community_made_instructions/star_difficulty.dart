/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (star_difficulty.dart) Last Modified on 1/3/23, 4:58 PM
 *
 */

import 'package:flutter/material.dart';

class StarDifficulty extends StatefulWidget {

  final int difficulty;
  const StarDifficulty({Key? key, required this.difficulty}) : super(key: key);

  @override
  State<StarDifficulty> createState() => _StarDifficultyState();
}

class _StarDifficultyState extends State<StarDifficulty> {

  Color getStarColor() {
    if (widget.difficulty == 1) {
      return Colors.lightGreen;
    } else if (widget.difficulty == 2) {
      return Colors.yellow;
    } else if (widget.difficulty == 3) {
      return Colors.orange;
    } else if (widget.difficulty == 4) {
      return Colors.red;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: getStarColor(),
          ),
          Visibility(
            visible: widget.difficulty > 1,
            child: Icon(
              Icons.star,
              color: getStarColor(),
            ),
          ),
          Visibility(
            visible: widget.difficulty > 2,
            child: Icon(
              Icons.star,
              color: getStarColor(),
            ),
          ),
          Visibility(
            visible: widget.difficulty > 3,
            child: Icon(
              Icons.star,
              color: getStarColor(),
            ),
          ),
        ],
      ),
    );
  }
}
