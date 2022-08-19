import 'package:flutter/material.dart';
import 'package:flutter_crud_application/db.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController pro_no = TextEditingController();
  TextEditingController description = TextEditingController();
  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Add Product for sale"),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: pro_no,
                decoration: const InputDecoration(
                  hintText: "Product No",
                ),
              ),
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Product Name",
                ),
              ),
              TextField(
                controller: description,
                decoration: const InputDecoration(
                  hintText: "Description",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "INSERT INTO products (pro_no, name, description) VALUES (?, ?, ?);",
                        [pro_no.text, name.text, description.text]);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("New Product Added")));

                    name.text = "";
                    pro_no.text = "";
                    description.text = "";
                  },
                  child: const Text("SAVE PRODUCT")),
            ],
          ),
        ));
  }
}
