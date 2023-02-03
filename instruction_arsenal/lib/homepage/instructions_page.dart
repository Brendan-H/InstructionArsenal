import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../backend/models/community_made_instructions.dart';
import 'homepage.dart';

/// id : 12 (doesnt need to be shown)
/// title : "2 How to change the tire on a car"
/// description : "This tutorial will show you the exact steps for safely replacing the tire on any car. It will be demonstrated on a 2017 Toyota Camry"
/// postCreatedAt : "2023-01-03T16:54:30.756846"
/// instructions : "Step 1: Park the car on a flat surface and turn off the engine. Make sure the car is in park and the parking brake is on. Step 2: Locate the jack and the lug wrench. Step 3: Remove the lug nuts from the tire. Step 4: Place the jack under the car and raise it until the tire is off the ground. Step 5: Remove the tire and replace it with the spare. Step 6: Replace the lug nuts and tighten them. Step 7: Lower the car and remove the jack. Step 8: Replace the lug wrench and jack in their original locations. Step 9: Turn on the car and drive away. Step 10: Go to a tire shop to get the flat tire fixed."
/// createdBy : "bjharan7@gmail.com"
/// category : "Automotive"
/// likes : 155
/// dislikes : 11
/// tags : "cars, tire, automotive, wheels, repair"
/// difficulty : 3
/// timeToComplete : "30 Minutes"
/// sponsored : true
/// company : "company"


class InstructionsPage extends StatefulWidget {
  final instructions;
  const InstructionsPage({Key? key, required this.instructions}) : super(key: key);

  @override
  State<InstructionsPage> createState() => _InstructionsPageState();
}

class _InstructionsPageState extends State<InstructionsPage> {
  String getCreatedBy() {
    if (FirebaseAuth.instance.currentUser!.email == widget.instructions.createdBy) {
      return "You";
    }
    else {
      return widget.instructions.createdBy ?? "Unknown";
    }

  }

  List getInfo() {
    var instructionInfo = <List>[];
    instructionInfo.add(["Created By", getCreatedBy()]);
    instructionInfo.add(["Category", widget.instructions.category]);
    instructionInfo.add(["Likes", widget.instructions.likes.toString()]);
    instructionInfo.add(["Dislikes", widget.instructions.dislikes.toString()]);
    instructionInfo.add(["Tags", widget.instructions.tags]);
    instructionInfo.add(["Difficulty", widget.instructions.difficulty.toString()]);
    instructionInfo.add(["Time to Complete", widget.instructions.timeToComplete]);
    instructionInfo.add(["Sponsored", widget.instructions.sponsored.toString()]);
    instructionInfo.add(["Company", widget.instructions.company]);
    instructionInfo.add(["Created At", widget.instructions.postCreatedAt.toString()]);
    instructionInfo.add(["Title", widget.instructions.title]);
    instructionInfo.add(["Description", widget.instructions.description]);
    instructionInfo.add(["Instructions", widget.instructions.instructions]);

    return instructionInfo;
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
            "http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/${widget.instructions.id}",
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
        DateTime.parse(widget.instructions.postCreatedAt ?? "Cannot retrieve time when post was created"));




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
            Center(
              child: Text(
                widget.instructions.title ?? "Unknown",
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.instructions.description ?? "Unknown",
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Created by: " + getCreatedBy(),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Created at: " + createdAtDate,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Category: " + (widget.instructions.category ?? "Unknown"),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Difficulty: " + (widget.instructions.difficulty ?? "Unknown"),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Time to complete: " + (widget.instructions.timeToComplete ?? "Unknown"),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Tags: " + (widget.instructions.tags ?? "Unknown"),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  widget.instructions.instructions ?? "Unknown",
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
