import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showMsg (BuildContext context ,String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

//update

showSingleTextInputDialoge(
{
  required BuildContext context,
  required String title,
  TextInputType inputType = TextInputType.text,
  required Function (String) onUpdate,
}
    ){
  final controller = TextEditingController();
  showDialog(context: context, builder: (context)=> AlertDialog(
    title: Text('Update $title'),
    content: Padding(
      padding: const EdgeInsets.all(8),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'Enter New $title',
              border: OutlineInputBorder()
        ),
      ),
    ),


    actions: [
      TextButton(onPressed: () => Navigator.pop(context) , child: Text('Cancel')),
      TextButton(onPressed: () {
        if(controller.text.isEmpty) return;
        onUpdate(controller.text);
        Navigator.pop(context);
      }, child: Text('Update')),
    ],
  ));
}