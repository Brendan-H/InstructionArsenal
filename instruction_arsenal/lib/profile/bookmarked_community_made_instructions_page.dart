/*
 * Copyright (c) 2023 by Brendan Haran, All Rights Reserved.
 * Use of this file or any of its contents is strictly prohibited without prior written permission from Brendan Haran.
 * Current File (bookmarked_community_made_instructions_page.dart) Last Modified on 4/7/23, 11:14 AM
 *
 */
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../backend/models/community_made_instructions.dart';
import '../homepage/community_made_instructions/community_made_instructions_info_page.dart';
import '../homepage/homepage.dart';

class BookmarkedCommunityMadeInstructionsPage extends StatefulWidget {
  const BookmarkedCommunityMadeInstructionsPage({Key? key}) : super(key: key);

  @override
  State<BookmarkedCommunityMadeInstructionsPage> createState() => _BookmarkedCommunityMadeInstructionsPageState();
}

class _BookmarkedCommunityMadeInstructionsPageState extends State<BookmarkedCommunityMadeInstructionsPage> {
  late PagingController<int, CommunityMadeInstructions>
  _pagingController; // paging controller for infinite scroll pagination
  late Database _db;

  // Connect to the database and set up the paging controller
  @override
  void initState() {
    super.initState();
    _initDb();
    _pagingController =
        PagingController(firstPageKey: 0); // first page key is 0
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
  }

  // Dispose of the database connection and paging controller
  @override
  void dispose() {
    _db.close();
    _pagingController.dispose();
    super.dispose();
  }

  // Connect to the database and set the initial items for the paging controller
  Future<void> _initDb() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'my_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE bookmarks(id INTEGER PRIMARY KEY, '
              'title TEXT, '
              'description TEXT, '
              'postCreatedAt TEXT, '
              'instructions TEXT, '
              'createdBy TEXT, '
              'category TEXT, '
              'likes INTEGER, '
              'tags TEXT, '
              'difficulty REAL, '
              'timeToComplete TEXT, '
              'sponsored INTEGER)',
        );
      },
      version: 1,
    );
    final items = await _getItems(0);
    if (items.isNotEmpty) {
      _pagingController.appendLastPage(items);
    }
  }
  Future<void> _fetchPage(int pageKey) async {
    try {
      final items = await _getItems(pageKey);
      final isLastPage = items.isEmpty;
      if (isLastPage) {
        _pagingController.appendLastPage(items);
      } else {
        final nextPageKey = pageKey + items.length;
        _pagingController.appendPage(items, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }
  Future<List<CommunityMadeInstructions>> _getItems(int offset) async {
    final List<Map<String, dynamic>> maps = await _db.query(
      'bookmarks',
      limit: 10,
      offset: offset,
    );

    return List.generate(maps.length, (i) {
      return CommunityMadeInstructions(
        id: maps[i]['id'],
        title: maps[i]['title'],
        description: maps[i]['description'],
        postCreatedAt: maps[i]['postCreatedAt'],
        instructions: maps[i]['instructions'],
        createdBy: maps[i]['createdBy'],
        category: maps[i]['category'],
        likes: maps[i]['likes'],
        tags: maps[i]['tags'],
        difficulty: maps[i]['difficulty'],
        timeToComplete: maps[i]['timeToComplete'],
        sponsored: maps[i]['sponsored'] == 1,
      );
    });
  }
  Future<void> _deleteBookmark(int id) async {
    await _db.delete(
      'bookmarks',
      where: 'id = ?',
      whereArgs: [id],
    );
    setState(() {});
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
        title: const Text('Bookmarked Instructions',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: PagedListView<int, CommunityMadeInstructions>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<CommunityMadeInstructions>(
          firstPageErrorIndicatorBuilder: (context) => Column(
            children: [
              Spacer(),
              const Text("An error occurred. Please press the retry button."),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.075,
                  width: MediaQuery.of(context).size.width * .7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                    onPressed: () => _pagingController.refresh(),
                    child: const Text('Retry', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
              Spacer(),
            ],
          ),
          itemBuilder: (context, item, index) {
            return Card(
              elevation: 2,
              child: ListTile(
                title: Text(
                  item.title!.length > 100 ? '${item.title!.substring(0, 100)}...' : item.title ?? "Title",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                  ),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  child: Text(
                    "Category: ${item.category}" ?? '',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 15,
                    ),
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {
                    _deleteBookmark(item.id ?? 0);
                    _pagingController.refresh();
                    },
                  icon: Icon(Icons.delete),
                  
                ),
                onTap: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //       builder: (context) => CommunityMadeInstructionsInfoPage(
                  //         communityMadeInstructions: item,
                  //         isMyPost: true,
                  //       ),
                  //     )
                  // );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

