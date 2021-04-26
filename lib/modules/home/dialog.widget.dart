import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memories/data/models/memories.dart';
import 'package:memories/modules/app/bloc/app.bloc.dart';

class DialogWidget extends StatefulWidget {
  final Memories memories;
  DialogWidget({this.memories});
  @override
  _DialogWidgetState createState() => _DialogWidgetState();
}

class _DialogWidgetState extends State<DialogWidget> {
  final AppBloc appBloc = Modular.get<AppBloc>();
  String description;

  DateTime day = DateTime.now();
  final picker = ImagePicker();
  String _image;

  Future getImage(ImageSource str) async {
    final pickedFile = await picker.getImage(source: str);
    setState(() {
      if (pickedFile != null) {
        _image = pickedFile.path;
      }
    });
    Modular.to.pop();
  }

  @override
  void initState() {
    _image = widget.memories?.image ?? null;
    description = widget.memories?.description ?? null;
    day = widget.memories?.day ?? day;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: Colors.teal[100],
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextButton(
                onPressed: () {
                  showImageDialog(context);
                },
                child: Text("AddImage"),
              ),
              _image != null
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(child: Image.file(new File(_image))),
                    )
                  : Text('No Selected Image'),
              TextFormField(
                initialValue: widget.memories?.description ?? '',
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Your Details Memory',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.teal),
                  ),
                ),
              ),
              CalendarDatePicker(
                firstDate: DateTime.now().subtract(Duration(days: 20)),
                initialDate: widget.memories?.day ?? DateTime.now(),
                lastDate: DateTime.now().add(
                  Duration(days: 365),
                ),
                onDateChanged: (date) {
                  day = date;
                },
              ),
              TextButton(
                onPressed: () {
                  print(description);
                  Memories newMemory = widget.memories ?? Memories();
                  newMemory.description = description;
                  newMemory.day = day;
                  newMemory.image = _image;
                  print('Day ${newMemory.day.toString()}');
                  appBloc.createOrUpdateMemory(newMemory);
                  Modular.to.pop();
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showImageDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  buildListTile(
                      icon: Icons.photo,
                      title: 'Gallery',
                      onTap: () {
                        getImage(ImageSource.gallery);
                      }),
                  buildListTile(
                      icon: Icons.camera_alt,
                      title: 'Camera',
                      onTap: () {
                        getImage(ImageSource.camera);
                      }),
                ],
              ),
            ),
          );
        });
  }

  Widget buildListTile({IconData icon, String title, Function onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
