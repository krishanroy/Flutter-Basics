import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_basics/user.dart';
import 'package:http/http.dart' as http;

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: FutureBuilder<Iterable<User>>(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot<Iterable<User>> snapshot) {
          if (snapshot.hasData) {
            /// It is usually more efficient to create children on demand using
            /// [ListView.builder] because it will create the widget children lazily as necessary.
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Theme.of(context).colorScheme.outline),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12),
                    ),
                  ),
                  child: SizedBox(
                    width: 300,
                    height: 200,
                    child: Center(
                      child: Text(
                        snapshot.data!.toList()[index].name.toString(),
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Text('Something went wrong');
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

Future<Iterable<User>> _getUsers() async {
  final url = Uri.http('jsonplaceholder.typicode.com', '/users');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return (jsonDecode(response.body) as Iterable).map((user) => User.fromJson(user));
  } else {
    throw Exception('Failed to load uesrs');
  }
}
