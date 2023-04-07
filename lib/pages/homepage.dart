import 'package:contact_app/models/contact_model.dart';
import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:contact_app/pages/scanpage.dart';
import 'package:contact_app/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/';
  const HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int index = 0;

  @override
  void didChangeDependencies() {

    Provider.of<ContactProvider>(context,listen: false).getAllContacts();

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    // Provider.of<ContactProvider>(context,listen: false).getAllContacts();

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Navigator.pushNamed(context, ScanPage.routeName);
            Navigator.pushNamed(context, ContactForm_page.routeName);
          },
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
          title: const Text('Contact List'),
          centerTitle: true,

          // actions: [
          //   IconButton(onPressed: () {
          //     Navigator.pushNamed(context, ScanPage.routeName);
          //   }, icon: Icon(Icons.document_scanner))
          // ],
        ),

        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          clipBehavior: Clip.antiAlias,

          child: BottomNavigationBar(
            // backgroundColor: Theme.of(context).primaryColor,

              currentIndex: index,

              onTap: (value){
                setState(() {
                  index = value;
                });
                _fetchData();
              },

              items: const [

                BottomNavigationBarItem(
                  icon: Icon(Icons.contact_page),
                  label: 'All contacts',

                ),

                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                    label: 'All favorites'
                ),
              ]),
        ),
        body: Consumer<ContactProvider>(
          builder:(context , provider , child)=> ListView.builder(
              itemCount: provider.contactList.length,
              itemBuilder: (context, index) {
                final contact = provider.contactList[index];
                return Card(
                  elevation: 3,
                  child: Dismissible(
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      alignment: Alignment.centerLeft,
                      child: const Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.delete,color: Colors.white,),
                      ),
                    ),

                    confirmDismiss: showDeleteConfirationDialog,
                    onDismissed: (_) {
                      provider.delete(contact.id);
                    },

                    key: UniqueKey(),
                    child: ListTile(
                      onTap: (){
                        Navigator.pushNamed(context, ContactDetailsPage.routeName,arguments: contact);
                      },
                      title: Text(contact.name),
                      trailing: IconButton(
                        onPressed: () {
                          final value = contact.favorite ? 0:1;
                          provider.updateContact(contact.id, tblContactColFavorite, value);
                        },
                        icon: Icon( contact.favorite? Icons.favorite : Icons.favorite_border),
                      ),
                    ),
                  ),
                );
              } ),
        )
    );
  }

  Future<bool?> showDeleteConfirationDialog (DismissDirection direction) {
    return showDialog(context: context, builder: (context) =>  AlertDialog(
      title: const Text('Confirm Delete'),
      content: const Text('Are you sure to delete this contact'),
      actions: [

        TextButton(
            onPressed: () {
              Navigator.pop(context ,false);
            }, child: const Text('Cancel')),


        TextButton(
            onPressed: () {
              Navigator.pop(context ,true);
            }, child: const Text('yes')),
      ],
    ));
  }

  void _fetchData() {
    if (index == 0){
      Provider.of<ContactProvider>(context,listen: false).getAllContacts();
    }
    else {
      Provider.of<ContactProvider>(context,listen: false).getAllFavoriteContact();
    }

  }
}
