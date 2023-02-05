import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/community_made_instructions_info_page.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/dynamic_link_info_page.dart';

import '../backend/models/community_made_instructions.dart';

class DynamicLinkService {

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = initialLink?.link;

      if (deepLink != null) {
          String? id = deepLink.queryParameters["id"] ?? "1";


          await Navigator.of(context).push(MaterialPageRoute(builder: (context) => CommunityMadeInstructionsDynamicLinkInfoPage(
            id: id,
            isMyPost: false
               )
             )
           );

      }

      // FirebaseDynamicLinks.instance.onLink(onSuccess: (PendingDynamicLinkData dynamicLink) async {
      //   Navigator.of(context).push(MaterialPageRoute(builder: (context) => TestScreen()));
      // });


    } catch (e) {
      print(e.toString());
    }
  }

  Future<Uri> createDynamicLink(num id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://instructionarsenal.brendanharan.com/go/',
      link: Uri.parse('https://instructionarsenal.brendanharan.com/go/?id=$id'),
      androidParameters: const AndroidParameters(
        packageName: 'com.brendanharan.instructionarsenal',
        minimumVersion: 1,
      ),
      // iosParameters: IosParameters(
      //   bundleId: 'your_ios_bundle_identifier',
      //   minimumVersion: '1',
      //   appStoreId: 'your_app_store_id',
      // ),
    );
    var dynamicUrl = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final Uri shortUrl = dynamicUrl.shortUrl;
    return shortUrl;
  }

}