import 'dart:async';

import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/community_made_instructions_tab.dart';
import 'package:instruction_arsenal/homepage/official_instructions/official_instructions_tab.dart';

import '../utils/dynamic_links_service.dart';
import 'main_drawer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);


  @override
  State<Homepage> createState() => _HomepageState();
}



class _HomepageState extends State<Homepage> with TickerProviderStateMixin, WidgetsBindingObserver{
  final DynamicLinkService _dynamicLinkService = DynamicLinkService();
  late Timer _timerLink;
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _timerLink = Timer(
        const Duration(milliseconds: 1000),
            () {
          _dynamicLinkService.retrieveDynamicLink(context);
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    if (_timerLink != null) {
      _timerLink.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MainDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: const Icon(Icons.account_circle_rounded, color: Colors.black), onPressed: () {_scaffoldKey.currentState!.openDrawer();}),
        centerTitle: true,
        title: const Text('Instruction Arsenal',
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'armalite',
            fontSize: 25
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
          CommunityMadeInstructionsTab(),
        ],
      ),
    );
  }

}
