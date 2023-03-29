/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (CommunityMadeInstructionsSearchSliver.dart) Last Modified on 2/21/23, 7:15 PM
 *
 */

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommunityMadeInstructionsSearchSliver extends StatefulWidget {
  const CommunityMadeInstructionsSearchSliver({
    Key? key,
    this.onChanged,
    this.debounceTime,
  }) : super(key: key);
  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;

  @override
  _CommunityMadeInstructionsSearchSliverState createState() =>
      _CommunityMadeInstructionsSearchSliverState();
}

class _CommunityMadeInstructionsSearchSliverState
    extends State<CommunityMadeInstructionsSearchSliver> {
  final StreamController<String> _textChangeStreamController =
  StreamController();
  late StreamSubscription _textChangesSubscription;

  @override
  void initState() {
    _textChangesSubscription = _textChangeStreamController.stream
        .debounceTime(
      widget.debounceTime ?? const Duration(seconds: 1),
    )
        .distinct()
        .listen((text) {
      final onChanged = widget.onChanged;
      if (onChanged != null) {
        onChanged(text);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.search),
          labelText: 'Search Instructions',
        ),
        onChanged: _textChangeStreamController.add,
      ),
    ),
  );

  @override
  void dispose() {
    _textChangeStreamController.close();
    _textChangesSubscription.cancel();
    super.dispose();
  }
}