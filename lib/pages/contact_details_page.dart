import 'dart:io';
import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/providers/contact_provider.dart';
import 'package:contact_app/utils/helper_function.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactDetailsPage extends StatefulWidget {
  static const String routeName = '/details_page';

  const ContactDetailsPage({Key? key}) : super(key: key);

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  late ContactProvider contactProvider;
  late ContactModel contactModel;
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      contactProvider = Provider.of<ContactProvider>(context);
      contactModel = ModalRoute.of(context)!.settings.arguments as ContactModel;

      isFirst = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(contactModel.name),
      ),
      body: FutureBuilder<ContactModel>(
        future: contactProvider.getAllContactById(contactModel.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final contact = snapshot.data!;
            return ListView(
              children: [
                Card(
                    elevation: 5,
                    child: Image.asset(
                      'images/img.png',
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    )),








                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                      'Phone :   ${contact.phone}',
                      style: const TextStyle(fontSize: 20),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              _CallContact(contact.phone);
                            },
                            icon: const Icon(Icons.call)),
                        IconButton(
                            onPressed: () {
                              _sentSms(contact.phone);
                            },
                            icon: const Icon(Icons.sms)),
                        IconButton(
                            onPressed: () {
                              showSingleTextInputDialoge(
                                  context: context,
                                  title: 'Phone',
                                  inputType: TextInputType.phone,
                                  onUpdate: (value) {
                                    contactProvider
                                        .updateContact(contact.id,
                                        tblContactColPhone, value)
                                        .then((value) => setState(() {}));
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),










                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                        'Email :  ${contact.email.isEmpty ? 'Email not set yet' : contact.email}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (contact.email.isEmpty) {
                                showMsg(context, 'Please add an email first');
                                return;
                              }
                              _emailContact(contact.email);
                            },
                            icon: const Icon(Icons.email)),
                        IconButton(
                            onPressed: () {
                              showSingleTextInputDialoge(
                                  context: context,
                                  title: 'email',
                                  inputType: TextInputType.text,
                                  onUpdate: (value) {
                                    contactProvider
                                        .updateContact(contact.id,
                                        tblContactColEmail, value)
                                        .then((value) => setState(() {}));
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),










                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                        'Designation : ${contact.designation.isEmpty ? 'Designation not set yet' : contact.designation}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.person)),
                        IconButton(
                            onPressed: () {
                              showSingleTextInputDialoge(
                                  context: context,
                                  title: 'Designation',
                                  inputType: TextInputType.text,
                                  onUpdate: (value) {
                                    contactProvider.updateContact(contact.id, tblContactColDesignation, value).then((value) => setState((){}));
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),






                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                        'Address :  ${contact.address.isEmpty ? 'Address not set yet' : contact.address}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (contact.address.isEmpty) {
                                showMsg(context, 'Please add an email first');
                                return;
                              }
                              _addressContact(contact.address);
                            },
                            icon: const Icon(Icons.location_on)),
                        IconButton(
                            onPressed: () {
                              showSingleTextInputDialoge(
                                  context: context,
                                  title: 'Address',
                                  inputType: TextInputType.text,
                                  onUpdate: (value) {
                                    contactProvider.updateContact(contact.id, tblContactColAddress, value).then((value) => setState((){}));
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),









                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                        'Company :  ${contact.company.isEmpty ? 'Company not set yet' : contact.company}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.location_city)),
                        IconButton(
                            onPressed: () {
                              showSingleTextInputDialoge(
                                  context: context,
                                  title: 'Company',
                                  inputType: TextInputType.text,
                                  onUpdate: (value) {
                                    contactProvider.updateContact(contact.id, tblContactColCompany, value).then((value) => setState((){}));
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),










                Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(
                        'Website :  ${contact.web.isEmpty ? 'Website not set yet' : contact.web}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {
                              if (contact.web.isEmpty) {
                                showMsg(context, 'Please add an email first');
                                return;
                              }
                              _webContact(contact.web);
                            },
                            icon: const Icon(Icons.web)),
                        IconButton(
                            onPressed: () {
                              showSingleTextInputDialoge(
                                  context: context,
                                  title: 'Website',
                                  inputType: TextInputType.text,
                                  onUpdate: (value) {
                                    contactProvider.updateContact(contact.id, tblContactColWeb, value).then((value) => setState((){}));
                                  });
                            },
                            icon: const Icon(Icons.edit)),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text('field to fetch data'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  void _CallContact(String phone) async {
    final url = 'tel:$phone';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not perform this operation');
    }
  }

  void _sentSms(String phone) async {
    final url = 'sms:$phone';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not perform this operation');
    }
  }

  void _emailContact(String email) async {
    final url = 'mailto:$email';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not perform this operation');
    }
  }

  void _addressContact(String address) async {
    String url = '';
    if (Platform.isAndroid) {
      url = "geo:0,0?q=$address";
    } else {
      url = "http://maps.apple.com/?sll=$address";
    }
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not perform this operation');
    }
  }




  void _webContact(String web) async {
    String url = 'https://$web';
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    } else {
      showMsg(context, 'Could not perform this operation');
    }
  }
}
