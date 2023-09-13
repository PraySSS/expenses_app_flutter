import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

// DateFormat.yMMMd().format(DateTime.now()) This is the normal way but we use getter for make it more performance
final formatter = DateFormat.yMd();
const uuid = Uuid();
enum Category1 { food, travel, leisure, work }

const category1Icons = {
  Category1.food: Icons.lunch_dining,
  Category1.travel: Icons.flight_takeoff,
  Category1.leisure: Icons.movie,
  Category1.work: Icons.work,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category1})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category1 category1;

  String get formattedDate {
    return formatter.format(date);
  }
}

// For the chart
// To store bucket for each category
class ExpenseBucket {
  const ExpenseBucket({required this.category1, required this.expenses});

  //  We separate the category for get the each data in this code
  ExpenseBucket.forCategory(List<Expense> allExpense, this.category1)
      : expenses = allExpense
            .where((expense) => expense.category1 == category1)
            .toList();

  final Category1 category1;
  final List<Expense> expenses;

  // Use getter to store all sum for calculate and show in chart and return as double
  double get totalExpenses {
    double sum = 0;
    // for-in is for iterate data for get data and then add the value in to the variable
    //                    We will go through all the item in expenses list and then store all variable to expense
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }

    return sum;
  }
}
