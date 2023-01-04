import 'package:flutter/material.dart';


class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  @override
  _GridViewPageState createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:  [
            GridView.count(
              crossAxisCount: 1,
              primary: false,
              padding: const EdgeInsets.all(20),
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Tile 1"),
                  color: Colors.orange[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Tile 2"),
                  color: Colors.green[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Tile 3"),
                  color: Colors.red[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Tile 4"),
                  color: Colors.purple[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Tile 5"),
                  color: Colors.blueGrey[200],
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  child: const Text("Tile 6"),
                  color: Colors.yellow[200],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
