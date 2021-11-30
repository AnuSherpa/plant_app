import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:plant_app/provider/myprovider.dart';
import 'package:plant_app/screens/about.dart';
import 'package:plant_app/screens/contact.dart';
import 'package:plant_app/screens/detail_screen.dart';
import 'package:plant_app/screens/login.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

int notification_counter = 0;
int flag = 0;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    if (flag == 0) {
      flag++;
      notiCounterFun();
    }
  }

  TextEditingController searchQuery = TextEditingController();

  Widget _buildSingleFeature({
    context,
    String plantTitle,
    String image,
    String plantSubTitle,
    String location,
    double rating,
    double price,
    String offer,
    String contact,
  }) {
    //print("----------->> inside SingleFeature build= " + contact);
    //print("--------->> $image");
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 30),
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            height: 250,
            width: 240,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  plantTitle,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                ),
                Text(
                  plantSubTitle,
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  //color: Colors.green,
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on_sharp,
                        color: Colors.yellow[600],
                      ),
                      SizedBox(width: 5.0),
                      Text(location),
                    ],
                  ),
                ),
                Container(
                  height: 30.0,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_ic_call,
                        color: Colors.yellow[600],
                      ),
                      SizedBox(width: 5.0),
                      Text(contact),
                    ],
                  ),
                ),
                Container(
                  //color: Colors.green,
                  height: 30,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.yellow[600],
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "$rating Ratings",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        "\Rs.$price",
                        style: TextStyle(
                            // color: Theme.of(context).accentColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        CircleAvatar(
          maxRadius: 50,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(image),
        ),
      ],
    );
  }

  Widget _buildSingleCategory({String image, String name}) {
    //print("--------->> $image");
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        //color: Colors.grey,
        height: 220,
        width: 160,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 160,
              width: 130,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      //color: Colors.green,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(image),
                      ),
                    ),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTopPart(context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16.0),
            bottomRight: Radius.circular(16.0),
          )),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.sort,
                    size: 35,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                Container(
                  height: 80.0,
                  width: 45.0,
                  //color: Colors.yellow,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        top: 0.0,
                        left: -8.0,
                        child: Align(
                          alignment: Alignment.topRight,
                          child: IconButton(
                            icon: Icon(
                              Icons.notifications,
                              size: 35,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              //FirebaseAuth.instance.signOut();
                              print("I have been pressed.");
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: (context) {
                                return OfferPage();
                              }));
                            },
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0.0,
                        left: 16.0,
                        child: Container(
                          width: 25,
                          height: 25,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white70,
                            ),
                            shape: BoxShape.circle,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text(
                              (notification_counter == 0)
                                  ? ""
                                  : notification_counter.toString(),
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            //color: Colors.yellow,
            margin: EdgeInsets.only(
              top: 15.0,
            ),
            //color: Colors.green,
            height: 120,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  maxRadius: 45,
                  backgroundColor: Color(0xff007500),
                  child: CircleAvatar(
                    maxRadius: 40,
                    backgroundImage: AssetImage("images/logo.png"),
                  ),
                ),
                Container(
                  height: 80,
                  width: 180,
                  child: ListTile(
                    title: Text(
                      "Look for your Desire",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Grenneries",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: 15.0, top: 0.0, left: 16.0, right: 16.0),
            padding: EdgeInsets.only(top: 0.0),
            child: TextFormField(
              controller: searchQuery,
              decoration: InputDecoration(
                fillColor: Color(0xffd3ffce),
                filled: true,
                hintText: "Search location",
                focusColor: Color(0xffb4eeb4),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search_sharp,
                    color: Color(0xffb4eeb4),
                  ),
                  onPressed: () {
                    if (searchQuery.text.isEmpty) {
                      FocusScope.of(context).requestFocus(FocusNode());
                      setState(() {
                        test = 0;
                        locations = "";
                      });
                    } else {
                      setState(() {
                        print("=========>> searchIcon Pressed <<========");
                        print(searchQuery.text);
                        locations = searchQuery.text;
                        FocusScope.of(context).requestFocus(FocusNode());
                        searchQuery.clear();
                      });
                    }
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  int test = 0;
  String locations = "";
  MyProvider myProvider;

  void notiCounterFun() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("homefeatureplant").get();

    querySnapshot.docs.forEach((featureData) {
      if (featureData.data()["offer"] != "") notification_counter++;
    });
  }

  Widget _buildFeatureProduct(context) {
    return Container(
      width: double.infinity,
      height: 230.0,
      //color: Colors.green,

      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: myProvider.getFeatureModelList.length,
          itemBuilder: (ctx, index) {
            for (int i = 0; i <= myProvider.getFeatureModelList.length; i++) {
              if (locations == myProvider.getFeatureModelList[index].location) {
                test = 1;
                //break;
              }
            }

            if (test == 1) {
              if (locations == myProvider.getFeatureModelList[index].location) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => DetailScreen(
                                plantTitle: myProvider
                                    .getFeatureModelList[index].plantTitle,
                                plantSubTitle: myProvider
                                    .getFeatureModelList[index].plantSubTitle,
                                image:
                                    myProvider.getFeatureModelList[index].image,
                                price:
                                    myProvider.getFeatureModelList[index].price,
                                contact: myProvider
                                    .getFeatureModelList[index].contact,
                              )));
                    },
                    child: _buildSingleFeature(
                      plantTitle:
                          myProvider.getFeatureModelList[index].plantTitle,
                      plantSubTitle:
                          myProvider.getFeatureModelList[index].plantSubTitle,
                      rating: myProvider.getFeatureModelList[index].rating,
                      price: myProvider.getFeatureModelList[index].price,
                      image: myProvider.getFeatureModelList[index].image,
                      location: myProvider.getFeatureModelList[index].location,
                      contact: myProvider.getFeatureModelList[index].contact,
                    ),
                  ),
                );
                locations = "";
              }
            } else if (test == 0) {
              //print("------->>> $locations");
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => DetailScreen(
                            plantTitle: myProvider
                                .getFeatureModelList[index].plantTitle,
                            plantSubTitle: myProvider
                                .getFeatureModelList[index].plantSubTitle,
                            image: myProvider.getFeatureModelList[index].image,
                            price: myProvider.getFeatureModelList[index].price,
                            contact:
                                myProvider.getFeatureModelList[index].contact,
                          )));
                },
                child: _buildSingleFeature(
                  plantTitle: myProvider.getFeatureModelList[index].plantTitle,
                  plantSubTitle:
                      myProvider.getFeatureModelList[index].plantSubTitle,
                  rating: myProvider.getFeatureModelList[index].rating,
                  price: myProvider.getFeatureModelList[index].price,
                  image: myProvider.getFeatureModelList[index].image,
                  location: myProvider.getFeatureModelList[index].location,
                  contact: myProvider.getFeatureModelList[index].contact,
                ),
              );
            }

            return Container();
          }),
    );
  }

  Widget _buildBottomPart(context) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 20),
      color: Color(0xff006400),
      child: Column(
        children: [
          SizedBox(
            height: 5.0,
          ),
          Container(
            //color: Colors.green,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Suggestion",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "see all",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            //color: Colors.green,
            width: double.infinity,
            height: 200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: myProvider.categoryModelList.length,
                    itemBuilder: (ctx, index) => _buildSingleCategory(
                        name: myProvider.getCategoryModelList[index].name,
                        image: myProvider.getCategoryModelList[index].image),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          Container(
            //color: Colors.grey,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "see all",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          _buildFeatureProduct(context),
        ],
      ),
    );
  }

  Widget _buildMyDrawer(context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("images/1.jpg"),
            ),
            accountName: Text("Diki Sherpa"),
            accountEmail: Text("dikisherpa0101@gmail.com"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: ListTile(
              leading: Icon(
                Icons.home,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("HomePage"),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => Contact(),
                ),
              );
            },
            leading: Icon(
              Icons.contact_phone,
              color: Theme.of(context).primaryColor,
              size: 30,
            ),
            title: Text("Contact Us"),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (ctx) => About(),
                ),
              );
            },
            leading: Icon(
              Icons.info,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("About Page"),
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              size: 30,
              color: Theme.of(context).primaryColor,
            ),
            title: Text("Order"),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => Login(),
              ));
            },
            child: ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
                color: Theme.of(context).primaryColor,
              ),
              title: Text("Logout"),
            ),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    myProvider = Provider.of<MyProvider>(context);
    myProvider.getCategoryProduct();
    myProvider.getFeatureProduct();

    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildMyDrawer(context),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            height: double.infinity,
            color: Color(0xff006400),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTopPart(context),
                  _buildBottomPart(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OfferPage extends StatefulWidget {
  const OfferPage({Key key}) : super(key: key);

  @override
  _OfferPageState createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  Widget _buildSingleFeature({
    context,
    String plantTitle,
    String image,
    String plantSubTitle,
    String location,
    double rating,
    double price,
    String offer,
    String contact,
  }) {
    //print("--------->> $image");
    return Row(
      children: [
        Container(
          height: 200,
          width: 110,
          padding: EdgeInsets.all(5.0),
          decoration: BoxDecoration(
              color: Colors.green, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Offer",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.red,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 15.0),
              Text(offer.toString(), style: TextStyle(fontSize: 15.0)),
            ],
          ),
        ),
        Stack(
          alignment: Alignment.topRight,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Container(
                decoration: BoxDecoration(
                    // color: Colors.blue,
                    borderRadius: BorderRadius.circular(30)),
                height: 230,
                width: 238,
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      plantTitle,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
                    ),
                    Text(
                      plantSubTitle,
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      //color: Colors.green,
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on_sharp,
                            color: Colors.yellow[600],
                          ),
                          SizedBox(width: 5.0),
                          Text(location),
                        ],
                      ),
                    ),
                    Container(
                      // color: Colors.green,
                      height: 50,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.yellow[600],
                          ),
                          Text(
                            "$rating Ratings",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 30.0,
                          ),
                          Text(
                            "Rs.$price",
                            style: TextStyle(
                                // color: Theme.of(context).accentColor,
                                fontSize: 17,
                                fontWeight: FontWeight.w900),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CircleAvatar(
              maxRadius: 50,
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(image),
            ),
          ],
        ),
      ],
    );
  }

  MyProvider myProvider1;
  @override
  Widget build(BuildContext context) {
    myProvider1 = Provider.of<MyProvider>(context);
    myProvider1.getFeatureProduct();

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Center(
                child: Text(
              "*** Just Grab it ***",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            )),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    top: 10.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 10.0,
                  ),
                  padding: EdgeInsets.only(top: 15.0),
                  width: double.infinity,
                  height: 200.0,
                  // color: Colors.green,
                  child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: myProvider1.getFeatureModelList.length,
                      itemBuilder: (ctx, index) {
                        if (myProvider1.getFeatureModelList[index].offer !=
                            "") {
                          return Card(
                            margin: EdgeInsets.only(top: 20.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16.0),
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                              plantTitle: myProvider1
                                                  .getFeatureModelList[index]
                                                  .plantTitle,
                                              plantSubTitle: myProvider1
                                                  .getFeatureModelList[index]
                                                  .plantSubTitle,
                                              image: myProvider1
                                                  .getFeatureModelList[index]
                                                  .image,
                                              price: myProvider1
                                                  .getFeatureModelList[index]
                                                  .price,
                                              contact: myProvider1
                                                  .getFeatureModelList[index]
                                                  .contact,
                                            )));
                              },
                              child: _buildSingleFeature(
                                plantTitle: myProvider1
                                    .getFeatureModelList[index].plantTitle,
                                plantSubTitle: myProvider1
                                    .getFeatureModelList[index].plantSubTitle,
                                rating: myProvider1
                                    .getFeatureModelList[index].rating,
                                price: myProvider1
                                    .getFeatureModelList[index].price,
                                image: myProvider1
                                    .getFeatureModelList[index].image,
                                location: myProvider1
                                    .getFeatureModelList[index].location,
                                contact: myProvider1
                                    .getFeatureModelList[index].contact,
                                offer: myProvider1
                                    .getFeatureModelList[index].offer,
                              ),
                            ),
                          );
                        } else {
                          return Container();
                        }
                      }),
                ),
              ),
            ],
          )),
    );
  }
}
