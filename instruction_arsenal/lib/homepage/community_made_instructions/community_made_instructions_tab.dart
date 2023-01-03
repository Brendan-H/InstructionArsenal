import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/backend/models/community_made_instructions.dart';

class CommunityMadeInstructionsTab extends StatefulWidget {
  const CommunityMadeInstructionsTab({Key? key}) : super(key: key);

  @override
  State<CommunityMadeInstructionsTab> createState() => _CommunityMadeInstructionsTabState();
}

class _CommunityMadeInstructionsTabState extends State<CommunityMadeInstructionsTab> {
  final TextEditingController _searchController = TextEditingController();

  Future<List<CommunityMadeInstructions>?> fetchCommunityMadeInstructions() async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var title = _searchController.text;
    var category = categoryChoice;
    if (_searchController.text.isNotEmpty) {
      var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/titleandcategory/$title/$category',
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          ));
      if (response.statusCode == 200) {
        var communityMadeInstructions = <CommunityMadeInstructions>[];
        for (var communityMadeInstructionsJson in response.data) {
          communityMadeInstructions.add(CommunityMadeInstructions.fromJson(communityMadeInstructionsJson));
        }
        print(communityMadeInstructions);
        return communityMadeInstructions;

      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
        throw Exception('An error occurred');
      }
    } else if (_searchController.text.isEmpty) {
      var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/all',
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          )
      );
      if (response.statusCode == 200) {
        var communityMadeInstructions = <CommunityMadeInstructions>[];
        for (var communityMadeInstructionsJson in response.data) {
          communityMadeInstructions.add(CommunityMadeInstructions.fromJson(communityMadeInstructionsJson));
        }
        print(communityMadeInstructions);
        return communityMadeInstructions;

      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
        throw Exception('An error occurred');
      }
    } else {
      return null;
    }

  }
  showAlertDialog(BuildContext context) {

    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed:  () async {Navigator.pop(context);},
    );
    Widget continueButton = TextButton(
      child: const Text("Continue"),
      onPressed:  () async {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Post Deleted")));
        Navigator.pop(context);

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Delete Post"),
      content: const Text("Are you sure you would like to delete this post?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  List<S2Choice<String>> categoryChoiceOptions = [
    S2Choice<String>(value: 'Technology', title: 'Technology'),
    S2Choice<String>(value: 'Cars/Automotive', title: 'Cars/Automotive'),
    S2Choice<String>(value: 'Cooking', title: 'Cooking'),
    S2Choice<String>(value: 'Sports', title: 'Sports'),
    S2Choice<String>(value: 'Home', title: 'Home'),
    S2Choice<String>(value: 'Other', title: 'Other'),
  ];

  late Future<List<CommunityMadeInstructions>?> futureCommunityMadeInstructions;

  bool _buttonPressed = false;

  var categoryChoice = "other";

  @override
  void initState() {
    super.initState();
    futureCommunityMadeInstructions = fetchCommunityMadeInstructions();
  }

  void submitValue(String value) async {
    if (_searchController.text.length <
        4) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            "Title must be at least 4 characters long!",
          ),
        ),
      );
      return;
    }
    fetchCommunityMadeInstructions();
  }



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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: SmartSelect<String>.single(
                  choiceStyle: const S2ChoiceStyle(
                    titleStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onSelect: (selected, state) {
                    print(categoryChoice);
                    fetchCommunityMadeInstructions();
                  },
                  title: 'Category',
                  selectedValue: categoryChoice,
                  choiceItems: categoryChoiceOptions,
                  onChange: (state) => setState(() {
                    categoryChoice = state.value;
                  }),
                ),
              ),
              TextField(
                controller: _searchController,
                onChanged: (value) {
                  submitValue(value);
                },
                onSubmitted: (value) {
                  submitValue(value);
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

              //TODO icon changes based on the category (ex. Tech, Food, etc.)
              //TODO the listview is always shown with http://.../communitymade/all but changes once a search is made

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
                            children: const [
                              Text("Created By: bjharan7@gmail.com"),
                              Spacer(),
                              Text("Sponsored",
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
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text("This tutorial will show you the exact steps for safely replacing the tire on any car. It will be demonstrated on a 2017 Toyota Camry",
                          style: TextStyle(
                            fontSize: 15,
                          ),),
                        ),
                        const Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                          child: Text("""Step 1: Park the car on a flat surface and turn off the engine. Make sure the car is in park and the parking brake is on.
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
