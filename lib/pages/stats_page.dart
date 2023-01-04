import 'package:flutter/material.dart';

import '../theme/colors.dart';

class StatsPage extends StatefulWidget {
  const StatsPage({Key? key}) : super(key: key);

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(" Working"),
      ),
    );
  }
}


// class StatsPage extends StatefulWidget {
//   const StatsPage({super.key});
//
//   @override
//   _StatsPageState createState() => _StatsPageState();
// }
//
// class _StatsPageState extends State<StatsPage> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children:  [
//             // Center(
//             //   child: Text(
//             //     "Updating Soon !!",
//             //     style: TextStyle(fontSize: 25, color: primary),
//             //   ),
//             // )
//             GridView(
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 3,
//               ),
//               primary: false,
//               padding: const EdgeInsets.all(20),
//               children: <Widget>[
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text("Tile 1"),
//                   color: Colors.orange[200],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text("Tile 2"),
//                   color: Colors.green[200],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text("Tile 3"),
//                   color: Colors.red[200],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text("Tile 4"),
//                   color: Colors.purple[200],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text("Tile 5"),
//                   color: Colors.blueGrey[200],
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(8),
//                   child: const Text("Tile 6"),
//                   color: Colors.yellow[200],
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
