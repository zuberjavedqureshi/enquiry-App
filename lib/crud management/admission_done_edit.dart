import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/models/admissions_done.dart';
import 'package:enquiry_app/services/authentication.dart';
import 'package:flutter/material.dart';

class AdmissionEdit extends StatefulWidget {
  final String sId;
  final String name;
  final String number;
  final String purpose;
  final String reference;
  final String note;
  final String? admin;

  const AdmissionEdit({
    Key? key,
    required this.sId,
    required this.name,
    required this.number,
    required this.purpose,
    required this.reference,
    required this.note,
    required this.admin,
  }) : super(key: key);

  @override
  State<AdmissionEdit> createState() => _AdmissionEditState();
}

class _AdmissionEditState extends State<AdmissionEdit> {
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  TextEditingController _name = TextEditingController()..text;

  TextEditingController _purpose = TextEditingController();

  TextEditingController _phoneNumber = TextEditingController();

  TextEditingController _note = TextEditingController();
  TextEditingController _ref = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _name.text = widget.name;
    _purpose.text = widget.purpose;
    _phoneNumber.text = widget.number;
    _note.text = widget.note;
    _ref.text = widget.reference;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Admission"),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            Form(
              key: _formKey,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    //initialValue: "${widget.name}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.blue,
                    controller: _name,
                    validator: (value) => NameValidator.validator(value!),
                    onSaved: (val) => _name.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        labelText: " New Name",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                //Phone Number
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    //initialValue: "${widget.number}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.number,
                    controller: _phoneNumber,
                    validator: (value) => MobileValidator.validator(value!),
                    onSaved: (val) => _phoneNumber.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        labelText: " New Contact Number",
                        prefixIcon: Icon(
                          Icons.phone_android_rounded,
                          color: Colors.blue,
                        ),
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                //Date

                //[Purpose/Admission]
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    // initialValue: "${widget.purpose}",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.blue,
                    controller: _purpose,
                    validator: (value) => AdmissionValidator.validator(value!),
                    onSaved: (val) => _purpose.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        labelText: " New Purpose/Admission for",
                        prefixIcon: Icon(
                          Icons.work,
                          color: Colors.blue,
                        ),
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.blue,

                    controller: _ref,
                    //validator: (value) => NameValidator.validate(value!),
                    onSaved: (val) => _ref.text = val!,
                    decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        labelText: " Reference",
                        prefixIcon: Icon(
                          Icons.question_mark,
                          color: Colors.blue,
                        ),
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 10)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(),
                      // enabledBorder: UnderlineInputBorder(
                      //     borderSide:
                      //         BorderSide(color: Colors.blue, width: 2),
                      //         ),
                      labelText: " New optional Note",
                      prefixIcon: Icon(
                        Icons.edit,
                        color: Colors.blue,
                      ),
                      labelStyle: TextStyle(color: Colors.blue, fontSize: 15),
                      contentPadding: EdgeInsets.only(left: 10),
                    ),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                    cursorColor: Colors.blue,
                    keyboardType: TextInputType.multiline,
                    controller: _note,
                    validator: (value) => AdminValidator.validator(value!),
                    onSaved: (val) => _note.text = val!,
                  ),
                ),
              ]),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 60,
                  height: 60,
                  //padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.green,
                    border: Border.all(color: Colors.black),
                  ),
                  child: IconButton(
                    onPressed: () {
                      AdmissonsDone.updateAdmission(
                        docId: widget.sId,
                        name: _name.text,
                        number: _phoneNumber.text,
                        purpose: _purpose.text,
                        note: _note.text,
                        reference: _ref.text,
                      );
                      final snackBar = SnackBar(
                        content: Text(
                          "Admission updated successfully!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);

                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.done,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
