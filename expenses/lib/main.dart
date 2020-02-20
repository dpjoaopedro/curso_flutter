import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main() => runApp(ExpensesApp());

class ExpensesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  final _transactions = [
    Transaction(
      id: 't1',
      title: 'Novo Tênis de Corrida',
      value: 310.76,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'Conta de Luz',
      value: 50.99,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var _transactionsWidget = _transactions.map((transaction) {
      return Card(
        child: Row(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.purple, width: 2)),
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              child: Text(
                'R\$ ${transaction.value.toStringAsFixed(2)}',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.purple),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  transaction.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Text(
                  transaction.date.toString(),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            )
          ],
        ),
      );
    }).toList();

    return Scaffold(
        appBar: AppBar(
          title: Text("Despesas Pessoais"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 150,
              child: Card(
                child: Text(
                  "Gráfico",
                  textAlign: TextAlign.center,
                ),
                color: Colors.blue,
                elevation: 5,
              ),
            ),
            Column(
              children: _transactionsWidget,
            )
          ],
        ));
  }
}
