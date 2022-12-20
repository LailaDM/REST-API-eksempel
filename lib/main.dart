import 'dart:collection';
import 'package:flutter/material.dart';
import 'RestApi.dart';
//import 'http_class.dart';
import 'user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// to set the root of app.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter REST Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'REST API Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Flutter REST API Implementation"),
      ),
      body: _buildBody(context),
      // floatingActionButton: FloatingActionButton.extended(
      //  onPressed: () {},
      //  label: Icon(Icons.cancel),
      //  backgroundColor: Colors.purple,
      // ),
    );
  }

  // build list view & manage states
  FutureBuilder<List<User>> _buildBody(BuildContext context) {
    final RestApi restApi = RestApi();
    return FutureBuilder<List<User>>(
      future: restApi.getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final List<User>? posts = snapshot.data;
          return _buildPosts(context, posts!);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  // build list view & its tile
  ListView _buildPosts(BuildContext context, List<User> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(posts[index].completed.toString()),
          ),
        );
      },
    );
  }
}
