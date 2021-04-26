import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:memories/data/models/memories.dart';
import 'package:memories/modules/app/bloc/app.bloc.dart';

class DetailsPage extends StatelessWidget {
  AppBloc appBloc = Modular.get<AppBloc>();
  final Memories memories;

  DetailsPage({this.memories});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Memory Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(memories.day.toString().split(" ").first),
              Hero(
                tag: 'flutter',
                child: Image.file(
                  new File(memories.image),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                memories.description ?? '',
                textAlign: TextAlign.start,
                softWrap: true,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () {
          appBloc.deleteMemory(memories);
          Modular.to.pop();
        },
      ),
    );
  }
}
