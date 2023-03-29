/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (community_made_instructions_tab.dart) Last Modified on 3/27/23, 6:13 PM
 *
 */

import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instruction_arsenal/backend/models/community_made_instructions.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/CommunityMadeInstructionsCategorySliver.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/CommunityMadeInstructionsSearchSliver.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/community_made_instructions_info_page.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/create_community_made_instructions.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/get_icon.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/star_difficulty.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommunityMadeInstructionsTab extends StatefulWidget {
  const CommunityMadeInstructionsTab({Key? key}) : super(key: key);

  @override
  State<CommunityMadeInstructionsTab> createState() => _CommunityMadeInstructionsTabState();
}

class _CommunityMadeInstructionsTabState extends State<CommunityMadeInstructionsTab> {
  final TextEditingController _searchController = TextEditingController();

  final List<CommunityMadeInstructions> exampleCommunityMadeInstructions = <CommunityMadeInstructions>[
    CommunityMadeInstructions(
      id: 999,
      title: 'Example Community Made Instructions',
      description: 'This is an example of a community made instructions',
      category: 'Other',
      difficulty: 1,
      postCreatedAt : "2023-01-03T16:54:30.756846",
      createdBy: "bjharan7@gmail.com",
      instructions: "Step 1: Example Step 1. Step 2: Example Step 2. Step 3: Example Step 3.ldsjbflbfkjsbfkjjbdsfkjbdskjfbskdjfbksdjbfksdjbfkjsdbfkdjsbdkjfbkdjsbjbdksfkjbdskjsbdfkjbdskfjbdsjkfbdsjfbds",
      likes: 155,
      dislikes: 11,
      tags: "example, cars, tire, automotive, wheels, repair",
      timeToComplete: "30 Minutes",
      sponsored: true,
    )
  ];

  Future<List<CommunityMadeInstructions>?> fetchCommunityMadeInstructions(int pageKey) async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var title = _searchController.text;
    var category = categoryChoice;
    if (_searchController.text.length > 3) {
     var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/titleandcategory/$title/$category?pageNo=$pageKey&pageSize=$_pageSize',
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
        final isLastPage = communityMadeInstructions.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(communityMadeInstructions);
          print(communityMadeInstructions[0].title);
        } else {
          final nextPageKey = pageKey + communityMadeInstructions.length;
          _pagingController.appendPage(communityMadeInstructions, nextPageKey);
          print(communityMadeInstructions[0].title);
        }

        print(communityMadeInstructions[0].title);
        return communityMadeInstructions;
      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
       // return exampleCommunityMadeInstructions;
        throw Exception('An error occurred');
      }
    } else if (_searchController.text.isEmpty) {
      var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/all?pageNo=$pageKey&pageSize=$_pageSize',
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
        final isLastPage = communityMadeInstructions.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(communityMadeInstructions);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(communityMadeInstructions, nextPageKey);
        }
        print(communityMadeInstructions);

        return communityMadeInstructions;

      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
        return exampleCommunityMadeInstructions;
       // throw Exception('An error occurred');
      }
    } else {
      //return exampleCommunityMadeInstructions;
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
    S2Choice<String>(value: 'Automotive', title: 'Automotive'),
    S2Choice<String>(value: 'Cooking', title: 'Cooking'),
    S2Choice<String>(value: 'Sports', title: 'Sports'),
    S2Choice<String>(value: 'Home', title: 'Home'),
    S2Choice<String>(value: 'Other', title: 'Other'),
  ];

  late Future<List<CommunityMadeInstructions>?> futureCommunityMadeInstructions;


  var categoryChoice = "Automotive";

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      fetchCommunityMadeInstructions(pageKey);
    });

    super.initState();
    //futureCommunityMadeInstructions = fetchCommunityMadeInstructions();
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
   // fetchCommunityMadeInstructions();
  }

  static const _pageSize = 20;

  final PagingController<int, CommunityMadeInstructions> _pagingController =
  PagingController(firstPageKey: 0);




  @override
  Widget build(BuildContext context) {
    String dateTimeFormat(String format, DateTime? dateTime) {
      if (dateTime == null) {
        return '';
      }
      if (format == 'relative') {
        return timeago.format(dateTime);
      }
      return DateFormat(format).format(dateTime);
    }



    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {  },
        child: PopupMenuButton<int>(
          icon: const Icon(Icons.add),
          onSelected: (widget) async {
            await Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateCommunityMadeInstructionsPage(),
              ),
                  (r) => false,
            );
          },
          itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: Row(
                children: const [
                  Icon(Icons.add,
                    color: Colors.black,),
                  SizedBox(
                    // sized box with width 10
                    width: 15,
                  ),
                  Text("Add Instructions")
                ],
              ),
            ),
          ],
          offset: const Offset(0, 100),
          color: Colors.white,
          elevation: 2,
        ),

      ),
      backgroundColor: Colors.white60,
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Expanded(
                child: CustomScrollView(
                  slivers: <Widget> [
                    CommunityMadeInstructionsSearchSliver(
                      onChanged: (value) {
                        setState(() {
                          _searchController.text = value;
                          _pagingController.refresh();
                        });
                      },
                    ),
                    CommunityMadeInstructionsCategorySliver(
                      onChanged: (value) {
                        setState(() {
                          categoryChoice = value;
                          _pagingController.refresh();
                        });
                      },
                    ),
                    PagedSliverList<int, CommunityMadeInstructions>(
                    pagingController: _pagingController,
                    builderDelegate: PagedChildBuilderDelegate<CommunityMadeInstructions>(
                      itemBuilder: (context, item, index) => InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommunityMadeInstructionsInfoPage(
                                  communityMadeInstructions: item,
                                isMyPost: false,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
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
                                          Text("Created By: ${item.createdBy}"),
                                          const Spacer(),
                                          Visibility(
                                            visible: item.sponsored ?? false,
                                            child: const Text("Sponsored",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight: FontWeight.bold)
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text('${item.title}',
                                      style: const TextStyle(
                                          fontSize: 22,
                                          fontWeight: FontWeight.w600
                                      ),),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Text(item.description ?? "description",
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child:
                                      //Text(communityMadeInstruction.instructions ?? "instructions",
                                      Text(item.instructions!.length > 200 ? '${item.instructions!.substring(0, 200)}...' : item.instructions ?? "Title",
                                        //TODO only show first 100 characters and add "..." at the end
                                        style: const TextStyle(
                                            fontSize: 13,
                                            color: Colors.black54
                                        ),),
                                    ),

                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Row(
                                        children: [
                                          const Text("Difficulty: "),
                                          StarDifficulty(difficulty: item.difficulty as int),
                                          const Spacer(),
                                          const Text("Time to Complete: 30 minutes"),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        GetIcon(category: item.category ?? "Other"),
                                        Padding(
                                          padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                          child: Text("Category: ${item.category}"),
                                        ),
                                        const Spacer(),
                                        const Icon(Icons.favorite_border, color: Colors.red,),
                                        Text((item.likes!.toInt() - item.dislikes!.toInt()).toString()),
                                        const Spacer(),
                                        Text(dateTimeFormat(
                                          //  "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                                          // "hh:mma MMMM dd, yyyy",
                                            "MMMM dd, yyyy hh:mma",
                                            DateTime.parse(item.postCreatedAt ?? "Cannot retrieve time when post was created")))
                                      ],
                                    ),

                                  ],
                                ),
                              )
                          ),

                        ),
                      ),

                    ),

                  ),
                  ]
                )


              )
            ],
          ),
        )
      ),

    );
  }
  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
