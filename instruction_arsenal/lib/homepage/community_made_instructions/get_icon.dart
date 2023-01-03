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
