import 'package:expenses_tracker_app/widgets/expenses_list/expenses_item.dart';
import 'package:flutter/material.dart';
import 'package:expenses_tracker_app/model/expense.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {Key? key, required this.expenses, required this.onRemoveExpense})
      : super(key: key);

  final List<Expense> expenses;
  final void Function(Expense expense) onRemoveExpense;

  @override
  Widget build(BuildContext context) {
    //Use builder for show when they are visible
    // This function action is  create and return a widget that represents the item at the given index.
    // Must defind item count This property specifies the total number of items in your list
    return ListView.builder(
      itemCount: expenses.length,
      // This is a callback function that is responsible for building and returning the widget for each item in the list.
      // The index of the item being built. Use this index to fetch data from data source.
      // ctx=context
      itemBuilder: (ctx, index) {
        // For swipe and remove item
        return Dismissible(
          key: ValueKey(expenses[index]),

          background: Container(
            //                                          Can add red green blue and opacity to theme
            color: Theme.of(context).colorScheme.error.withOpacity(0.75),
            child: Icon(
              Icons.delete,
              color: Colors.white,
              size: 30,
            ),
            // Use the theme to custom the margin for make it can custom from 1 global variable
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          ),

          // Use for trigger the function when we swipe away
          onDismissed: (direction) {
            onRemoveExpense(expenses[index]);
          },
          // Access a single expense and passed the value as a value to ExpensesItem
          child: ExpensesItem(expenses[index]),
        );
      },
    );
  }
}
