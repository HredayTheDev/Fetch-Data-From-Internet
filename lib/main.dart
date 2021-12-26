import 'dart:async';
import 'dart:convert';
import 'package:fetch_data_from_internet/welcome.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

Future<List<Data>> fetchData() async {
  final response = await http
      .get(Uri.parse('http://192.168.0.121:9010/api/getdocnurserlist'));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((data) => new Data.fromJson(data)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

class Data {
  

  final String firstName;
  final String lastName;
  final String userName;
  final String photo;

  
  Data(
      {required this.firstName,
      required this.lastName,
      required this.userName,
      required this.photo});

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      firstName: json['FirstName'],
      lastName: json['LastName'],
      userName: json['userName'],
      photo: json['Photo'],
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
 

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<List<Data>> futureData;

  @override
  void initState() {
    super.initState();
    futureData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter API and ListView Example',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter ListView'),
        ),
        body: Center(
          child: FutureBuilder<List<Data>>(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Data>? data = snapshot.data;
                return ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Welcome(
                                          image: data[index].photo,
                                          id: index,
                                          fName: data[index].firstName,
                                          lName: data[index].lastName)));
                            },
                            leading: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(data[index].photo),
                            ),
                            title: Text(
                              data[index].firstName,
                            ),
                            subtitle: Text(data[index].lastName),
                          ),
                        ),
                      );

                     
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
             
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
