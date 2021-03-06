import 'dart:developer';

import '../screens/car_detail.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  final String? title;
  final double? price;
  final String? color;
  final String? fuel;
  final String? path;
  final String? gearbox;
  final DateTime? dtf;
  final DateTime? dtd;
  final String? Pickup;
  final String? Drop;

  const MyCustomForm(this.title, this.price, this.color, this.fuel,
      this.gearbox, this.path, this.dtf, this.dtd, this.Pickup, this.Drop);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState(dtf, dtd, price, Pickup, Drop);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  final DateTime? dtff;
  final DateTime? dtdd;
  final double? price;
  final String? Pickup;
  final String? drop;
  MyCustomFormState(this.dtff, this.dtdd, this.price, this.Pickup, this.drop);

  late TextEditingController namecontroller = new TextEditingController();
  late TextEditingController lastnamecontroller = new TextEditingController();
  late TextEditingController phonecontroller = new TextEditingController();
  late TextEditingController mailcontroller = new TextEditingController();
  late TextEditingController ontroller = new TextEditingController();

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String? Name;

  String? LastName;

  String? mail;

  String? phone;
  String? flight;
  String? comments;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.all(2),
        width: MediaQuery.of(context).size.width * .80,
        decoration:
            BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[300]!)]),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration:
                BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[100]!)]),
            width: 970,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Title(
                      color: Colors.black,
                      child:
                          Text('Reservation', style: TextStyle(fontSize: 36))),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Text(
                    'Complete the reservation form below to receive a custom price quote.',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Divider(),
                Title(color: Colors.black, child: Text('Name')),
                Row(
                  children: <Widget>[
                    Expanded(
                        child: Container(
                      height: 32,
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        controller: namecontroller,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter first name';
                          }

                          return null;
                        },
                        onSaved: (value) {},
                      ),
                    )),
                    Expanded(
                        child: Container(
                      height: 32,
                      margin: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8))),
                      child: TextFormField(
                        controller: lastnamecontroller,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter last name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          setState(() {
                            LastName = value;
                          });
                        },
                      ),
                    ))
                  ],
                ),
                Title(color: Colors.black, child: Text('E-mail')),
                Container(
                  height: 32,
                  margin: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.black),
                      borderRadius: const BorderRadius.all(Radius.circular(8))),
                  child: TextFormField(
                    controller: mailcontroller,
                    // The validator receives the text that the user has entered.
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'ex:myname@example.com';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      setState(() {
                        mail = value;
                      });
                    },
                  ),
                ),
                Title(color: Colors.black, child: Text('Phone Number')),
                Container(
                    height: 32,
                    margin: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.black),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8))),
                    child: TextFormField(
                      controller: phonecontroller,
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '(000) 000-0000';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        setState(() {
                          phone = value;
                        });
                      },
                    )),
                Container(
                  padding: EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: () {
                      // Validate returns true if the form is valid, or false otherwise.
                      if (_formKey.currentState!.validate()) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //  const SnackBar(content: Text('Processing Information')),

                        // );

                        CollectionReference _mainCollection =
                            FirebaseFirestore.instance.collection('mail');

                        _mainCollection.add({
                          'to': "${mailcontroller.text}",
                          'message': {
                            'subject': "Booking Confirmed",
                            'html':
                                "<p> Booking confirmed </p><p>Thank you ${namecontroller.text}  ${lastnamecontroller.text}  , for your reservation. A member of our staff will reach out to you in a few minutes."
                                    "<p> Booking Details <br>"
                                    "<p> Car :${widget.title}</p>  "
                                    "<p> Fuel Type :${widget.fuel}</p>  "
                                    "<p> Price :${widget.price}</p>  "
                                    "<p> Start Date :$dtff</p>  "
                                    "<p> End Date :$dtdd</p>  "
                          },
                        });

                        print("sent email");
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
