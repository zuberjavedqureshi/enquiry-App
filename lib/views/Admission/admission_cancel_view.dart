import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/models/admission_cancel.dart';
import 'package:enquiry_app/models/admissions_done.dart';
import 'package:enquiry_app/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AdmissionCancelView extends StatefulWidget {
  const AdmissionCancelView({
    Key? key,
  }) : super(key: key);

  @override
  State<AdmissionCancelView> createState() => _AdmissionCancelViewState();
}

class _AdmissionCancelViewState extends State<AdmissionCancelView> {
  final _formKey = GlobalKey<FormState>();
  final currentDate = DateFormat.yMd().format(DateTime.now());
  AdmissonsDone _admissonsDone = new AdmissonsDone();

  TimeOfDay _time = TimeOfDay.now();
  TextEditingController _adminName = TextEditingController();
  final db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: db.collection("Cancel Admissions").snapshots(),
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
                      "Total Admissions Cancel: ${data.length}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: ((context, index) {
                      return _buildAdmissionCancelCard(
                          context, index, snapshot);
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

  Widget _buildAdmissionCancelCard(context, int index, AsyncSnapshot snapshot) {
    var data = snapshot.data.docs;
    return Column(
      children: [
        Card(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * .30,
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
                  Text(
                    "Mobile: ${data[index].get('Contact Number')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Reference: ${data[index].get('Contact Number')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Standard: ${data[index].get('Purpose OR Admission')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Reason: ${data[index].get('Reason')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Admission Cancel By: ${data[index].get('Admin')}",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Date: ${data[index].get('Cancel Date')}",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Time: ${data[index].get('Cancel Time')}",
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
                          color: Colors.deepPurpleAccent,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(color: Colors.black),
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.backup,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            _backupDialog(context, snapshot, index);
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
                            Icons.delete,
                            size: 20,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            deleteEnuiry("${data[index].id}");
                          },
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
              borderSide: BorderSide(color: Colors.deepPurpleAccent, width: 1)),
        ),
      ],
    );
  }

  _backupDialog(context, AsyncSnapshot snapshot, index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "Are you sure?",
          style: TextStyle(
              fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
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
                        borderSide: BorderSide(color: Colors.blue, width: 2)),
                    labelText: "Your Name",
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blue,
                    ),
                    labelStyle: TextStyle(color: Colors.blue, fontSize: 15),
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
                _admissionBackup(context, snapshot, index);
              },
              child: Text("Confirm!")),
        ],
      ),
    );
  }

  _admissionBackup(context, AsyncSnapshot snapshot, index) {
    var data = snapshot.data.docs;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _admissonsDone.name = "${data[index].get("Visitor Name")}";
        _admissonsDone.number = "${data[index].get('Contact Number')}";
        _admissonsDone.date = currentDate;
        _admissonsDone.InTime = _time.format(context);
        _admissonsDone.purpose = "${data[index].get('Purpose OR Admission')}";
        // _admissonsDone.reference = "${data[index].get('Contact Number')}";
        // _admissonsDone.Address = widget.Address;
        // _admissonsDone.note = widget.note;
        _admissonsDone.adminName = _adminName.text;
      });
      db.collection("Admissions Done").add(_admissonsDone.toJson());
      AdmissonsCancel.admissionBackup(docId: "${data[index].id}");
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
              content: Text("Delete Admission permanently?"),
              actions: [
                TextButton(
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      AdmissonsCancel.admissionBackup(docId: id);
                      Navigator.pop(context);
                      final snackBar = SnackBar(
                        content: Text(
                          "Admission Deleted Successfully!",
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
}
