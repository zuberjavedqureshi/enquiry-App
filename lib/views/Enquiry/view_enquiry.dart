import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/crud%20management/update_enquiry.dart';
import 'package:enquiry_app/models/PERSON.dart';
import 'package:enquiry_app/models/admissions_done.dart';
import 'package:enquiry_app/services/authentication.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewEnquiry extends StatefulWidget {
  final String? id;
  final String? name;
  final String? number;
  final String? date;
  final String? InTime;
  final String? purpose;
  final String? reference;
  final String? Address;
  final String? admin;
  final String? note;

  const ViewEnquiry({
    Key? key,
    required this.id,
    required this.name,
    required this.number,
    required this.date,
    required this.InTime,
    required this.purpose,
    required this.reference,
    required this.Address,
    required this.admin,
    required this.note,
  }) : super(key: key);

  @override
  State<ViewEnquiry> createState() => _ViewEnquiryState();
}

class _ViewEnquiryState extends State<ViewEnquiry> {
  AdmissonsDone _admissonsDone = new AdmissonsDone();
  final _formKey = GlobalKey<FormState>();

  final db = FirebaseFirestore.instance;
  final currentDate = DateFormat.yMd().format(DateTime.now());

  TimeOfDay _time = TimeOfDay.now();
  TextEditingController _adminName = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                _buildBody(),
                SizedBox(height: 40),
                Text(
                  "${widget.name}",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Divider(),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.phone_android_rounded,
                          size: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${widget.number}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.work,
                          size: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .70,
                          child: Text(
                            "${widget.purpose}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month,
                          size: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${widget.date}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 50,
                            ),
                            Icon(
                              Icons.watch_later_outlined,
                              size: 20,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "${widget.InTime}",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.question_mark_sharp,
                          size: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${widget.reference}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person,
                          size: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${widget.admin}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.home,
                          size: 20,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: 250,
                          child: Text(
                            "${widget.Address}",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.phone,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          final Uri url = Uri.parse("tel://${widget.number}");
                          launchUrl(url);
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.message_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          final Uri url = Uri.parse("sms://${widget.number}");
                          launchUrl(url);
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.done,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _addAdmission();
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.cyan,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.update_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UpdateEnquiry(
                                      sId: "${widget.id}",
                                      name: "${widget.name}",
                                      number: "${widget.number}",
                                      purpose: "${widget.purpose}",
                                      reference: "${widget.reference}",
                                      Address: "${widget.Address}",
                                      admin: "${widget.admin}",
                                      note: "${widget.note}")));
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red[700],
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_forever_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          deleteEnuiry("${widget.id}");
                        },
                      ),
                    ),
                    Container(
                      width: 50,
                      height: 50,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(color: Colors.black),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text("Ok"))
                                    ],
                                    content: Text(
                                      "${widget.note}",
                                    ),
                                  ));
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: Image.asset("images/contact_bg.png", fit: BoxFit.cover)),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          width: 140,
          height: 140,
          child: Icon(
            Icons.person,
            size: MediaQuery.of(context).size.width * .25,
            color: Colors.grey[800],
          ),
        ),
      ],
    );
  }

  deleteEnuiry(String id) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Are you sure?",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text("Delete Enquiry permanently?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      PersonAdd.deleteEnquiry(docId: id);
                      Navigator.of(context).popUntil((route) => route.isFirst);
                      final snackBar = SnackBar(
                        content: Text(
                          "Enquiry Deleted Successfully!",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text("Delete")),
              ],
            ));
  }

  _addAdmission() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Are you sure?",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              content: Text("Add Admission to our Record?"),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: TextFormField(
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontStyle: FontStyle.italic),
                      cursorColor: Colors.blue,
                      controller: _adminName,
                      validator: (value) => AdminValidator.validator(value!),
                      onSaved: (val) => _adminName.text = val!,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.blue, width: 2)),
                          labelText: "Your Name",
                          prefixIcon: Icon(
                            Icons.person,
                            color: Colors.blue,
                          ),
                          labelStyle:
                              TextStyle(color: Colors.blue, fontSize: 15),
                          contentPadding: EdgeInsets.only(left: 10)),
                    ),
                  ),
                ),
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      _addNewAdmission();
                    },
                    child: Text("Confirm!")),
              ],
            ));
  }

  _addNewAdmission() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _admissonsDone.name = widget.name;
        _admissonsDone.number = widget.number;
        _admissonsDone.date = currentDate;
        _admissonsDone.InTime = _time.format(context);
        _admissonsDone.purpose = widget.purpose;
        _admissonsDone.reference = widget.reference;
        _admissonsDone.Address = widget.Address;
        _admissonsDone.admin = widget.admin;
        _admissonsDone.note = widget.note;
        _admissonsDone.adminName = _adminName.text;
      });
      db.collection("Admissions Done").add(_admissonsDone.toJson());
      PersonAdd.deleteEnquiry(docId: "${widget.id}");
      Navigator.popUntil(context, (route) => route.isFirst);
      final snackBar = SnackBar(
        content: Text(
          "Admission added successfully!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
