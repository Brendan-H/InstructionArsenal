/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (profile_page.dart) Last Modified on 2/24/23, 5:44 PM
 *
 */

import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/homepage.dart';
import 'package:instruction_arsenal/profile/community_made_instructions_profile.dart';

import 'official_instructions_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);



  @override
  State<ProfilePage> createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> with TickerProviderStateMixin{
  late TabController _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      backgroundColor: Colors.white60,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
                  (r) => false,
            );
          },
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Your Instructions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
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
          OfficialInstructionsProfile(),
          CommunityMadeInstructionsProfile(),
        ],
      ),
    );
  }
}