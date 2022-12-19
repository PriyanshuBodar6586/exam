import 'package:exam/view/add_product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/dbhelper.dart';
import '../controller/homecontroller.dart';
import '../model/data_model.dart';


class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  Home_controller home_controller = Get.put(Home_controller(),);
  TextEditingController ptxtName = TextEditingController();
  TextEditingController ptxtamount = TextEditingController();
  TextEditingController txtquntity = TextEditingController();

  Dbhelper db = Dbhelper();

  @override
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
          title: Text("Exam"),
          actions: [
            IconButton(onPressed: ()  {


            }, icon:Icon(Icons.add,size: 30,)),
          ],
          elevation: 00,
          primary: false,
          toolbarHeight: 70,
          backgroundColor: Colors.transparent,
          flexibleSpace: Container(
            margin: EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: Color(0xff2196F3),
                borderRadius: BorderRadius.circular(10)),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: home_controller.productList.value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(top: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffe8e8e8),
                      ),
                      child: InkWell(
                        onTap: (){
                          home_controller.Datapick=DataModel(
                            pname:home_controller.productList.value[index]['name'],
                            id:home_controller.productList.value[index]['id'].toString(),
                            amount :home_controller.productList.value[index]['amount'],
                            quntity:home_controller.productList.value[index]['quntity'],
                          );
                        },
                        child: ListTile(

                          title: Text(
                              "${home_controller.productList.value[index]['pname']}"),
                          subtitle: Text(
                              "${home_controller.productList.value[index]['quntity']}"),
                          trailing: Text(
                              "${home_controller.productList.value[index]['amount']}"),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),

        floatingActionButton: FloatingActionButton.extended(
          label: Row(
            children: [
              Icon(Icons.add),
              SizedBox(
                width: 5,
              ),
              Text("ADD NEW CUSTOMER")
            ],
          ),
          onPressed: () {
            Get.to(
              Addproduct(),
            );
          },
        ),


      ),
    );
  }
}
