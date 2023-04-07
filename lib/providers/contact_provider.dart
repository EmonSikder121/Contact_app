import 'package:contact_app/db/db_helper.dart';
import 'package:flutter/foundation.dart';
import '../models/contact_model.dart';

class ContactProvider extends ChangeNotifier{
  List<ContactModel> contactList = [];


  // insert data (Provider)
  Future<int>insertContact(ContactModel contactModel) async {
   final rowId  = await DbHelper.insertContact(contactModel);
   contactModel.id = rowId;
   contactList.add(contactModel);
   notifyListeners();

   // getAllContacts();

   return rowId;
  }

  //update (Provider)**

  Future<int> updateContact (int rowId, String column,dynamic value) async{
    final map = {column : value};
    final id = await DbHelper.updateContact(rowId, map);



    // favorite toggol**

    // final contactModel = contactList.firstWhere((element) => element.id==rowId);
    // contactModel.favorite= !contactModel.favorite;

    // UI refresh**

    // final index = contactList.indexOf(contactModel);
    // contactList[index]=contactModel;
    // notifyListeners();

    getAllContacts();

    return id;
  }


  // Get all Contact

  getAllContacts() async{
    contactList= await DbHelper.getAllContact();
    notifyListeners();

  }

  // Get all Favorite Contact

  getAllFavoriteContact() async{
    contactList= await DbHelper.getAllFavoriteContact();
    notifyListeners();

  }



  // Get Contact Details on details page by Id (Provider)**

  Future<ContactModel> getAllContactById(int id){
    return DbHelper.getAllContactById(id);
  }
  
  void delete (int id) async {
    final deleteRowId = await DbHelper.deleteContact(id);
    contactList.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}