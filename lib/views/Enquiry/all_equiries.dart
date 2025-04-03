import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enquiry_app/views/Enquiry/view_enquiry.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AllEnquiries extends StatefulWidget {
  const AllEnquiries({Key? key}) : super(key: key);

  @override
  State<AllEnquiries> createState() => _AllEnquiriesState();
}

class _AllEnquiriesState extends State<AllEnquiries> {
  final db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: width,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.transparent,
                  child: Image(
                    image: AssetImage("images/1.png"),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      "AUSTER EDUCATION",
                      style: TextStyle(fontSize: 35, fontFamily: 'font'),
                    ),
                    Text("...an excellent choice for bright students",
                        style: TextStyle(fontSize: 15))
                  ],
                ),
              ],
            ),
          ),
        ),
        Divider(thickness: 2),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              "RECENT ENQUIRIES",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<QuerySnapshot>(
                stream: db
                    .collection("Enquiries")
                    .orderBy("CreatedAt", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: Text("Loading...."));
                  }

                  if (!snapshot.hasData) {
                    return Center(child: Text("Something went wrong."));
                  } else {
                    var data = snapshot.data!.docs;
                    return Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Total Enquiries: ${data.length}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: ListView.builder(
                                itemCount: data.length,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    child: _build(context, index, snapshot),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ViewEnquiry(
                                            id: "${data[index].id}",
                                            name:
                                                "${data[index].get('Visitor Name')}",
                                            number:
                                                "${data[index].get('Contact Number')}",
                                            date: "${data[index].get('Date')}",
                                            InTime:
                                                "${data[index].get('In Time')}",
                                            purpose:
                                                "${data[index].get('Purpose OR Admission')}",
                                            reference:
                                                "${data[index].get('Reference')}",
                                            Address:
                                                "${data[index].get('Address')}",
                                            admin:
                                                "${data[index].get('Incharge')}",
                                            note: "${data[index].get('Note')}",
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                })),
                          ),
                        ],
                      ),
                    );
                  }
                }),
          ),
        ),
      ],
    );
  }

  Widget _build(context, int index, AsyncSnapshot snapshot) {
    var screen = MediaQuery.of(context).size;
    var data = snapshot.data.docs;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              width: screen.width * .90,
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                border: Border.all(width: 2, color: Colors.red),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.person,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                      width: screen.width * .2,
                      child: Text(
                        "${data[index].get('Visitor Name')}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  SizedBox(
                    width: 5,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data[index].get('Date')}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        width: screen.width * .2,
                        child: Text(
                          "${data[index].get('Purpose OR Admission')}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: IconButton(
                      onPressed: () {
                        final Uri url = Uri.parse(
                            "tel://${data[index].get('Contact Number')}");
                        launchUrl(url);
                      },
                      icon: Icon(
                        Icons.phone_in_talk_outlined,
                        color: Colors.green[700],
                        size: 25,
                      ),
                    ),
                  ),
                  Container(
                    width: screen.width * .1,
                    child: IconButton(
                      onPressed: () async {
                        //var phone = "${data[index].get('Contact Number')}";
                        var url =
                            "whatsapp://send?phone=${data[index].get('Contact Number')}&text=Hello";
                        try {
                          final width = MediaQuery.of(context).size.width;

                          launchUrl(Uri.parse(url));
                          print(width);
                        } catch (e) {
                          print(e);
                        }
                      },
                      icon: Icon(
                        FontAwesomeIcons.whatsapp,
                        color: Colors.greenAccent[700],
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
