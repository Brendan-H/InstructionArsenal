import 'dart:async';

import 'package:awesome_select/awesome_select.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CommunityMadeInstructionsCategorySliver extends StatefulWidget {
  const CommunityMadeInstructionsCategorySliver({
    Key? key,
    this.onChanged,
    this.debounceTime,
  }) : super(key: key);
  final ValueChanged<String>? onChanged;
  final Duration? debounceTime;

  @override
  _CommunityMadeInstructionsCategorySliverState createState() =>
      _CommunityMadeInstructionsCategorySliverState();
}

class _CommunityMadeInstructionsCategorySliverState
    extends State<CommunityMadeInstructionsCategorySliver> {
  final StreamController<String> _categoryChangeStreamController =
  StreamController();
  late StreamSubscription _categoryChangesSubscription;
  List<S2Choice<String>> categoryChoiceOptions = [
    S2Choice<String>(value: 'Technology', title: 'Technology'),
    S2Choice<String>(value: 'Automotive', title: 'Automotive'),
    S2Choice<String>(value: 'Cooking', title: 'Cooking'),
    S2Choice<String>(value: 'Sports', title: 'Sports'),
    S2Choice<String>(value: 'Home', title: 'Home'),
    S2Choice<String>(value: 'Other', title: 'Other'),
  ];



  var categoryChoice = "Automotive";

  @override
  void initState() {
    _categoryChangesSubscription = _categoryChangeStreamController.stream
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
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: SmartSelect<String>.single(
        modalHeaderStyle: const S2ModalHeaderStyle(
          backgroundColor: Colors.black,
          textStyle: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),

        choiceStyle: const S2ChoiceStyle(
          color: Colors.black,
          titleStyle: TextStyle(
            fontSize: 20,
          ),
        ),
        onSelect: (selected, state) {
          print(categoryChoice);
          _categoryChangeStreamController.add;

        },
        modalType: S2ModalType.bottomSheet,
        title: 'Category',
        selectedValue: categoryChoice,
        choiceItems: categoryChoiceOptions,
        onChange: (state) => setState(() {
          categoryChoice = state.value;
        }),
      ),
    ),
    // child: Padding(
    //   padding: const EdgeInsets.all(16),
    //   child: TextField(
    //     decoration: const InputDecoration(
    //       prefixIcon: Icon(Icons.search),
    //       labelText: 'Search Instructions',
    //     ),
    //     onChanged: _textChangeStreamController.add,
    //   ),
    // ),
  );

  @override
  void dispose() {
    _categoryChangeStreamController.close();
   // _categoryChangeStreamController.cancel();
    super.dispose();
  }
}