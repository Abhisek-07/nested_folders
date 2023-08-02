import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/nested': (context) => NestedScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<String> screens = [];

  void _addScreen(String name) {
    setState(() {
      screens.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Screens'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: screens.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(screens[index]),
              onTap: () {
                Navigator.pushNamed(context, '/nested');
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String screenName = '';

        return AlertDialog(
          title: Text('Enter Screen Name'),
          content: TextField(
            onChanged: (value) {
              screenName = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addScreen(screenName);
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}

class NestedScreen extends StatefulWidget {
  @override
  _NestedScreenState createState() => _NestedScreenState();
}

class _NestedScreenState extends State<NestedScreen> {
  List<String> nestedScreens = [];

  void _addNestedScreen(String name) {
    setState(() {
      nestedScreens.add(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nested Screens'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: nestedScreens.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(nestedScreens[index]),
              onTap: () {
                Navigator.pushNamed(context, '/nested');
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNestedDialog();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNestedDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String screenName = '';

        return AlertDialog(
          title: Text('Enter Screen Name'),
          content: TextField(
            onChanged: (value) {
              screenName = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                _addNestedScreen(screenName);
                Navigator.pop(context);
              },
              child: Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
