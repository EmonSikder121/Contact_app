import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/pages/homepage.dart';
import 'package:contact_app/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContactForm_page extends StatefulWidget {
  static const String routeName = '/form_page';

  const ContactForm_page({Key? key}) : super(key: key);

  @override
  State<ContactForm_page> createState() => _ContactForm_pageState();
}

class _ContactForm_pageState extends State<ContactForm_page> {
  final _namecontroler = TextEditingController();
  final _phonecontroller = TextEditingController();
  final _emailcontroler = TextEditingController();
  final _designationcontroler = TextEditingController();
  final _addresscontroler = TextEditingController();
  final _companycontroler = TextEditingController();
  final _webcontroler = TextEditingController();
  final _formkey = GlobalKey<FormState>();



  //Scan page Data Receive

  // @override
  // void didChangeDependencies() {
  //   final contact = ModalRoute.of(context)!.settings.arguments as  ContactModel;
  //   _namecontroler.text = contact.name;
  //   _phonecontroller.text = contact.phone;
  //   _emailcontroler.text = contact.email;
  //   _designationcontroler.text = contact.designation;
  //   _addresscontroler.text = contact.address;
  //   _companycontroler.text = contact.company;
  //   _webcontroler.text = contact.web;
  //   super.didChangeDependencies();
  // }

  @override
  void dispose() {
    _namecontroler.dispose();
    _phonecontroller.dispose();
    _emailcontroler.dispose();
    _designationcontroler.dispose();
    _addresscontroler.dispose();
    _companycontroler.dispose();
    _webcontroler.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New contact'),
        actions: [IconButton(onPressed: _save, icon: const Icon(Icons.save))],
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namecontroler,
              decoration: const InputDecoration(
                labelText: 'Contact Name',
                filled: true,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }

                if (value.length > 25) {
                  return 'Contact name Should not more then 25 chars long';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _phonecontroller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Contact Number', filled: true),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field must not be empty';
                }

                if (value.length < 11) {
                  return 'Contact number Should not more then 11 chars long';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: _emailcontroler,
              decoration: const InputDecoration(
                  labelText: 'Contact email', filled: true),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _designationcontroler,
              decoration: const InputDecoration(
                  labelText: 'Contact Designation', filled: true),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _addresscontroler,
              decoration: const InputDecoration(
                  labelText: 'Contact address', filled: true),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _companycontroler,
              decoration: const InputDecoration(
                  labelText: 'Contact Company', filled: true),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _webcontroler,
              decoration:
              const InputDecoration(labelText: 'Contact web', filled: true),
            ),
          ],
        ),
      ),
    );
  }

  void _save() {
    if (_formkey.currentState!.validate()) {

      // save data to database


      final contactmodel = ContactModel(
        name: _namecontroler.text,
        phone: _phonecontroller.text,
        email: _emailcontroler.text,
        designation: _designationcontroler.text,
        company: _companycontroler.text,
        address: _addresscontroler.text,
        web: _webcontroler.text,
      );

      Provider.of<ContactProvider>(context,listen:false).
      insertContact(contactmodel).
      then((value) => Navigator.pushNamed(context, HomePage.routeName));
    }
  }
}
