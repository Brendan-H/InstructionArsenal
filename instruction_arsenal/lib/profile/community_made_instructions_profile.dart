/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (community_made_instructions_profile.dart) Last Modified on 2/24/23, 5:44 PM
 *
 */

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/backend/models/community_made_instructions.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/community_made_instructions_info_page.dart';


class CommunityMadeInstructionsProfile extends StatefulWidget {
  const CommunityMadeInstructionsProfile({Key? key}) : super(key: key);



  @override
  State<CommunityMadeInstructionsProfile> createState() => _CommunityMadeInstructionsProfileState();
}



class _CommunityMadeInstructionsProfileState extends State<CommunityMadeInstructionsProfile> {

  Future<List<CommunityMadeInstructions>?> fetchCommunityMadeInstructions() async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var email = FirebaseAuth.instance.currentUser!.email;
    var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/communitymadeinstructions/createdbyexact/$email',
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
  }

  late Future<List<CommunityMadeInstructions>?> futureCommunityMadeInstructions;



  @override
  void initState() {
    super.initState();
    futureCommunityMadeInstructions = fetchCommunityMadeInstructions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white60,

        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Expanded(
                  child: FutureBuilder<List<CommunityMadeInstructions>?>(
                    future: futureCommunityMadeInstructions,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var communityMadeInstruction = snapshot.data![index];
                            return Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(
                                  communityMadeInstruction.title!.length > 100 ? '${communityMadeInstruction.title!.substring(0, 100)}...' : communityMadeInstruction.title ?? "Title",
                                  style: const TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 18,
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text(
                                    "Category: ${communityMadeInstruction.category}" ?? '',
                                    style: const TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommunityMadeInstructionsInfoPage(
                                          communityMadeInstructions: communityMadeInstruction,
                                        isMyPost: true,
                                    ),
                                  )
                                  );
                                },
                              ),
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const Text('Something went wrong');
                    },
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}