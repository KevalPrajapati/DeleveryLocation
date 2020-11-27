import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mapapi/Selectlocation.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

Firestore _db = Firestore.instance;
List<DocumentSnapshot> posts;

Widget driver = Text(
  "No Driver is assigned",
  style: TextStyle(
    color: Colors.red,
  ),
);
bool locationgiven = false;

class _OrdersState extends State<Orders> {
  bool isLoading = false;

  _fetchPosts() async {
    try {
      QuerySnapshot snap = await _db
          .collection("orders")
          .where("customerphone", isEqualTo: "123456789")
          .getDocuments();
      setState(() {
        posts = snap.documents;
        print("driver=" + posts[0].data["driverassigned"]);
        if (posts[0].data["driverassigned"] == "nun") {
          driver = Text(
            "No Driver is assigned",
            style: TextStyle(
              color: Colors.red,
            ),
          );
        } else {
          driver = Text(
            posts[0].data["driverassigned"].toString(),
            style: TextStyle(
                // color: Colors.red,
                ),
          );
        }

        locationgiven = posts[0].data["locationprovided"];
        print(locationgiven);
        // posts[0].data["driverassigned"]=="nun"??driver= posts[0].data["driverassigned"];
        isLoading = false;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchPosts();
  }

  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Orders"),
      ),
      body: ListView(children: [
        // Card(
        //   child: Row(
        //     children: [
        //       ClipRRect(
        //           borderRadius: BorderRadius.circular(170),
        //           child: Image(
        //             image:
        //                 NetworkImage(posts[0].data["productImage"], scale: 6),
        //           )),
        //       // Image.network(posts[0].data["productImage"]),
        //       Column(
        //         children: [
        //           Text("Super cool Headphones"),
        //           Text("500"),
        //         ],
        //       ),
        //     ],
        //   ),
        // )
        Card(
          // color: Color(0xFF2d2d2d),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            children: [
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox(
                            // height: 40,
                            // width: 40,
                            child: Image(
                              image: NetworkImage(posts[i].data["productImage"],
                                  scale: 6),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      posts[i].data["productname"] ?? " No Title",
                      style: TextStyle(
                          // color: Color.fromRGBO(255, 255, 255, 100),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Rs." + "500",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50),
              ),
              Column(children: [
                driver,
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MapSample(
                                  phone: posts[i].data["customerphone"],
                                )));
                  },
                  child:
                      Text(locationgiven ? "Update Location" : "Give location"),
                )
              ]),
            ],
          ),
        ),
      ]),
    );
  }
}
