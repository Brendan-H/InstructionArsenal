import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/official_instructions/official_instructions_tab.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.tabController}) : super(key: key);

  final TabController tabController;

  @override
  State<Homepage> createState() => _HomepageState();
}



class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TabBar(tabs: [
            const Tab(text: "Official",),
            const Tab(text: "Community-Made",),

          ],
            labelColor: Colors.black,
   //       controller: tabController,
          ),
        TabBarView(
            children: [OfficialInstructionsTab(),
              OfficialInstructionsTab(),

            ]
        )
        ]
      ),
    );
  }
}
