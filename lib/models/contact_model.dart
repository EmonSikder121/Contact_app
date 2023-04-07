const String tblContact = 'tbl_contact';
const String tblContactColId = 'id';
const String tblContactColName = 'name';
const String tblContactColPhone = 'phone';
const String tblContactColEmail = 'email';
const String tblContactColDesignation = 'designation';
const String tblContactColAddress = 'address';
const String tblContactColCompany = 'company';
const String tblContactColWeb = 'web';
const String tblContactColFavorite = 'favorite';

class ContactModel {
  int id;
  String name;
  String phone;
  String email;
  String designation;
  String address;
  String company;
  String web;
  bool favorite;

  ContactModel({
    this.id = -1,
    required this.name,
    required this.phone,
    this.email = '',
    this.designation = '',
    this.address = '',
    this.company = '',
    this.web = '',
    this.favorite = false,

  });


  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{
      tblContactColName: name,
      tblContactColPhone: phone,
      tblContactColEmail: email,
      tblContactColDesignation: designation,
      tblContactColAddress: address,
      tblContactColCompany: company,
      tblContactColWeb: web,
      tblContactColFavorite: favorite ? 1 : 0,
    };
    if (id > 0) {
      map[tblContactColId] = id;
    }
    return map;
  }

  factory ContactModel.fromMap(Map<String, dynamic> map)=>
      ContactModel(
        id: map[tblContactColId],
        name: map[tblContactColName],
        phone: map[tblContactColPhone],
        email: map[tblContactColEmail],
        designation: map[tblContactColDesignation],
        company: map[tblContactColCompany],
        address: map[tblContactColAddress],
        web: map[tblContactColWeb],
        favorite: map[tblContactColFavorite] == 1 ? true : false,
      );

  @override
  String toString() {
    return 'ContactModel{id: $id, name: $name, phone: $phone, email: $email, designation: $designation, address: $address, company: $company, web: $web}';
  }
}
