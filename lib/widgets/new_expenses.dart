import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker_app/model/expense.dart';

class NewExpenses extends StatefulWidget {
  const NewExpenses({Key? key, required this.onAddExpense}) : super(key: key);

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpenses> createState() => _NewExpensesState();
}

class _NewExpensesState extends State<NewExpenses> {
  // To store the latest input
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  // ? Make this variable can be null
  DateTime? _selectedDate;

  // Drop down didn't support the controller
  Category1 _selectedCategory = Category1.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    // This will show the 1 minus year in today
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    // To set date picker range
    // await explain the pickedDate value should be stored and it won't available immediately and it will wait until the pickedDate get the value
    // It will execute only when the value is available
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); //tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please fill all fied in the form'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: Text('Okay'))
          ],
        ),
      );
      // Use return to make sure that no code there after this function gets executed
      return; // To make sure if we get into the condition the code after return won't be execute
    }
    // widget is the way to access a function defined in the another page or widget.
    // Typically sending data or triggering an action in another page or widget.
    widget.onAddExpense(
      Expense(
          title: _titleController.text,
          amount: enteredAmount,
          date: _selectedDate!,
          category1: _selectedCategory),
    );
    Navigator.pop(context);
  }

// To delete the unneccessary controllers after use
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 80, 16, 30),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            // The maximum character
            maxLength: 50,
            // Input type
            // keyboardType: TextInputType.name,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    // The frontest of the form
                    prefixText: '\$ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(
                width: 18,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No date selected'
                        // ! This will told the _selectedDate is defenitely not gonna be null
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: () {
                        _presentDatePicker();
                      },
                      icon: const Icon(Icons.calendar_today),
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category1.values.map((category1) {
                    return DropdownMenuItem(
                      // Set it later for the onChanged
                      value: category1,
                      child: Text(
                        category1.name.toUpperCase(),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      // Use as to change the value type to match the type of variable
                      _selectedCategory = value as Category1;
                    });
                  }),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  print(_selectedDate);
                  print(_selectedCategory);
                  print(_titleController.text);
                  print(_amountController.text);
                  submitExpenseData();
                },
                child: const Text('Save Expenses'),
              ),
              SizedBox(
                width: 5,
              ),
              TextButton(
                  onPressed: () {
                    // To close the context
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }
}
