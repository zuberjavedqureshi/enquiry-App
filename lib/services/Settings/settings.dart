import 'package:enquiry_app/services/Settings/about.dart';
import 'package:enquiry_app/services/Settings/account.dart';
import 'package:enquiry_app/services/Settings/appearance.dart';
import 'package:enquiry_app/services/Settings/help.dart';
import 'package:enquiry_app/services/Settings/notifications.dart';
import 'package:enquiry_app/services/Settings/privacy.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<String> searchTerms = [
    "Accounts",
    "Notifications",
    "Appearance",
    "Privacy and Security",
    "Help and Support",
    "About",
  ];
  List<IconData> iconList = [
    Icons.person_outline,
    Icons.notifications_outlined,
    Icons.remove_red_eye_outlined,
    Icons.lock_outline,
    Icons.headset_mic_outlined,
    Icons.help_outline_sharp,
  ];
  List<Widget> pages = [
    UserAccounts(),
    NotificationsView(),
    Appearance(),
    PrivacyAndSecurity(),
    HelpAndSupport(),
    AboutUs(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: MediaQuery.of(context).size.width * .95,
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 3, color: Colors.white),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "Settings",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    GestureDetector(
                      onTap: () {
                        // showSearch(
                        //     context: context,
                        //     // delegate to customize the search bar
                        //     delegate: SearchBar());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * .90,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red, width: 2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            // Align(
                            //   alignment: Alignment.topLeft,
                            //   child: IconButton(
                            //     onPressed: () {
                            //     //   showSearch(
                            //     //       context: context,
                            //     //       // delegate to customize the search bar
                            //     //       delegate: SearchBar());
                            //     // },
                            //     icon: const Icon(
                            //       Icons.search,
                            //       size: 25,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Search for a settings....",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 20),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: searchTerms.length,
                          itemBuilder: ((context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                child: ListTile(
                                  leading: Icon(
                                    iconList[index],
                                    color: Colors.black,
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    pages[index]));
                                      },
                                      icon: Icon(
                                        Icons.arrow_circle_right_rounded,
                                        color: Colors.black,
                                      )),
                                  title: Text(
                                    searchTerms[index],
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            );
                          })),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
