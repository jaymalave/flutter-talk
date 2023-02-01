import 'dart:convert';
import 'package:flutter_api/components/post_card.dart';
import 'package:flutter_api/providers/posts_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_api/models/post_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PostsProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter API Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    context.read<PostsProvider>().fetchPosts().then((value) => {
          setState(() {
            isLoading = false;
          }),
        });
    print("from post provider");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<PostsProvider>().addPost().then((value) => {
                print(value.body),
                print(value.statusCode),
                setState(() {
                  context.read<PostsProvider>().fetchPosts();
                }),
              });
        },
        child: const Icon(Icons.add),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ListView.builder(
                    itemCount: context.watch<PostsProvider>().posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                          post: context.watch<PostsProvider>().posts[index]);
                    },
                    shrinkWrap: true,
                  ),
                ],
              ),
            ),
    );
  }
}
