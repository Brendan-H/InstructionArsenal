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
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.phone_android),
                  //TODO icon changes based on the category (ex. Tech, Food, etc.)
                  //TODO the listview is always shown with http://.../communitymade/all but changes once a search is made
                  title: const Text('How to make a phone call'),
                  subtitle: const Text('Example Search Result Description'),
                  onTap: () {
                    //Search for instructions
                  },
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.fastfood),
                  title: const Text('How to cook a steak'),
                  subtitle: const Text('Example Search Result Description'),
                  onTap: () {
                    //Search for instructions
                  },
                ),
              ),
              Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.directions_car),
                  title: const Text('How to change a tire'),
                  subtitle: const Text('Example Search Result Description'),
                  onTap: () {
                    //Search for instructions
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .9945,
                height: MediaQuery.of(context).size.height * .33,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                          child: Row(
                            children: [
                              const Text("Created By: bjharan7@gmail.com"),
                              const Spacer(),
                              const Text("Sponsored",
                              style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)
                              ),
                            ],
                          ),
                        ),
                        const Text('How to change a tire on a car',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600
                        ),),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: const Text("This tutorial will show you the exact steps for safely replacing the tire on any car. It will be demonstrated on a 2017 Toyota Camry",
                          style: TextStyle(
                            fontSize: 15,
                          ),),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: const Text("""Step 1: Park the car on a flat surface and turn off the engine. Make sure the car is in park and the parking brake is on.
                           Step 2: Locate the jack and the lug wrench. Step 3: Remove the lug nuts from the tire . . .
                          """,
                            //TODO only show first 100 characters and add "..." at the end
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.black54
                            ),),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Row(
                            children: const [
                              Text("Difficulty: "),
                              Icon(Icons.star, color: Colors.red,),
                              Icon(Icons.star, color: Colors.red,),
                              Icon(Icons.star, color: Colors.red,),
                              Spacer(),
                              Text("Time to Complete: 30 minutes"),
                            ],
                          ),
                        ),
                        Row(
                          children: const [
                            Icon(Icons.directions_car),
                            Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Text("Category: Cars"),
                            ),
                            Spacer(),
                            Text("Date Created: 1/3/2023"),
                          ],
                        ),
                        
                      ],
                    ),
                  )
                ),
              ),
            ],
          ),
        )
      ),

    );
  }
}

// this.title = title;
// this.description = description;
// this.postCreatedAt = postCreatedAt;
// this.instructions = instructions;
// this.createdBy = createdBy;
// this.category = category;
// this.likes = likes;
// this.dislikes = dislikes;
// this.tags = tags;
// this.difficulty = difficulty;
// this.timeToComplete = timeToComplete;
// this.isSponsored = isSponsored;

//
// Step 4: Remove the tire from the car. Step 5: Place the spare tire on the car.
// Step 6: Replace the lug nuts and tighten them. Step 7: Lower the car and remove the jack.
// Step 8: Tighten the lug nuts. Step 9: Put the jack and lug wrench back in the trunk.
// Step 10: Drive the car to a tire shop to get the flat tire fixed.