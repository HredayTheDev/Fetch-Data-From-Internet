import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  final String image;
  final int id;
  final String fName;
  final String lName;

  const Welcome(
      {required this.image,
      required this.id,
      required this.fName,
      required this.lName});

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Appbar"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(widget.image),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text("${widget.id}"),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(widget.fName),
              const SizedBox(
                height: 20,
              ),
              Text(widget.lName),
            ],
          ),
        ));
  }
}
