import 'package:equations/equations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud_application/add_product.dart';
import 'package:flutter_crud_application/chart.dart';
import 'package:flutter_crud_application/list_product.dart';
import 'dart:developer';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController a = TextEditingController();
  TextEditingController b = TextEditingController();
  TextEditingController c = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("F L U T T E R  C U R D"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const AddProduct();
              }));
            },
            child: const Text("Add Product for Sale"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const ListProduct();
              }));
            },
            child: const Text("List Product"),
          ),
          Text('What are the solutions of the liener equation '),
          Text('ax+by = 30'),
          TextField(
            controller: a,
            decoration: const InputDecoration(
              hintText: "A value",
            ),
          ),
          TextField(
            controller: b,
            decoration: const InputDecoration(
              hintText: "B value",
            ),
          ),
          ElevatedButton(
              onPressed: () {
                solution(int.parse(a.text), int.parse(b.text), 30);
              },
              child: const Text("SOLVE")),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Chart()),
                );
                // solution(int.parse(a.text), int.parse(b.text), 30);
              },
              child: const Text("Show in Chart")),
          TextField(
            controller: c,
            decoration: const InputDecoration(
              hintText: "RESULT",
            ),
          ),
        ]),
      ),
    );
  }

  void solution(int a, int b, int n) {
    for (var i = 0; i * a <= n; i++) {
      if ((n - (i * a)) % b == 0) {
        var j = n - (i * a) / b;
        print("x = $i , y=$j");
        //  (n - (i * a)) / b);
        setState(() {
          c.text = c.text + "x = $i , y=$j";
        });
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("TRUE")));
        return;
      }
    }
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("FALSE")));
  }
}
