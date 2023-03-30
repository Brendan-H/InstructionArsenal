/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (main.dart) Last Modified on 2/24/23, 5:44 PM
 *
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:instruction_arsenal/firebase_options.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/community_made_instructions_info_page.dart';
import 'package:instruction_arsenal/homepage/community_made_instructions/dynamic_link_info_page.dart';
import 'package:instruction_arsenal/homepage/homepage.dart';
import 'package:instruction_arsenal/login_page/login_page.dart';
import 'package:instruction_arsenal/utils/dynamic_links_service.dart';
import 'package:instruction_arsenal/utils/theme.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:url_strategy/url_strategy.dart';

import 'backend/models/community_made_instructions.dart';


void main() async{
  setPathUrlStrategy();
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  final initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  runApp(MyApp(initialLink)
  );
}


final FirebaseAuth _auth = FirebaseAuth.instance;
Widget getLandingPage(initialLink) {
  return StreamBuilder<User?>(
    stream: _auth.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (initialLink != null) {
        DynamicLinkService.handleDynamicLinks(initialLink);
      }
      if (snapshot.hasData) {
        return const Homepage();
      }

      return const LoginPageWidget();
    },
  );
}

class MyApp extends StatefulWidget {
  final PendingDynamicLinkData? initialLink;
  const MyApp(this.initialLink, {Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    DynamicLinkService.handleDynamicLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      debugShowCheckedModeBanner: false,
      title: 'Instruction Arsenal',
      navigatorKey: DynamicLinkService.navigatorKey,
      theme: CustomTheme.lightTheme,
      home: getLandingPage(widget.initialLink),
      initialRoute: '/',
      routes: {
        '/communitymadeinstructionsinfopage': (context) {
          final CommunityMadeInstructions communityMadeInstructions =
          ModalRoute.of(context)!.settings.arguments as CommunityMadeInstructions;
          final bool isMyPost =
          ModalRoute.of(context)!.settings.arguments as bool;

          return CommunityMadeInstructionsInfoPage(
            communityMadeInstructions: communityMadeInstructions,
            isMyPost: isMyPost,
          );
        },
      },
    );
  }
}


