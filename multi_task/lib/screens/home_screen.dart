import 'package:flutter/material.dart';
import 'package:multi_task/models/tools.dart';
import 'package:multi_task/widgets/list_tools.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Tools> list = [];
  @override
  Widget build(BuildContext context) {
    list.clear();
    list.add(Tools(image: 'images/currency_convertor.png', name: 'Currency Convertor', location: HomeScreen()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi Tasker'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle navigation to home
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                // Handle navigation to profile
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle navigation to settings
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle logout
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: list.length,
          itemBuilder: (context,index){
            return ListTools(tools: list[index],);
          }
      ),
    );
  }
}
