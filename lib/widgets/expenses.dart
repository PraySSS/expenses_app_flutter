import 'package:expenses_tracker_app/widgets/new_expenses.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_tracker_app/model/expense.dart';
import 'package:expenses_tracker_app/widgets/chart/chart.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  // Use final instead of const becuase we will still be able to add new values
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category1: Category1.work,
    ),
    Expense(
      title: 'Kotlin Course',
      amount: 20.234,
      date: DateTime.now(),
      category1: Category1.work,
    )
  ];
// _ underscore is make the the variable private should not accessed or modified from outside
  void _openAddExpensesOverlay() {
    showModalBottomSheet(
        // To show modal full screen
        isScrollControlled: true,
        context: context,
        builder: (ctx) {
          return NewExpenses(onAddExpense: _addExpense);
        });
  }

  void _addExpense(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

// Must use when dismiss data this will remove the internal data and on dismissible remove from screen
  void _removeExpense(Expense expense) {
    // Assign the lates index to this variable
    final expenseIndex = _registeredExpenses.indexOf(expense);

    setState(() {
      _registeredExpenses.remove(expense);
    });
    // To clear the previous snackbar before new snackbar
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(
              () {
                //                         Index number, content
                _registeredExpenses.insert(expenseIndex, expense);
              },
            );
          },
          textColor: Theme.of(context).colorScheme.onPrimary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Use this way to check the item is empty or not
    Widget mainContent = const Center(
      child: Text('No expense found. Start adding some!'),
    );
    if (_registeredExpenses.isNotEmpty) {
      mainContent = ExpensesList(
        expenses: _registeredExpenses,
        onRemoveExpense: _removeExpense,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses traker'),
        actions: [
          IconButton(
            onPressed: () {
              _openAddExpensesOverlay();
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Chart(expenses: _registeredExpenses),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
