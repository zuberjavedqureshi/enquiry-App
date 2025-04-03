import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/crud%20management/admission_done_edit.dart';
import 'package:enquiry_app/models/admission_cancel.dart';
import 'package:enquiry_app/models/admissions_done.dart';
import 'package:enquiry_app/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:url_launcher/url_launcher.dart';

class AdmissionDoneView extends StatefulWidget {
  const AdmissionDoneView({Key? key}) : super(key: key);

  @override
  State<AdmissionDoneView> createState() => _AdmissionDoneViewState();
}

class _AdmissionDoneViewState extends State<AdmissionDoneView> {
  final db = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _reason = TextEditingController();
  TextEditingController _whoCancel = TextEditingController();
  AdmissonsCancel _cancel = AdmissonsCancel();

  final currentDate = DateFormat.yMd().format(DateTime.now());

  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("Admissions Done").snapshots(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text("Loading...."));
          }

          if (!snapshot.hasData) {
            return Center(child: Text("Something went wrong."));
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      "Total Admissions: ${data.length}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return _buildAdmissionCard(context, index, snapshot);
                    }),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _buildAdmissionCard(context, int index, AsyncSnapshot snapshot) {
    var data = snapshot.data.docs;
    return Column(
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .40,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Name: ${data[index].get("Visitor Name")}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Mobile: ${data[index].get('Contact Number')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Reference: ${data[index].get('Reference')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Standard: ${data[index].get('Purpose OR Admission')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Admission Done By: ${data[index].get('Admin')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Date: ${data[index].get('Date')}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Time: ${data[index].get('In Time')}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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
                            Icons.phone,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            final Uri url = Uri.parse(
                                "tel://${data[index].get("Contact Number")}");
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
                            final Uri url = Uri.parse(
                                "sms://${data[index].get("Contact Number")}");
                            launchUrl(url);
                          },
                        ),
                      ),
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
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            print("${data[index].get("Visitor Name")}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdmissionEdit(
                                  sId: "${data[index].id}",
                                  name: "${data[index].get("Visitor Name")}",
                                  number:
                                      "${data[index].get("Contact Number")}",
                                  purpose:
                                      "${data[index].get("Purpose OR Admission")}",
                                  reference: "${data[index].get("Reference")}",
                                  admin: "${data[index].get("Admin")}",
                                  note: "${data[index].get("Note")}",
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        //padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.red,
                          border: Border.all(color: Colors.black),
                        ),
                        child: IconButton(
                          onPressed: () {
                            _reasonForCancellation(context, snapshot, index);
                          },
                          icon: Icon(
                            Icons.cancel_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          elevation: 8,
          shadowColor: Colors.deepPurple,
          margin: EdgeInsets.all(20),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.red, width: 1)),
        ),
      ],
    );
  }

  _reasonForCancellation(context, AsyncSnapshot snapshot, index) {
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
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Please Write the Reason!!"),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 10),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                            cursorColor: Colors.blue,
                            controller: _reason,
                            validator: (value) =>
                                ReasonValidator.validator(value!),
                            onSaved: (val) => _reason.text = val!,
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blue, width: 2)),
                              labelText: "Reason",
                              prefixIcon: Icon(
                                Icons.question_mark,
                                color: Colors.blue,
                              ),
                              labelStyle:
                                  TextStyle(color: Colors.blue, fontSize: 15),
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontStyle: FontStyle.italic),
                            cursorColor: Colors.blue,
                            controller: _whoCancel,
                            validator: (value) =>
                                NameValidator.validator(value!),
                            onSaved: (val) => _whoCancel.text = val!,
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
                              contentPadding: EdgeInsets.only(left: 10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Not Now")),
                TextButton(
                    onPressed: () {
                      _cancelAdmission(context, snapshot, index);
                    },
                    child: Text("Cancel Admission?")),
              ],
            ));
  }

  _cancelAdmission(context, AsyncSnapshot snapshot, index) {
    var data = snapshot.data.docs;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _cancel.name = "${data[index].get("Visitor Name")}";
        _cancel.number = "${data[index].get("Contact Number")}";
        _cancel.cancelDate = currentDate;
        _cancel.cancelTime = _time.format(context);
        _cancel.purpose = "${data[index].get("Purpose OR Admission")}";
        _cancel.reference = "${data[index].get("Reference")}";
        _cancel.adminName = _whoCancel.text;
        _cancel.reason = _reason.text;
      });
      db.collection("Cancel Admissions").add(_cancel.toJson());
      Navigator.pop(context);
      AdmissonsDone.deleteAdmission(docId: "${data[index].id}");
      final snackBar = SnackBar(
        content: Text(
          "Admission cancelled successfully!",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    ;
  }
}
