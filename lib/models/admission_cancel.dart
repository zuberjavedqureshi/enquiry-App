import 'package:cloud_firestore/cloud_firestore.dart';

class AdmissonsCancel {
  String? name;
  String? number;
  String? cancelDate;
  String? cancelTime;
  String? purpose;
  String? reference;

  String? reason;
  String? adminName;

  AdmissonsCancel({
    this.name,
    this.number,
    this.purpose,
    this.reference,
    this.reason,
    this.adminName,
    this.cancelDate,
    this.cancelTime,
  });

  Map<String, dynamic> toJson() => {
        'Visitor Name': name,
        'Contact Number': number,
        'Purpose OR Admission': purpose,
        'Reference': reference,
        'Reason': reason,
        'Admin': adminName,
        'Cancel Date': cancelDate,
        'Cancel Time': cancelTime,
      };

  static Future<void> admissionBackup({required String docId}) async {
    final db = FirebaseFirestore.instance;
    DocumentReference documentReference =
        db.collection("Cancel Admissions").doc(docId);

    await documentReference
        .delete()
        .whenComplete(() => print("Enquiry removed Successfully"))
        .catchError((e) => print(e));
  }
}
