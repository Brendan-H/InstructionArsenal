/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (dynamic_link_info_page.dart) Last Modified on 2/24/23, 5:44 PM
 *
 */

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/backend/models/community_made_instructions.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/star_difficulty.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../utils/dynamic_links_service.dart';
import '../homepage.dart';
import 'get_icon.dart';

class CommunityMadeInstructionsDynamicLinkInfoPage extends StatefulWidget {

  final String id;
  final bool isMyPost;
  const CommunityMadeInstructionsDynamicLinkInfoPage({Key? key, required this.id, required this.isMyPost}) : super(key: key);

  @override
  State<CommunityMadeInstructionsDynamicLinkInfoPage> createState() => _CommunityMadeInstructionsDynamicLinkInfoPageState();
}

class _CommunityMadeInstructionsDynamicLinkInfoPageState extends State<CommunityMadeInstructionsDynamicLinkInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future<CommunityMadeInstructions?> fetchCommunityMadeInstructions() async {
    var id = widget.id;
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
      var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/titleandcategory/id/$id',
          options: Options(
            headers: {
              'Authorization': "Bearer $idToken",
            },
          ));
      if (response.statusCode == 200) {

        CommunityMadeInstructions communityMadeInstructions = response.data;
        return communityMadeInstructions;
      }
      else {
        if (response.statusCode == 404) {
          print('404');
        }
        throw Exception('An error occurred');
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
        var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
        var dio = Dio();
        await dio.delete(
            "http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/${widget.id}",
            options: Options(
              headers: {
                'Authorization': "Bearer $idToken",
              },
            )
        );
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
  late Future<CommunityMadeInstructions?> futureCommunityMadeInstructions;



  @override
  void initState() {
    super.initState();
    futureCommunityMadeInstructions = fetchCommunityMadeInstructions();
  }



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
      appBar: AppBar(
        actions: [
          Visibility(
            visible: widget.isMyPost,
            child: PopupMenuButton<int>(
              onSelected: (widget) {
                showAlertDialog(context);
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(Icons.delete),
                      SizedBox(
                        // sized box with width 10
                        width: 10,
                      ),
                      Text("Delete this post")
                    ],
                  ),
                ),
              ],
              offset: const Offset(0, 100),
              icon: const Icon(Icons.more_vert, color: Colors.black,),
              elevation: 2,
            ),
          ),
        ],
        centerTitle: true,
        backgroundColor: Colors.white,
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
        title: const Text('Community Made Instruction'),
      ),
      body: FutureBuilder<CommunityMadeInstructions?>(
        future: futureCommunityMadeInstructions,
        builder: (context, snapshot) {
          var communityMadeInstruction = snapshot.data;
          final createdAtDate = dateTimeFormat(
            //  "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
            // "hh:mma MMMM dd, yyyy",
              "MMMM dd, yyyy hh:mma",
              DateTime.parse(communityMadeInstruction?.postCreatedAt ?? "Cannot retrieve time when post was created"));
          final DynamicLinkService dynamicLinkService = DynamicLinkService();

          String getCreatedBy() {
            if (FirebaseAuth.instance.currentUser!.email == communityMadeInstruction?.createdBy) {
              return "You";
            }
            else {
              return communityMadeInstruction?.createdBy ?? "Unknown";
            }

          }
          if (snapshot.hasData) {
            return  Card(
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
                            Text("Created By: ${communityMadeInstruction?.createdBy}"),
                            const Spacer(),
                            Visibility(
                              visible: communityMadeInstruction?.sponsored ?? false,
                              child: const Text("Sponsored",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold)
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text('${communityMadeInstruction?.title}',
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600
                        ),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(communityMadeInstruction?.description ?? "description",
                          style: const TextStyle(
                            fontSize: 15,
                          ),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(communityMadeInstruction?.instructions ?? "Instructions",
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black54
                          ),),
                      ),

                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.05,
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: ElevatedButton(

                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  backgroundColor: Colors.black,
                                ),
                                onPressed: () async {
                                  var link = await DynamicLinkService().createDynamicLink(communityMadeInstruction?.id ?? 1);
                                  Share.share(link.toString());

                                },
                                child: const Text("Share Instructions"),

                              ),
                            ),
                            const Spacer()
                          ],
                        ),
                      ),
                      Text("Tags: ${communityMadeInstruction?.tags}",
                        style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54
                        ),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Row(
                          children: [
                            const Text("Difficulty: "),
                            StarDifficulty(difficulty: communityMadeInstruction?.difficulty as int),
                            const Spacer(),
                            const Text("Time to Complete: 30 minutes"),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          GetIcon(category: communityMadeInstruction?.category ?? "Other"),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                            child: Text("Category: ${communityMadeInstruction?.category}"),
                          ),
                          const Spacer(),
                          const Icon(Icons.favorite_border, color: Colors.red,),
                          Text((communityMadeInstruction?.likes).toString()),
                          const Spacer(),
                          Text(dateTimeFormat(
                            //  "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
                            // "hh:mma MMMM dd, yyyy",
                              "MMMM dd, yyyy hh:mma",
                              DateTime.parse(communityMadeInstruction?.postCreatedAt ?? "Cannot retrieve time when post was created")))
                        ],
                      ),


                    ],
                  ),
                )
            );
          } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
          }
          return const Text('Something went wrong');
        },

      ),
    );
  }
}

//TODO Share posts button
