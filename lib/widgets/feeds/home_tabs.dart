import 'package:dev_house/widgets/groups/customTile_G.dart';
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
  bool image = false;

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

  static const List<Tab> _tabs = <Tab>[
    Tab(text: 'Discussions'),
    Tab(text: 'Groups'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: SafeArea(
        child: Scaffold(
          body: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, _) {
              return [
                SliverAppBar(
                  pinned: true,
                  title: TabBar(
                    controller: _tabController,
                    tabs: _tabs,
                    unselectedLabelColor: Colors.grey.shade700,
                    labelColor: Colors.black,
                    indicatorColor: Colors.black,
                    // onTap: (int ind) {
                    //   setState(() {
                    //     selectedTabIndex = ind;
                    //   });
                    //   widget.onTabIndexChange(selectedTabIndex);
                    // },
                  ),
                  // backgroundColor: Colors.white,
                )
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: [
                RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: const Column(
                    children: [],
                  ),
                ),
                SingleChildScrollView(
                  child: RefreshIndicator(
                    onRefresh: _handleRefresh,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(
                            left: 4.0,
                            right: 4.0,
                            bottom: 4.70,
                          ),
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 13,
                                height: 35,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedButtonIndexg = 0;
                                  });
                                  _handleRefresh();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedButtonIndexg == 0
                                      ? const Color.fromARGB(255, 211, 233, 251)
                                      : Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  minimumSize: const Size(0, 35),
                                  elevation: 0, // Remove the elevation shadow
                                ),
                                child: const Text(
                                  'All groups',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 13.5),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    selectedButtonIndexg = 1;
                                  });
                                  _handleRefresh();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: selectedButtonIndexg == 1
                                      ? const Color.fromARGB(255, 211, 233, 251)
                                      : Colors.grey.shade200,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  minimumSize: const Size(0, 35),
                                  elevation: 0, // Remove the elevation shadow
                                ),
                                child: const Text(
                                  'My groups',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        selectedButtonIndexg == 0
                            ? SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: 15,
                                  itemBuilder: (context, index) {
                                    return CustomTile_G(
                                      title: 'Design',
                                      subtitle: '34554' " members",
                                      description:
                                          'Talk, vibe, relax, repeat. Do whatever you',
                                      onPressed: () {
                                        // Action to perform when button is pressed
                                      },
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: ListView.builder(
                                  itemCount: 4,
                                  itemBuilder: (context, index) {
                                    return CustomTile_G(
                                      title: 'Finance',
                                      subtitle: '2354' " members",
                                      description:
                                          'Talk, vibe, relax, repeat. Do whatever you',
                                      onPressed: () {
                                        // Action to perform when button is pressed
                                      },
                                    );
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}