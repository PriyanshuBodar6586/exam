import 'package:exam/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/dbhelper.dart';


class Addproduct extends StatefulWidget {
  const Addproduct({Key? key}) : super(key: key);

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
 Home_controller home_controller = Get.put(Home_controller());
  TextEditingController ptxtName = TextEditingController();
  TextEditingController ptxtamount = TextEditingController();
  TextEditingController txtquntity = TextEditingController();


  void initState() {
    super.initState();
    getdata();
  }

  void getdata() async {
    Dbhelper db = Dbhelper();
    home_controller.productList.value = await db.readData();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("ADD product"),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ptxtName,
              decoration: InputDecoration(
                hintText: "Name",
                prefixIcon: Icon(Icons.production_quantity_limits),
                label: Text("Name"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.lightBlue)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: ptxtamount,
              decoration: InputDecoration(
                hintText: "amount",
                prefixIcon: Icon(Icons.monetization_on_sharp),
                label: Text("amount"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.lightBlue)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(keyboardType: TextInputType.numberWithOptions(),
              controller: txtquntity,
              decoration: InputDecoration(
                hintText: "quntity",
                prefixIcon: Icon(Icons.add),
                label: Text( "quntity"),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(width: 2, color: Colors.lightBlue)),
              ),
            ),
            SizedBox(height: 7),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Dbhelper db = Dbhelper();
                    db.insertData(
                        ptxtName.text,ptxtamount.text, txtquntity.text);

                    Get.back();
                    Get.snackbar("product data", "Save successfully");
                    getdata();
                  },
                  child: Text("Submit"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
