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
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.search),
                        ],
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: const ElevatedButton(onPressed: null, child: Text(
                          "Search"
                        ),
                        ),
                      )
                      //filters and other stuff
                    ],
                  ),
                )
              )

            ],
          ),
        )
      ),
    )
    );
  }
}
//search where it brings you to a new page with results