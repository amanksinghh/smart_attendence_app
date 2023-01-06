import 'package:flutter/material.dart';
import 'package:smart_attendence_app/pages/tab_cards/expenses_cards.dart';
import 'package:smart_attendence_app/pages/tab_cards/menu_cards.dart';

class CafeteriaPage extends StatefulWidget {
  const CafeteriaPage({super.key});

  @override
  _CafeteriaPageState createState() => _CafeteriaPageState();
}

class _CafeteriaPageState extends State<CafeteriaPage> with TickerProviderStateMixin{
  late TabController tabController = TabController(length: 2,vsync: this);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text("Cafeteria",),
        ),
        body: SafeArea(
            child: Column(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: kElevationToShadow[4]),
                    child:
                    TabBar(
                      onTap: (index) {
                        tabController.index = index;
                      },
                      controller: tabController,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.blue,
                      labelStyle: const TextStyle(
                          color: Colors.blue, fontSize: 16),
                      unselectedLabelColor: Colors.black,
                      labelColor: Colors.blue,
                      indicator: const UnderlineTabIndicator(
                        insets: EdgeInsets.zero,
                        borderSide: BorderSide(color: Colors.blue, width: 3),
                      ),
                      tabs: const [
                        Tab(
                          text: "Menu",
                        ),
                        Tab(
                          text: "Expenses",
                        ),
                      ],
                    ),),
                  Container(
                    width: double.infinity,
                    height: 3,
                    transform: Matrix4.translationValues(0, -6, 0),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(50),
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
                        MenuCards(),
                        ExpensesCards()
                      ],
                    ),
                  ),

                ])
        )
    );
  }
}

