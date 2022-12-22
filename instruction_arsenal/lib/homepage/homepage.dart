import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/official_instructions/official_instructions_tab.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);


  @override
  State<Homepage> createState() => _HomepageState();
}



class _HomepageState extends State<Homepage> with TickerProviderStateMixin{

  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Instruction Arsenal',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'armalite',
            fontSize: 30
          ),),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black87,
          indicatorColor: Colors.black45,
          tabs: const [
            Tab(text: 'Official'),
            Tab(text: 'Community-Made'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          OfficialInstructionsTab(),
          Center(child: Text('Community-Made Instructions coming soon')),
        ],
      ),
    );
  }

}
