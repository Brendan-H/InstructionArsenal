
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../backend/models/official_instructions.dart';


class OfficialInstructionsTab extends StatefulWidget {
  const OfficialInstructionsTab({Key? key}) : super(key: key);

  @override
  State<OfficialInstructionsTab> createState() => _OfficialInstructionsTabState();
}

class _OfficialInstructionsTabState extends State<OfficialInstructionsTab> {
  final TextEditingController _titleController = TextEditingController();

  Future<List<OfficialInstructions>?> fetchOfficialInstructions() async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/officialinstructions/1',
        options: Options(
          headers: {
            'Authorization': "Bearer $idToken",
          },
        ));

    if (response.statusCode == 200) {
      var officialInstructions = <OfficialInstructions>[];
      for (var officialInstructionsJson in response.data) {
        officialInstructions.add(OfficialInstructions.fromJson(officialInstructionsJson));
      }
      print(officialInstructions);
      return officialInstructions;

    }
    else {
      if (response.statusCode == 404) {
        print('404');
      }
      throw Exception('An error occurred');
    }
  }

  late Future<List<OfficialInstructions>?> futureOfficialInstructions;

  bool _buttonPressed = false;

  @override
  void initState() {
    super.initState();
    futureOfficialInstructions = fetchOfficialInstructions();
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
                          const Icon(Icons.search),
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
                            setState(() {
                            _buttonPressed = !_buttonPressed;
                            });

                            print(firebaseid);
                           //  try {
                           // var dio = Dio();
                           //    final response = await dio.get(
                           //      "http://10.0.2.2:8080/api/v1/instructions/officialinstructions/title/${_titleController.text}",
                           //      options: Options(
                           //          headers: {
                           //            'Authorization': 'Bearer $firebaseid',
                           //          }
                           //      ),
                           //
                           //      //TODO fix it not taking authorization header
                           //    );
                           //    print(response);
                           //  } catch (e) {
                           //    if (e is DioError) {
                           //      if (e.response != null) {
                           //        print('Dio error!');
                           //        print('STATUS: ${e.response?.statusCode}');
                           //        print('DATA: ${e.response?.data}');
                           //        print('HEADERS: ${e.response?.headers}');
                           //      } else {
                           //        // Error due to setting up or sending the request
                           //        print('Error sending request!');
                           //        print(e.message);
                           //      }
                           //    }
                           //  print(" $e\n");
                           //  }
                          },
                          child: const Text(
                          "Search"
                        ),
                        ),
                      ),

                      //filters and other stuff
                    ],
                  ),
                )
              ),
              Visibility(
                  visible: _buttonPressed,
                  child:  Expanded(
                      child: FutureBuilder<List<OfficialInstructions>?>(
                        future: futureOfficialInstructions,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                var officialInstruction = snapshot.data![index];
                                return Card(
                                  elevation: 2,
                                  child: ListTile(
                                    title: Text(
                                      officialInstruction.title!.length > 100 ? '${officialInstruction.title!.substring(0, 100)}...' : officialInstruction.title ?? "Title",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 18,
                                      ),
                                    ),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Text(
                                        "Company: ${officialInstruction.company}" ?? '',
                                        style: const TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                    onTap: () {
                                      null;
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => PostInfoPage(
                                      //       post: post,
                                      //     ),
                                      //   ),
                                      // );
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
              )

            ],
          ),
        ),
    )
    );
  }
}
//search where it brings you to a new page with results