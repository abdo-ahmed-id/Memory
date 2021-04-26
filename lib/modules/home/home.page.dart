import 'dart:io';

import 'package:builders/builders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:memories/data/models/memories.dart';
import 'package:memories/helpers/routes.dart';
import 'package:memories/modules/app/bloc/app.bloc.dart';
import 'package:memories/modules/app/bloc/app.state.dart';
import 'package:memories/modules/home/dialog.widget.dart';

class HomePage extends StatelessWidget {
  final AppBloc appBloc = Modular.get<AppBloc>();

  @override
  Widget build(BuildContext context) {
    List<Memories> listMemories = appBloc.state.memories;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Memories'),
        centerTitle: true,
        actions: [
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                appBloc.clearData();
              }),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<AppBloc, AppState>(
          cubit: appBloc,
          builder: (_, state) {
            if (state.memories.isEmpty) {
              return Center(child: Text('Add Some Memories'));
            }
            return Column(
              children: groupListItem(context, state.memoriesGroup),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print(appBloc.state.memoriesGroup);
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: DialogWidget(),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  List<Widget> groupListItem(
      BuildContext context, Map<String, List<Memories>> memoriesGroup) {
    List<Widget> list = <Widget>[];
    memoriesGroup.forEach((key, value) {
      print("Date $key");
      list.add(Text(key));
      list.add(Divider());
      Wrap wrap = Wrap(
        children: value.map((e) => SizedBox(child: item(e, context))).toList(),
      );
      list.add(wrap);
    });
    return list;
  }
}

List<Widget> listItem(
  Map<String, List<Memories>> memoryGroup,
  BuildContext context,
) {
  List<Widget> list = [];
  memoryGroup.forEach((key, value) {
    list.add(Text(key));
    list.add(Divider());
    value.forEach((memories) => list.add(item(memories, context)));
  });
  return list;
}

Widget item(
  Memories memories,
  BuildContext context,
) {
  num size = (MediaQuery.of(context).size.width / 2) - 20;
  return Container(
    width: size,
    height: size,
    padding: EdgeInsets.all(5),
    child: Stack(
      children: [
        InkWell(
          onTap: () {
            print(" this day${memories.day}");
            Modular.to.pushNamed(AppRoutes.details, arguments: memories);
          },
          child: Container(
            child: Hero(
              tag: 'flutter',
              child: Image.file(
                new File(memories.image),
                fit: BoxFit.cover,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => DialogWidget(
                  memories: memories,
                ),
              );
            })
      ],
    ),
  );
}
