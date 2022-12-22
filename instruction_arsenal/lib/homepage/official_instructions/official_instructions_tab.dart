import 'package:flutter/material.dart';


class OfficialInstructionsTab extends StatefulWidget {
  const OfficialInstructionsTab({Key? key}) : super(key: key);

  @override
  State<OfficialInstructionsTab> createState() => _OfficialInstructionsTabState();
}

class _OfficialInstructionsTabState extends State<OfficialInstructionsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
      scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [


            ],
          ),
        )
      ),
    )
    );
  }
}
//search where it brings you to a new page with results