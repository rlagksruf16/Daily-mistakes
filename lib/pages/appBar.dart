import 'package:flutter/material.dart';


class BottomMenuAppBar extends StatefulWidget {
  @override
  _BottomMenuAppBarState createState() => _BottomMenuAppBarState();
}

class _BottomMenuAppBarState extends State<BottomMenuAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Bottom App Bar')),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {},
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.show_chart, size: 30.0, color: Colors.grey),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.calendar_today, size: 30.0, color: Colors.grey),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
