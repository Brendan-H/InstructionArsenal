import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/homepage.dart';
import 'package:instruction_arsenal/homepage/official_instructions/official_instructions_info_page.dart';

import '../../backend/models/official_instructions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);



  @override
  State<ProfilePage> createState() => _ProfilePageState();
}



class _ProfilePageState extends State<ProfilePage> {

  Future<List<OfficialInstructions>?> fetchOfficialInstructions() async {
    var idToken = await FirebaseAuth.instance.currentUser!.getIdToken();
    var dio = Dio();
    var email = FirebaseAuth.instance.currentUser!.email;
    var response = await dio.get('http://10.0.2.2:8080/api/v1/instructions/officialinstructions/createdby/$email',
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



  @override
  void initState() {
    super.initState();
    futureOfficialInstructions = fetchOfficialInstructions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white60,
      appBar: AppBar(
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
        centerTitle: true,
        backgroundColor: Colors.white,
        title: const Text('Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20,),
              const Text(
                "Your Instructions:",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OfficialInstructionsInfoPage(
                                      isMyPost: true,
                                      officialInstructions: officialInstruction,
                                    ),
                                  ),
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