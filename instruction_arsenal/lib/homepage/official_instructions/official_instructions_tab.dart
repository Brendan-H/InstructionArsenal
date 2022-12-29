import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class OfficialInstructionsTab extends StatefulWidget {
  const OfficialInstructionsTab({Key? key}) : super(key: key);

  @override
  State<OfficialInstructionsTab> createState() => _OfficialInstructionsTabState();
}

class _OfficialInstructionsTabState extends State<OfficialInstructionsTab> {
  final TextEditingController _titleController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      body: LayoutBuilder(
        builder: (context, constraints) => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.175,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.search),
                          //search box
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Search for official instructions',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: ElevatedButton(
                          onPressed: () async {
                            var firebaseid = await FirebaseAuth.instance.currentUser?.getIdToken();
                            print(firebaseid);
                            try {
                           var dio = Dio();
                              final response = await dio.get(
                                "http://10.0.2.2:8080/api/v1/instructions/officialinstructions/title/${_titleController.text}",
                                options: Options(
                                    headers: {
                                      'Authorization': 'Bearer $firebaseid',
                                    }
                                ),

                                //TODO fix it not taking authorization header
                              );
                              print(response);
                            } catch (e) {
                              if (e is DioError) {
                                if (e.response != null) {
                                  print('Dio error!');
                                  print('STATUS: ${e.response?.statusCode}');
                                  print('DATA: ${e.response?.data}');
                                  print('HEADERS: ${e.response?.headers}');
                                } else {
                                  // Error due to setting up or sending the request
                                  print('Error sending request!');
                                  print(e.message);
                                }
                              }
                            print(" $e\n");
                            }
                          },
                          child: Text(
                          "Search"
                        ),
                        ),
                      )
                      //filters and other stuff
                    ],
                  ),
                )
              )

            ],
          ),
        ),
    )
    );
  }
}
//search where it brings you to a new page with results