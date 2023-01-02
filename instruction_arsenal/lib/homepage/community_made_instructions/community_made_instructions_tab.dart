import 'package:flutter/material.dart';

class CommunityMadeInstructionsTab extends StatefulWidget {
  const CommunityMadeInstructionsTab({Key? key}) : super(key: key);

  @override
  State<CommunityMadeInstructionsTab> createState() => _CommunityMadeInstructionsTabState();
}

class _CommunityMadeInstructionsTabState extends State<CommunityMadeInstructionsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextField(
                onSubmitted: (value) {
                  print(value);
                  //Refresh results
                },
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.phone_android),
                  //TODO icon changes based on the category (ex. Tech, Food, etc.)
                  //TODO the listview is always shown with http://.../communitymade/all but changes once a search is made
                  title: Text('How to make a phone call'),
                  subtitle: Text('Example Search Result Description'),
                  onTap: () {
                    //Search for instructions
                  },
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: Icon(Icons.fastfood),
                  //TODO icon changes based on the category (ex. Tech, Food, etc.)
                  //TODO the listview is always shown with http://.../communitymade/all but changes once a search is made
                  title: Text('How to cook a steak'),
                  subtitle: Text('Example Search Result Description'),
                  onTap: () {
                    //Search for instructions
                  },
                ),
              ),
            ],
          ),
        )
      ),

    );
  }
}
