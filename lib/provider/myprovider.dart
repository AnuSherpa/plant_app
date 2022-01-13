import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:plant_app/model/category_model.dart';
import 'package:plant_app/model/feature_model.dart';

class MyProvider with ChangeNotifier {
  List<CategoryModel> categoryModelList = [];
  CategoryModel categoryModel;

  Future<void> getCategoryProduct() async {
    List<CategoryModel> list = [];
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("homecategory").get();

    querySnapshot.docs.forEach((categorydata) {
      categoryModel = CategoryModel(
        image: categorydata["image"],
        name: categorydata["name"],
      );

      list.add(categoryModel);
    });

    categoryModelList = list;
    notifyListeners();
  }

  List<CategoryModel> get getCategoryModelList {
    return categoryModelList;
  }

//plantTitle, plantSubTitle, image, price, rating;
  //------------------------------------------>> Retrieve Product <<-------------------------------------------------------------
  List<FeatureModel> featureModelList = [];
  FeatureModel featureModel;

  Future<void> getFeatureProduct() async {
    List<FeatureModel> list = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection("homefeatureplant").get();

    querySnapshot.docs.forEach((featuredata) {
      print("------------------->>" + featuredata["contact"]);
      featureModel = FeatureModel(
        plantTitle: featuredata["plantTitle"],
        plantSubTitle: featuredata["plantSubTitle"],
        image: featuredata["image"],
        price: featuredata["price"].toDouble(),
        rating: featuredata["rating"],
        location: featuredata["location"],
        offer: featuredata["offer"],
        contact: featuredata["contact"],
      );

      list.add(featureModel);
    });

    featureModelList = list;
    notifyListeners();
  }

  List<FeatureModel> get getFeatureModelList {
    return featureModelList;
  }

//------------------------------------------------------------------------------------------------------------------------------

}
