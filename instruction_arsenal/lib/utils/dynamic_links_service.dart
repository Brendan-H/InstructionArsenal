/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (dynamic_links_service.dart) Last Modified on 2/24/23, 5:44 PM
 *
 */

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/dynamic_link_info_page.dart';


class DynamicLinkService {

  Future<void> retrieveDynamicLink(BuildContext context) async {
    try {
      final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
      final Uri? deepLink = initialLink?.link;

      if (deepLink != null) {
          String? id = deepLink.queryParameters["id"] ?? "1";
         // final strings = deepLink.path.split("id/");
          
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
      // uriPrefix: 'https://instructionarsenal.brendanharan.com/go/',
      // link: Uri.parse('https://instructionarsenal.brendanharan.com/go/id/$id'),
      uriPrefix: 'https://instructionarsenal.page.link',
      link: Uri.parse('https://instructionarsenal.page.link/id?id=$id'),
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
   // var dynamicUrl = await FirebaseDynamicLinks.instance.buildLink(parameters);
    final Uri shortUrl = dynamicUrl.shortUrl;
    return shortUrl;
   // return dynamicUrl;
  }

}