// ignore_for_file: must_be_immutable

import 'package:dictapp/words.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

  Words word ;
  DetailPage({super.key, required this.word});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              widget.word.english,
              style:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 40,color: Colors.teal),
            ),
            Text(
              widget.word.turkhis,
              style:
              const TextStyle(fontWeight: FontWeight.bold,fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
