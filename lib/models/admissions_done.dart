import 'package:cloud_firestore/cloud_firestore.dart';

class AdmissonsDone {
  String? name;
  String? number;
  String? date;
  String? InTime;
  String? purpose;
  String? reference;
  String? Address;
  String? admin;
  String? note;
  String? adminName;

  AdmissonsDone(
      {this.name,
      this.number,
      this.date,
      this.InTime,
      this.purpose,
      this.reference,
      this.Address,
      this.admin,
      this.note,
      this.adminName});

  Map<String, dynamic> toJson() => {
        'Visitor Name': name,
        'Contact Number': number,
        'Date': date,
        'In Time': InTime,
        'Purpose OR Admission': purpose,
        'Reference': reference,
        'Address': Address,
        'Incharge': admin,
        'Note': note,
        'Admin': adminName
      };

  static Future<void> updateAdmission(
      {String? docId,
      String? name,
      String? number,
      String? purpose,
      String? reference,
      String? admin,
      String? note,
      String? address}) async {
    final db = FirebaseFirestore.instance;
    DocumentReference _docRef = db.collection('Admissions Done').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      'Visitor Name': name,
      'Contact Number': number,
      'Purpose OR Admission': purpose,
      'Reference': reference,
      'Address': address,
      'Incharge': admin,
      'Note': note
    };

    await _docRef
        .update(data)
        .whenComplete(() => print("Admission updated successfully"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteAdmission({required String docId}) async {
    final db = FirebaseFirestore.instance;
    DocumentReference documentReference =
        db.collection("Admissions Done").doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Enquiry removed Successfully"))
        .catchError((e) => print(e));
  }
}
