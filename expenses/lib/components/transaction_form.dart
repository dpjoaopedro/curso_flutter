import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();
  final valueController = TextEditingController();

  DateTime selectedDate;

  bool showDate = false;

  _submitForm() {
    final title = titleController.text;
    final value = double.tryParse(valueController.text);

    if (title.isEmpty || value <= 0 || selectedDate == null) return;

    widget.onSubmit(title, value, selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10.0 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: titleController,
                onSubmitted: (_) => _submitForm(),
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submitForm(),
                controller: valueController,
                decoration: InputDecoration(
                  labelText: 'Valor (R\$)',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: showDate
                          ? Text(
                              'Data: ${DateFormat.yMMMEd().format(selectedDate)}',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600]),
                            )
                          : Text(
                              'Data da transação',
                              style: TextStyle(
                                  fontSize: 16, color: Colors.grey[600]),
                            ),
                    ),
                    RaisedButton(
                      child: Icon(
                        Icons.calendar_today,
                      ),
                      onPressed: () async {
                        DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1994),
                            lastDate: DateTime(DateTime.now().year + 1));
                        if (picked != null)
                          setState(() {
                            selectedDate = picked;
                            showDate = true;
                          });
                      },
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 40),
                    child: FlatButton(
                        child: Text('Nova Transação'),
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        onPressed: _submitForm),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
