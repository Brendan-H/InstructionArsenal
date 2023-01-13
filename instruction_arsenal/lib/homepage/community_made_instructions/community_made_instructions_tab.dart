import 'package:awesome_select/awesome_select.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:instruction_arsenal/backend/models/community_made_instructions.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/community_made_instructions_info_page.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/get_icon.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/star_difficulty.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:visibility_detector/visibility_detector.dart';

class CommunityMadeInstructionsTab extends StatefulWidget {
  const CommunityMadeInstructionsTab({Key? key}) : super(key: key);

  @override
  State<CommunityMadeInstructionsTab> createState() => _CommunityMadeInstructionsTabState();
}

class _CommunityMadeInstructionsTabState extends State<CommunityMadeInstructionsTab> {
  final TextEditingController _searchController = TextEditingController();

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
        print(communityMadeInstructions);
        final isLastPage = communityMadeInstructions.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(communityMadeInstructions);
        } else {
          final nextPageKey = pageKey + communityMadeInstructions.length;
          _pagingController.appendPage(communityMadeInstructions, nextPageKey);
        }
        return communityMadeInstructions;
      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
        throw Exception('An error occurred');
      }
    } else if (_searchController.text.isEmpty) {
      var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/all?pageNo=0&pageSize=20',
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


  var categoryChoice = "other";

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
                  modalHeaderStyle: const S2ModalHeaderStyle(
                    backgroundColor: Colors.black,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),

                  choiceStyle: const S2ChoiceStyle(
                    color: Colors.black,
                    titleStyle: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  onSelect: (selected, state) {
                    print(categoryChoice);
            //        fetchCommunityMadeInstructions();
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
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    ),
                    onPressed: () async {
                      var firebaseid = await FirebaseAuth.instance.currentUser?.getIdToken();
                      setState(() {
                   //     futureCommunityMadeInstructions = fetchCommunityMadeInstructions();
                      });

                      print(firebaseid);
                    },
                    child: const Text(
                        "Search",
                      style: TextStyle(
                          fontSize: 20,
                        )
                    ),
                  ),
                ),
              ),
              Expanded(
                child: PagedListView<int, CommunityMadeInstructions>(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<CommunityMadeInstructions>(
                    itemBuilder: (context, item, index) => InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommunityMadeInstructionsInfoPage(communityMadeInstructions: item.content![index]),
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
                                        Text("Created By: ${item.content![index].createdBy}"),
                                        const Spacer(),
                                        Visibility(
                                          visible: item.content![index].sponsored ?? false,
                                          child: const Text("Sponsored",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontWeight: FontWeight.bold)
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text('${item.content![index].title}',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w600
                                    ),),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text(item.content![index].description ?? "description",
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child:
                                    //Text(communityMadeInstruction.instructions ?? "instructions",
                                    Text(item.content![index].instructions!.length > 200 ? '${item.content![index].instructions!.substring(0, 200)}...' : item.content![index].instructions ?? "Title",
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
                                        StarDifficulty(difficulty: item.content![index].difficulty as int),
                                        const Spacer(),
                                        const Text("Time to Complete: 30 minutes"),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      GetIcon(category: item.content![index].category ?? "Other"),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                                        child: Text("Category: ${item.content![index].category}"),
                                      ),
                                      const Spacer(),
                                      const Icon(Icons.favorite_border, color: Colors.red,),
                                      Text((item.content![index].likes!.toInt() - item.content![index].dislikes!.toInt()).toString()),
                                      const Spacer(),
                                      Text(dateTimeFormat(
                                        //  "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                                        // "hh:mma MMMM dd, yyyy",
                                          "MMMM dd, yyyy hh:mma",
                                          DateTime.parse(item.content![index].postCreatedAt ?? "Cannot retrieve time when post was created")))
                                    ],
                                  ),

                                ],
                              ),
                            )
                        ),

                      ),
                    ),
                  ),

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
