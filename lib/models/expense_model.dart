import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formatter = DateFormat("dd/MM/yyyy");
const uuid = Uuid();

enum Category { food, travel, work, leisure,shopping }

const categoryIcons = {
  Category.food: Icons.dining_outlined,
  Category.leisure: Icons.sports_esports_outlined,
  Category.travel: Icons.flight_land_outlined,
  Category.work: Icons.work_outline,
  Category.shopping:Icons.shopping_bag_outlined,
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final Category category;

  String get dateFormatter {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  ExpenseBucket({required this.category, required this.expense});

  ExpenseBucket.forCategory(List<Expense> expenseList,  this.category)
      : expense = expenseList.where((element) {
        return element.category==category;
      }).toList();
   

  final Category category;
  final List<Expense> expense;
  double get totalExpense {
    double sum = 0;
    for (final e in expense) {
      sum += e.amount;
    }
    return sum;
  }
}
