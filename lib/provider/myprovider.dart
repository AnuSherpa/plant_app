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
        image: categorydata.data()["image"],
        name: categorydata.data()["name"],
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
      print("------------------->>" + featuredata.data()["contact"]);
      featureModel = FeatureModel(
        plantTitle: featuredata.data()["plantTitle"],
        plantSubTitle: featuredata.data()["plantSubTitle"],
        image: featuredata.data()["image"],
        price: featuredata.data()["price"].toDouble(),
        rating: featuredata.data()["rating"],
        location: featuredata.data()["location"],
        offer: featuredata.data()["offer"],
        contact: featuredata.data()["contact"],
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
