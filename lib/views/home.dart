import 'package:enquiry_app/utils/tabBar_widget.dart';
import 'package:enquiry_app/views/Admission/admission_cancel_view.dart';
import 'package:enquiry_app/views/Admission/admission_done_view.dart';
import 'package:enquiry_app/views/Enquiry/add_new_enquiry.dart';
import 'package:enquiry_app/views/Enquiry/all_equiries.dart';
import 'package:enquiry_app/services/Settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;

  final routes = <Widget>[
    AllEnquiries(),
    AdmissionDoneView(),
    AdmissionCancelView(),
    SettingsPage(),
  ];
  final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(
          "ENQUIRY APP",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: routes.elementAt(currentIndex),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.greenAccent[700],
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNewEnquiry(),
            ),
          );
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: MyTabBarView(
        index: currentIndex,
        changed: _onTapSelect,
      ),
    );
  }

  void _onTapSelect(int index) {
    setState(() {
      this.currentIndex = index;
    });
  }
}
