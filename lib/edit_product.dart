import 'package:flutter/material.dart';
import 'package:flutter_crud_application/db.dart';

class EditProduct extends StatefulWidget {
  int prono;

  EditProduct({required this.prono});

  @override
  State<EditProduct> createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  TextEditingController name = TextEditingController();
  TextEditingController prono = TextEditingController();
  TextEditingController description = TextEditingController();

  MyDb mydb = MyDb();

  @override
  void initState() {
    mydb.open();

    Future.delayed(const Duration(milliseconds: 500), () async {
      var data = await mydb.getProduct(widget.prono);
      if (data != null) {
        prono.text = data["pro_no"].toString();
        name.text = data["name"];
        description.text = data["description"];
        setState(() {});
      } else {
        print("No any data with Product no: " + widget.prono.toString());
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Edit Product"),
        ),
        body: Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            children: [
              TextField(
                controller: name,
                decoration: const InputDecoration(
                  hintText: "Product Name",
                ),
              ),
              TextField(
                controller: prono,
                decoration: const InputDecoration(
                  hintText: "Product No.",
                ),
              ),
              TextField(
                controller: description,
                decoration: const InputDecoration(
                  hintText: "Description:",
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    mydb.db.rawInsert(
                        "UPDATE products SET pro_no = ?, name = ? , description = ? WHERE pro_no = ?",
                        [
                          prono.text,
                          name.text,
                          description.text,
                          widget.prono
                        ]);

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Product Data Updated")));
                  },
                  child: const Text("Update Product Data")),
            ],
          ),
        ));
  }
}
