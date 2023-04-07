import 'dart:io';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import '../castomwidgets/drag_target_item.dart';
import '../models/contact_model.dart';
import '../utils/constants.dart';

class ScanPage extends StatefulWidget {
  static const String routeName = '/scanPage';

  const ScanPage({Key? key}) : super(key: key);

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  List<String> lines = [];
  String name = '',
      mobile = '',
      email = '',
      address = '',
      company = '',
      designation = '',
      website = '',
      image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan card'),
        actions: [
          TextButton(onPressed: _createContactModelFromScannedValues, child: Text('Next',style: TextStyle(color: Colors.white),))
        ],
      ),
      body: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Capture')),
              TextButton.icon(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  icon: const Icon(Icons.photo_album),
                  label: const Text('Gallery')),
            ],
          ),

          Card(
            child:  Column(
              children: [
                DragTargetItem(property: ContactProperties.name, onDrop: _getPropertyValue,),
                DragTargetItem(property: ContactProperties.mobile, onDrop: _getPropertyValue,),
                DragTargetItem(property: ContactProperties.email, onDrop: _getPropertyValue,),
                DragTargetItem(property: ContactProperties.designation, onDrop: _getPropertyValue,),
                DragTargetItem(property: ContactProperties.company, onDrop: _getPropertyValue,),
                DragTargetItem(property: ContactProperties.address, onDrop: _getPropertyValue,),
                DragTargetItem(property: ContactProperties.website, onDrop: _getPropertyValue,),
              ],
            ),
          ),

          // Wrap(
          //   // direction: Axis.vertical,
          //   children: lines.map((e) => Chip(label: Text(e))).toList(),
          // )

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Wrap(
              children: lines.map((line) => Padding(
                padding: const EdgeInsets.all(3.0),
                child: LineItem(line: line),
              )).toList(),
            ),
          ),

        ],
      ),
    );
  }

  Future<void> getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      final textRecognize = GoogleMlKit.vision.textRecognizer();
      final recognizedText = await textRecognize
          .processImage(InputImage.fromFile(File((pickedFile.path))));
      final tempList = <String>[];
      for (var block in recognizedText.blocks) {
        for (var line in block.lines) {
          tempList.add(line.text);
        }
      }
      print(tempList);
      setState(() {
        lines = tempList;
      });
    }
  }

  void _getPropertyValue(String property, String value) {
    switch (property) {
      case ContactProperties.name:
        name = value;
        break;
      case ContactProperties.mobile:
        mobile = value;
        break;
      case ContactProperties.email:
        email = value;
        break;
      case ContactProperties.address:
        address = value;
        break;
      case ContactProperties.company:
        company = value;
        break;
      case ContactProperties.designation:
        designation = value;
        break;
      case ContactProperties.website:
        website = value;
        break;
    }
  }
  void _createContactModelFromScannedValues() {
    final contact = ContactModel(
      name: name,
      phone: mobile,
      email: email,
      address: address,
      company: company,
      designation: designation,
      web: website,
    );
    Navigator.pushNamed(context, ContactForm_page.routeName, arguments: contact);
  }
}


class LineItem extends StatelessWidget {
  final String line;
  final GlobalKey _globalKey = GlobalKey();

  LineItem({Key? key, required this.line}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<String>(
        data: line,
        dragAnchorStrategy: childDragAnchorStrategy,
        feedback: Container(
          key: _globalKey,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(color: Colors.black45),
          child: Text(
            line,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: (Colors.white)),
          ),
        ),
        child: Chip(
          label: Text(line),
        )
    );
  }



}
