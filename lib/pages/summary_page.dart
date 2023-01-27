import 'package:flutter/material.dart';
import 'package:smart_attendence_app/pages/tab_cards/events_cards.dart';
import 'package:smart_attendence_app/pages/tab_cards/leaves_cards.dart';
import 'package:smart_attendence_app/pages/tab_cards/request_leave_cards.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({
    super.key,
    required this.pageIndex,
  });

  final int pageIndex;

  @override
  _SummaryPageState createState() => _SummaryPageState();
}

class _SummaryPageState extends State<SummaryPage>
    with TickerProviderStateMixin {
  late TabController tabController =
      TabController(length: 3, vsync: this, initialIndex: widget.pageIndex);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white60,
        appBar: AppBar(
          title: const Text("Summary"),
        ),
        body: SafeArea(
            child: Column(children: [
          Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white, boxShadow: kElevationToShadow[4]),
            child: TabBar(
              onTap: (index) {
                tabController.index = index;
              },
              controller: tabController,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.blue,
              labelStyle: const TextStyle(color: Colors.blue, fontSize: 16),
              unselectedLabelColor: Colors.black,
              labelColor: Colors.blue,
              indicator: const UnderlineTabIndicator(
                insets: EdgeInsets.zero,
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
              tabs: const [
                Tab(
                  text: "Leaves",
                ),
                Tab(
                  text: "Request",
                ),
                Tab(
                  text: "Events",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [
                // AppointmentCard(),
                // InquiryCard()
                LeavesCards(),
                RequestLeaveCards(),
                EventsCards()
              ],
            ),
          ),
        ])));
  }
}
