import 'package:cours_dsia/models/fav_contact.dart';
import 'package:cours_dsia/services/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:sqflite/sqflite.dart';

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key, required this.index});

  final int index;

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  List<Contact> contactList = [];
  List<FavContact> favContact = [];
  ContactProvider provider = ContactProvider();

  @override
  void initState() {
    super.initState();
    getContacts();
    initDatabase();
  }

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/contact.db";
    provider.open(path).then(
      (value) {
        provider.getAllContacts().then((value) {
          setState(() {
            favContact = value;
          });
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.index == 0 ? "Envoyer de l'argent" : "Achat crédit"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "À",
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25)),
                    child: Icon(
                      Icons.add,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Flexible(
                    child: Text(
                      widget.index == 0
                          ? "Envoyer un nouveau numéro"
                          : "Acheter du crédit pour un nouveau numéro",
                      //maxLines: 1,
                      //overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              favContact.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Favoris",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: favContact.length,
                          itemBuilder: (context, index) {
                            FavContact c = favContact[index];
                            return GestureDetector(
                              onDoubleTap: () {
                                provider.delete(c.id!);
                                provider.getAllContacts().then((value) {
                                  setState(() {
                                    favContact = value;
                                  });
                                });
                              },
                              child: contactWidget(
                                  name: c.name!, number: c.phone!),
                            );
                          },
                        )
                      ],
                    )
                  : SizedBox.shrink(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Contacts",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
              ),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: contactList.length > 50 ? 50 : contactList.length,
                itemBuilder: (context, index) {
                  Contact c = contactList[index];
                  String number =
                      c.phones.first.normalizedNumber.replaceAll("+221", "");
                  return GestureDetector(
                      onDoubleTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            title: Text("Favoris"),
                            content: Text(
                                "Voulez-vous ajouter ce contact dans vos favoris?"),
                            actions: [
                              ElevatedButton(
                                child: Text("Annuler"),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              ElevatedButton(
                                child: Text("Ajouter"),
                                onPressed: () {
                                  FavContact fc = FavContact(
                                      name: c.displayName, phone: number);
                                  provider.insert(fc);
                                  provider.getAllContacts().then((value) {
                                    setState(() {
                                      favContact = value;
                                    });
                                    Navigator.pop(context);
                                  });
                                },
                              )
                            ],
                          ),
                        );
                      },
                      child:
                          contactWidget(name: c.displayName, number: number));
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contactList = await FlutterContacts.getContacts(withProperties: true);
      contactList.removeWhere(
        (element) => element.phones.isEmpty,
      );
      contactList.removeWhere(
        (element) => !element.phones.first.normalizedNumber.startsWith("+221"),
      );
      setState(() {});
      print(contactList.length);
    }
  }

  Widget contactWidget({required String name, required String number}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          widget.index == 0
              ? Container(
                  decoration: BoxDecoration(
                      color: Colors.grey.withValues(alpha: .3),
                      borderRadius: BorderRadius.circular(45)),
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                )
              : Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(45),
                      color: number.startsWith("77") || number.startsWith("78")
                          ? Colors.orange
                          : number.startsWith("76")
                              ? Colors.blue.shade900
                              : Colors.yellow),
                ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                number,
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      ),
    );
  }
}
