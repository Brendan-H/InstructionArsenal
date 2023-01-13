import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/backend/models/community_made_instructions.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../homepage.dart';

class CommunityMadeInstructionsInfoPage extends StatefulWidget {

  final CommunityMadeInstructions communityMadeInstructions;
  const CommunityMadeInstructionsInfoPage({Key? key, required this.communityMadeInstructions}) : super(key: key);

  @override
  State<CommunityMadeInstructionsInfoPage> createState() => _CommunityMadeInstructionsInfoPageState();
}

class _CommunityMadeInstructionsInfoPageState extends State<CommunityMadeInstructionsInfoPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();



  String getCreatedBy() {
    if (FirebaseAuth.instance.currentUser!.email == widget.communityMadeInstructions.createdBy) {
      return "You";
    }
    else {
      return widget.communityMadeInstructions.createdBy ?? "Unknown";
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
            "http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/${widget.communityMadeInstructions.id}",
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

    final createdAtDate = dateTimeFormat(
      //  "yyyy-MM-dd'T'HH:mm:ss.SSSZ",
      // "hh:mma MMMM dd, yyyy",
        "MMMM dd, yyyy hh:mma",
        DateTime.parse(widget.communityMadeInstructions.postCreatedAt ?? "Cannot retrieve time when post was created"));





    return Scaffold(
      appBar: AppBar(
        actions: [
          Visibility(
       //     visible: widget.isMyPost,
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
              color: Colors.white,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(widget.communityMadeInstructions.title ?? "Cannot retrieve title",
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Text(widget.communityMadeInstructions.description ?? "Cannot retrieve title",
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
