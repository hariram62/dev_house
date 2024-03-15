import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class FeedPage extends StatefulWidget {
  final void Function(int) onTabIndexChange;

  const FeedPage({Key? key, required this.onTabIndexChange}) : super(key: key);
  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with SingleTickerProviderStateMixin {
  int selectedButtonIndex = 0;
  int selectedButtonIndexg = 0;
  int selectedTabIndex = 0;
  late TabController _tabController;

  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {});
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {});
      }
    });
  }

  void _handleTabChange() {
    setState(() {
      selectedTabIndex = _tabController.index;
    });
    widget.onTabIndexChange(selectedTabIndex);
  }

  Future<void> _handleRefresh() async {
    // Implement your refresh logic here
    // For example, you can fetch new data from a network or update existing data
    await Future.delayed(const Duration(seconds: 2)); // Simulating a delay
    setState(() {
      // Update state after refresh
    });
  }

  bool ti = false;
  String text = "dfdsdsdvsdvsdvsbjvbsdjbvjsbvjsbdjvdssdvsdsdbsvjbd";
  String imageUrl = "assets/images/link.jpeg";
  bool likeb = false;
  int like = 0;
  bool showFullPost = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        child: ListView.builder(
          itemCount: 3, // Assuming you have 3 posts
          itemBuilder: (context, index) {
            return Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        //bar
                        padding: const EdgeInsets.only(
                          top: 10,
                          left: 12,
                          right: 8,
                          bottom: 10,
                        ), //bar size
                        color: Colors.white,

                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Colors.grey[200],
                            ),
                            const SizedBox(width: 12),
                            const Text(
                              'Username',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            Transform.translate(
                              offset: const Offset(-10, 0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20.0),
                                    border: Border.all(
                                      color: Colors.grey.shade300,
                                    )),
                                constraints: const BoxConstraints(
                                  minWidth: 0,
                                  minHeight: 32,
                                ),
                                child: const Center(
                                  child: Text(
                                    'Student',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.black,
                                      // fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      color: Colors.grey[100],
                      padding: const EdgeInsets.only(
                        top: 14.0,
                        left: 13.5,
                        right: 13.5,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                showFullPost = !showFullPost;
                              });
                            },
                            child: Text(
                              showFullPost ? text : _getDisplayFullPost(),
                              style: const TextStyle(fontSize: 14.5),
                            ),
                          ),
                          const SizedBox(height: 14),
                        ],
                      ),
                    ),
                    if (ti == false) Image.asset(imageUrl),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(
                    top: 11,
                    left: 12.0,
                    right: 12.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            likeb = !likeb;
                          });
                        },
                        child: likeb
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 22,
                              )
                            : const Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                                size: 22,
                              ),
                      ),
                      const SizedBox(width: 6),
                      const Text("Like"),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Divider(
                  height: 1,
                  thickness: 5,
                  color: Colors.grey.shade200,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String _getDisplayFullPost() {
    const maxCharactersToShow = 300;
    if (text.length <= maxCharactersToShow) {
      return text;
    } else {
      return '${text.substring(0, maxCharactersToShow)}... see more';
    }
  }
}
