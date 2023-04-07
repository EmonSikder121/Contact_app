import 'package:contact_app/pages/contact_details_page.dart';
import 'package:contact_app/pages/contact_form_page.dart';
import 'package:contact_app/pages/homepage.dart';
import 'package:contact_app/pages/scanpage.dart';
import 'package:contact_app/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ContactProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName : (context)=> const HomePage(),
        ContactForm_page.routeName : (context)=> const ContactForm_page(),
        ContactDetailsPage.routeName : (context)=> const ContactDetailsPage(),
        ScanPage.routeName : (context)=> const ScanPage(),
      },
    );
  }
}


