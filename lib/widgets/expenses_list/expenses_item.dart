import 'package:flutter/material.dart';
import 'package:expenses_tracker_app/model/expense.dart';

class ExpensesItem extends StatelessWidget {
//                    This is work like parameter to get the specific data
  const ExpensesItem(this.expense, {Key? key}) : super(key: key);

// The Expense is a type from the model
  final Expense expense;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //                    Use custom style from mian
            Text(
              expense.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              // toStringAsFixed() is for limit digit number after . comma
              children: [
                Text('\$${expense.amount.toStringAsFixed(2)}'),
                // Spacer for make space between widget
                const Spacer(),
                Row(
                  children: [
                    Icon(category1Icons[expense.category1]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
