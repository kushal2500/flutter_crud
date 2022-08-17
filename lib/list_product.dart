import 'package:flutter/material.dart';
import 'package:flutter_crud_application/db.dart';
import 'package:flutter_crud_application/edit_product.dart';

class ListProduct extends StatefulWidget {
  const ListProduct({Key? key}) : super(key: key);

  @override
  State<ListProduct> createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  List<Map> Plist = [];
  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    getdata();
    super.initState();
  }

  getdata() {
    Future.delayed(const Duration(milliseconds: 000), () async {
      Plist = await mydb.db.rawQuery('SELECT * FROM products');
      Plist = Plist;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PRODUCTS LIST"),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Plist.length == 0
              ? Text("No Record Found!")
              : Column(
                  children: Plist.map((product) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(Icons.card_giftcard_outlined),
                        title: Text(product["name"]),
                        subtitle: Text("No:" +
                            product["pro_no"].toString() +
                            ", Desc : " +
                            product["description"]),
                        trailing: Wrap(
                          children: [
                            IconButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return EditProduct(
                                        prono: product["pro_no"]);
                                  }));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () async {
                                  await mydb.db.rawDelete(
                                      "DELETE FROM products WHERE pro_no = ?",
                                      [product["pro_no"]]);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text("Product Data Deleted")));
                                  getdata();
                                },
                                icon:
                                    const Icon(Icons.delete, color: Colors.red))
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ),
    );
  }
}
