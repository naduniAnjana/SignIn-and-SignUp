import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homebody extends StatefulWidget {
  const Homebody({super.key});

  @override
  State<Homebody> createState() => _HomebodyState();
}

class _HomebodyState extends State<Homebody> {
  String fname = '';

  @override
  void initState() {
    super.initState();
    _fetchFirstName();
  }

  Future<void> _fetchFirstName() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc;
        userDoc = await FirebaseFirestore.instance
            .collection('Clients')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          userDoc = await FirebaseFirestore.instance
              .collection('Counselors')
              .doc(user.uid)
              .get();
        }

        if (userDoc.exists) {
          final fName = userDoc.data()?['FirstName'];
          setState(() {
            fname = fName ?? '';
          });
        }
      }
    } catch (e) {
      print('Error fetching first name: $e');
      setState(() {
        fname = 'User';
      });
    }
  }

  void _updateFirstName(String newName) {
    setState(() {
      fname = newName;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 74, 204, 197),
        title: Row(
          children: [
            Text('Hello $fname',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  color: Color.fromARGB(255, 1, 64, 62),
                  fontFamily: 'Calistoga',
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            // child: IconButton(
            //   color:  Color(0x9AC44607),
            //   icon: Icon(Icons.notifications_active),
            //   onPressed:() {
            //     Navigator.push(context,
            //   MaterialPageRoute(builder: (context) =>  Application()));
            //   },
            // ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 0),
                // child: Center(
                //   child: LottieBuilder.asset(
                //     'assets/Animation - 1710863465634.json',
                //     height: 250,
                //     reverse: true,
                //     repeat: true,
                //     fit: BoxFit.cover,
                //   ),
                // ),
              ),
              const Padding(
                padding: EdgeInsets.only(
                    left: 0, bottom: 30.0, right: 190.0, top: 50),
                child: Text(
                  'Categories',
                  style: TextStyle(
                    color: Color.fromARGB(255, 75, 2, 81),
                    fontSize: 26,
                    fontFamily: 'Lalezar',
                  ),
                ),
              ),
              InkWell(
                // onTap: () {
                //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Workshops()));
                // },
                child: Ink(
                  height: height * .15,
                  width: width,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(1.5, 3),
                      ),
                    ],
                    image: const DecorationImage(
                        image: AssetImage('assets/dashboard.png'),
                        fit: BoxFit.fill),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        const Color.fromARGB(255, 25, 25, 112).withOpacity(0.7),
                        const Color.fromARGB(255, 93, 175, 203)
                            .withOpacity(0.7),
                      ]),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * .03, vertical: height * .02),
                          child: SizedBox(
                            width: width * .4,
                            child: const ListTile(
                              title: Text(
                                'Workshops',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Lalezar',
                                ),
                              ),
                              subtitle: Text(
                                "Upcoming workshops details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: EdgeInsets.only(right: width * .03),
                          child: SizedBox(
                            height: height * .10,
                            width: width * .3,
                            child: Image.asset(
                              "assets/work.png",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width * .06),
                child: InkWell(
                  // onTap: () {
                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Articles()));
                  // },
                  child: Ink(
                    height: height * .15,
                    width: width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(1.5, 3),
                        ),
                      ],
                      image: const DecorationImage(
                          image: AssetImage('assets/dashboard.png'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(255, 150, 0, 107)
                              .withOpacity(0.7),
                          const Color.fromARGB(255, 82, 198, 198)
                              .withOpacity(0.7),
                        ]),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * .03,
                                vertical: height * .02),
                            child: SizedBox(
                              width: width * .4,
                              child: const ListTile(
                                title: Text(
                                  'Articles',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Lalezar',
                                  ),
                                ),
                                subtitle: Text(
                                  "Articles related to handicraft",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: width * .03),
                            child: SizedBox(
                              height: height * .10,
                              width: width * .3,
                              child: Image.asset(
                                "assets/articles.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: width * .06),
                child: InkWell(
                  // onTap: () {
                  //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> const Images()));
                  // },
                  child: Ink(
                    height: height * .15,
                    width: width,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(1.5, 3),
                        ),
                      ],
                      image: const DecorationImage(
                          image: AssetImage('assets/dashboard.png'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color.fromARGB(234, 28, 12, 131)
                              .withOpacity(0.7),
                          const Color.fromARGB(255, 192, 79, 223)
                              .withOpacity(0.7),
                        ]),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: width * .03,
                                vertical: height * .02),
                            child: SizedBox(
                              width: width * .4,
                              child: const ListTile(
                                title: Text(
                                  'Images',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Lalezar',
                                  ),
                                ),
                                subtitle: Text(
                                  "Colorful images collection",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(),
                          Padding(
                            padding: EdgeInsets.only(right: width * .03),
                            child: SizedBox(
                              height: height * .15,
                              width: width * .3,
                              child: Image.asset(
                                "assets/lamp.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
