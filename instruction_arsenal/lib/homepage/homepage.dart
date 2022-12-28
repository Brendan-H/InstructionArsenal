import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/official_instructions/official_instructions_tab.dart';
import 'package:instruction_arsenal/homepage/profile/profile_page.dart';
import 'package:instruction_arsenal/login_page/login_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);


  @override
  State<Homepage> createState() => _HomepageState();
}



class _HomepageState extends State<Homepage> with TickerProviderStateMixin{

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
      key: _scaffoldKey,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 120.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                ),
                child: Text(
                  FirebaseAuth.instance.currentUser?.email ?? "Email",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () async{
                await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => ProfilePage(),
              ),
                  (r) => false,
            );},
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
          ],
        ),
      ),
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
        children: [
          const OfficialInstructionsTab(),
          Center(child: ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                await Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPageWidget(),
                  ),
                      (r) => false,
                );
              },
              child: Text("Logout"))
          ),
        ],
      ),
    );
  }

}
