import 'package:flutter/material.dart';
import 'package:smart_attendence_app/pages/tab_cards/grid_view.dart';

import '../theme/colors.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({Key? key}) : super(key: key);

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(" Working"),
      ),
    );
  }
}




// class BudgetPage extends StatefulWidget {
//   const BudgetPage({super.key});
//
//   @override
//   _BudgetPageState createState() => _BudgetPageState();
// }
//
// class _BudgetPageState extends State<BudgetPage> with TickerProviderStateMixin{
//   late TabController tabController = TabController(length: 2,vsync: this);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         appBar: AppBar(
//           title: Text("Stuffs",),
//         ),
//         body: SafeArea(
//             child: Column(
//                 children: [
//                   const SizedBox(height: 18),
//                   Container(
//                     height: 35,
//                     decoration: const BoxDecoration(
//                       border: Border(
//                         bottom: BorderSide(
//                           color: Colors.transparent,
//                           width: 3,
//                         ),
//                       ),
//                     ),
//                     child:
//                     TabBar(
//                       onTap: (index) {
//                         tabController.index = index;
//                       },
//                       controller: tabController,
//                       indicatorSize: TabBarIndicatorSize.tab,
//                       indicatorColor: Colors.blue,
//                       labelStyle: const TextStyle(
//                           color: Colors.blue, fontSize: 16),
//                       unselectedLabelColor: Colors.black,
//                       labelColor: Colors.blue,
//                       indicator: const UnderlineTabIndicator(
//                         insets: EdgeInsets.zero,
//                         borderSide: BorderSide(color: Colors.red, width: 3),
//                       ),
//                       tabs: const [
//                         Tab(
//                           text: "Tab 1",
//                         ),
//                         Tab(
//                           text: "Tab 2",
//                         ),
//                       ],
//                     ),),
//                   Container(
//                     width: double.infinity,
//                     height: 3,
//                     transform: Matrix4.translationValues(0, -6, 0),
//                     decoration: BoxDecoration(
//                       color: Colors.red,
//                       borderRadius: BorderRadius.circular(50),
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 12,
//                   ),
//                   Expanded(
//                     child: TabBarView(
//                       controller: tabController,
//                       children: const [
//                         // AppointmentCard(),
//                         // InquiryCard()
//                         GridViewPage(),
//                         GridViewPage()
//                       ],
//                     ),
//                   ),
//
//                 ])
//         )
//     );
//
//   }
// }

