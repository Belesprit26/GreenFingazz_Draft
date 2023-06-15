import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:green_sellers/Item_Screen/item_screen.dart';
import 'package:green_sellers/Splash_Screen/splash_screen.dart';
import 'package:green_sellers/global/global.dart';
import 'package:green_sellers/models/brands.dart';

class BrandsUiDesignWidget extends StatefulWidget {
  Brands? model;
  BuildContext? context;

  BrandsUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<BrandsUiDesignWidget> createState() => _BrandsUiDesignWidgetState();
}

class _BrandsUiDesignWidgetState extends State<BrandsUiDesignWidget> {
  deleteBrand(String brandUniqueID) {
    FirebaseFirestore.instance
        .collection("sellers")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(brandUniqueID)
        .delete();

    Fluttertoast.showToast(msg: "Brand Deleted.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (c) => ItemsScreen(
                      model: widget.model,
                    )));
      },
      child: Card(
        margin: const EdgeInsets.only(top: 20.0, left: 18, right: 18),
        color: Color(0xFFFFA000),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        elevation: 10,
        shadowColor: Colors.black,
        child: Stack(children: [
          Padding(
            padding: const EdgeInsets.all(4),
            child: SizedBox(
              height: 200,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.network(
                        widget.model!.thumbnailUrl.toString(),
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  Expanded(
                      flex: 3,
                      child: Center(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: Text(
                                  widget.model!.brandTitle.toString(),
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                            ]),
                      )),
                ],
              ),
            ),
          ),
          Positioned(
            top: 15,
            right: 15,
            child: Container(
              decoration: const ShapeDecoration(
                  color: Color(0xFFFF6F00),
                  shape: CircleBorder(),
                  shadows: [
                    BoxShadow(
                        color: Colors.black,
                        blurRadius: 3,
                        offset: Offset(1, 3))
                  ]),
              child: IconButton(
                icon: const Icon(Icons.delete_outlined),
                color: Colors.black,
                onPressed: () {
                  deleteBrand(widget.model!.brandID.toString());
                },
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
