import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/models/PERSON.dart';
import 'package:enquiry_app/services/authentication.dart';
import 'package:flutter/material.dart';

class UpdateEnquiry extends StatefulWidget {
  final String sId;
  final String? name;
  final String? number;
  final String? purpose;
  final String? reference;
  final String? Address;
  final String? admin;
  final String? note;
  const UpdateEnquiry({
    Key? key,
    required this.sId,
    required this.name,
    required this.number,
    required this.purpose,
    required this.reference,
    required this.Address,
    required this.admin,
    this.note,
  }) : super(key: key);

  @override
  State<UpdateEnquiry> createState() => _UpdateEnquiryState();
}

class _UpdateEnquiryState extends State<UpdateEnquiry> {
  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;
  TextEditingController _name = TextEditingController();
  TextEditingController _purpose = TextEditingController();

  TextEditingController _phoneNumber = TextEditingController();

  TextEditingController _address = TextEditingController();

  TextEditingController _note = TextEditingController();
  TextEditingController _ref = TextEditingController();
  TextEditingController _admin = TextEditingController();
  @override
  Widget build(BuildContext context) {
    _name.text = widget.name!;
    _purpose.text = widget.purpose!;
    _phoneNumber.text = widget.number!;
    _address.text = widget.Address!;
    _note.text = widget.note!;
    _ref.text = widget.reference!;
    _admin.text = widget.admin!;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Update Enquiry"),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
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
                          labelText: " Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  //Phone Number
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
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
                          labelText: " Contact Number",
                          prefixIcon: Icon(
                            Icons.phone_android_rounded,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  //Date

                  //[Purpose/Admission]
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                      cursorColor: Colors.blue,
                      controller: _purpose,
                      validator: (value) =>
                          AdmissionValidator.validator(value!),
                      onSaved: (val) => _purpose.text = val!,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          labelText: " Purpose/Admission for",
                          prefixIcon: Icon(
                            Icons.work,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  //Ref
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
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
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  //Address
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                      cursorColor: Colors.blue,
                      controller: _address,
                      validator: (value) => AddressValidator.validator(value!),
                      onSaved: (val) => _address.text = val!,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          labelText: " Address",
                          prefixIcon: Icon(
                            Icons.home,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                      cursorColor: Colors.blue,
                      controller: _admin,
                      validator: (value) => AdminValidator.validator(value!),
                      onSaved: (val) => _admin.text = val!,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.blue, width: 2)),
                        labelText: " Admin",
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.blue,
                        ),
                        labelStyle: TextStyle(color: Colors.blue, fontSize: 15),
                        contentPadding: EdgeInsets.only(left: 10),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: TextFormField(
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(),
                        // enabledBorder: UnderlineInputBorder(
                        //     borderSide:
                        //         BorderSide(color: Colors.blue, width: 2),
                        //         ),
                        labelText: " optional Note",
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
                      // validator: (value) => AdminValidator.validator(value!),
                      onSaved: (val) => _note.text = val!,
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: updateFun,
                child: Text("update"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  updateFun() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        PersonAdd.updateEnquiry(
            docId: widget.sId,
            name: _name.text,
            number: _phoneNumber.text,
            purpose: _purpose.text,
            address: _address.text,
            note: _note.text,
            reference: _ref.text,
            admin: _admin.text);
        final snackBar = SnackBar(
          content: Text(
            "Enquiry updated successfully!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.popUntil(context, (route) => route.isFirst);
      } catch (e) {
        print(e);
      }
    }
  }
}
