import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:plant_app/provider/myprovider.dart';
import 'package:plant_app/screens/homepage.dart';
import 'package:plant_app/widget/mybutton.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DetailScreen extends StatefulWidget {
  String image, plantTitle, plantSubTitle, contact;
  double price;

  DetailScreen(
      {this.price,
      this.plantTitle,
      this.image,
      this.plantSubTitle,
      this.contact}) {
    print("---------------------- from inside constructor > $contact");
  }

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  Widget _buildSingleDetailText(
      {context,
      String title,
      String subsTitle,
      String tralingTitle,
      String tralingSubsTitle}) {
    return Container(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
              Text(
                tralingTitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                subsTitle,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w900),
              ),
              Text(
                tralingSubsTitle,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String number = "";
  int counter = 1;
  int totalPrice;

  @override
  Widget build(BuildContext context) {
    setState(() {
      totalPrice = widget.price.toInt() * counter;
      number = widget.contact;
    });

    return Scaffold(
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Color(0xfff8f8f8), //Color(0xfffef0f7),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    );
    body:
    Container(
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Container(
                    // color: Color(0xfffef0f7),
                    ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  width: double.infinity,
                  color: Color(0xfff8f8f8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 15.0,
                      ),
                      Container(
                        height: 160,
                        alignment: Alignment.center,
                        child: Text(
                          widget.plantTitle,
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        widget.plantSubTitle,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        height: 100,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "\$${totalPrice.toString()}",
                                  style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                      fontSize: 25,
                                      fontWeight: FontWeight.w900),
                                ),
                                Container(
                                  height: 35,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.lightBlue[100],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            counter++;
                                          });
                                        },
                                        child: Icon(
                                          Icons.add,
                                          size: 30,
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                      Text(
                                        counter.toString(),
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).accentColor,
                                            fontSize: 25,
                                            fontWeight: FontWeight.w900),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (counter > 1) {
                                            setState(() {
                                              counter--;
                                            });
                                          }
                                        },
                                        child: Icon(
                                          Icons.remove,
                                          size: 30,
                                          color: Theme.of(context).accentColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      _buildSingleDetailText(
                        context: context,
                        title: "Type",
                        subsTitle: "Herbaceous, perennial",
                        tralingTitle: "Indoor plant",
                        tralingSubsTitle: "",
                      ),
                      _buildSingleDetailText(
                        context: context,
                        title: "Soil Type",
                        subsTitle: "Loamy, well drained",
                        tralingTitle: "Sun Exposure",
                        tralingSubsTitle: "partial, shade",
                      ),
                      MyButton(
                        name: "Call",
                        onPressed: () async {
                          launch('tel://$number');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 70,
            child: Image(
                height: 260, width: 290, image: NetworkImage(widget.image)),
          ),
        ],
      ),
    );
  }
}
