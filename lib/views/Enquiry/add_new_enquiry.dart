import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/models/PERSON.dart';
import 'package:enquiry_app/services/authentication.dart';

import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class AddNewEnquiry extends StatefulWidget {
  const AddNewEnquiry({Key? key}) : super(key: key);

  @override
  State<AddNewEnquiry> createState() => _AddNewEnquiryState();
}

class _AddNewEnquiryState extends State<AddNewEnquiry> {
  late CollectionReference collectionReference;

  final _formKey = GlobalKey<FormState>();
  final db = FirebaseFirestore.instance;

  PersonAdd _addNew = PersonAdd();

  DateTime _dateTime = DateTime.now();
  String? setDate;
  final currentDate = DateFormat('dd-MM-yyyy').format(DateTime.now());

  TimeOfDay _time = TimeOfDay.now();
  String? setTime;

  TextEditingController _name = TextEditingController();
  TextEditingController _purpose = TextEditingController();
  TextEditingController _InTime = TextEditingController();
  TextEditingController _phoneNumber = TextEditingController();
  TextEditingController _ref = TextEditingController();
  TextEditingController _admin = TextEditingController();
  TextEditingController _address = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController _note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(
            "New Enquiry",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () {
                  _addNewEnquiry();
                },
                icon: Icon(
                  Icons.done,
                  size: 30,
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    radius: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Container(
                          child: Icon(Icons.person),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
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
                            labelText: " Visitor Name",
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
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Choose Date : ",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          InkWell(
                            child: _buildContainerForDate(_date),
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    //InTime
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "In Time : ",
                            style: TextStyle(
                                color: Colors.blue,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic),
                          ),
                          InkWell(
                            child: _buildContainerForTime(_InTime),
                            onTap: () {
                              _selectTime(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    //[Purpose/Admission]
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
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
                        textCapitalization: TextCapitalization.words,
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
                        textCapitalization: TextCapitalization.words,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                        cursorColor: Colors.blue,
                        controller: _address,
                        validator: (value) =>
                            AddressValidator.validator(value!),
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
                    //Admin

                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
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
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: TextFormField(
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(),
                          // enabledBorder: UnderlineInputBorder(
                          //     borderSide:
                          //         BorderSide(color: Colors.blue, width: 2),
                          //         ),
                          labelText: " Add optional Note",
                          prefixIcon: Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10),
                        ),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontStyle: FontStyle.italic),
                        cursorColor: Colors.blue,
                        keyboardType: TextInputType.multiline,
                        controller: _note,
                        //validator: (value) => AdminValidator.validator(value!),
                        onSaved: (val) => _note.text = val!,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerForDate(TextEditingController date) {
    return Container(
      width: MediaQuery.of(context).size.width * .40,
      height: MediaQuery.of(context).size.width * .10,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: TextFormField(
        controller: date,
        enabled: false,
        style: TextStyle(fontSize: 18, color: Colors.white),
        textAlign: TextAlign.center,
        onSaved: (val) => _date.text = val!,
        decoration: InputDecoration(
          hintText: '$currentDate',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
            height: 1,
          ),
          disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.only(top: 0.0, bottom: 10),
        ),
      ),
    );
  }

  Future _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2000),
        lastDate: DateTime(2500));
    if (picked != null)
      setState(() {
        _dateTime = picked;
        _date.text = DateFormat('dddd-mm-yyyy').format(_dateTime);
      });
  }

  Widget _buildContainerForTime(TextEditingController InTime) {
    var currentTime = TimeOfDay.now().format(context);

    return Container(
      width: MediaQuery.of(context).size.width * .40,
      height: MediaQuery.of(context).size.width * .10,
      margin: EdgeInsets.only(top: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.blue,
      ),
      child: TextFormField(
        controller: InTime,
        style: TextStyle(fontSize: 18, color: Colors.white),
        enabled: false,
        textAlign: TextAlign.center,
        onSaved: (val) => setDate = val!,
        decoration: InputDecoration(
          hintText: '${currentTime}',
          hintStyle: TextStyle(
            fontSize: 15,
            color: Colors.white,
            height: 1,
          ),
          disabledBorder: UnderlineInputBorder(borderSide: BorderSide.none),
          contentPadding: EdgeInsets.only(top: 0.0, bottom: 10),
        ),
      ),
    );
  }

  Future _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        _time = picked;
        _InTime.text = _time.format(context);
      });
  }

  _addNewEnquiry() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        setState(() {
          _addNew.name = _name.text;
          _addNew.number = _phoneNumber.text;
          _addNew.date = DateFormat("dd-MM-yyyy").format(_dateTime);
          _addNew.InTime = _time.format(context);
          _addNew.purpose = _purpose.text;
          _addNew.reference = _ref.text;
          _addNew.Address = _address.text;
          _addNew.admin = _admin.text;
          _addNew.note = _note.text;
          _addNew.createdAt = DateTime.fromMillisecondsSinceEpoch(
              DateTime.now().millisecondsSinceEpoch);
        });
        db.collection("Enquiries").add(_addNew.toJson());
        Navigator.pop(context);
        final snackBar = SnackBar(
          content: Text(
            "Enquiry added successfully!",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.green,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } catch (e) {
        print("$e Cannot add!");
      }
    }
    ;
  }
}
