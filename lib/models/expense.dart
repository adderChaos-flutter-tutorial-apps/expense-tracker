// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMMMd();

enum ExpenseCategory { travel, leisure, food, work }

const categoryIcons = {
  ExpenseCategory.leisure: Icons.theater_comedy,
  ExpenseCategory.food: Icons.lunch_dining,
  ExpenseCategory.travel: Icons.flight_takeoff,
  ExpenseCategory.work: Icons.work,
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String title;
  final String id;
  final double amount;
  final DateTime date;
  final ExpenseCategory category;

  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({
    required this.category,
    required this.expenses,
  });

  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((element) => element.category == category)
            .toList();

  final ExpenseCategory category;
  final List<Expense> expenses;

  double get totalExpenses {
    return expenses.fold(
        0.0, (previousValue, element) => previousValue + element.amount);
  }
}
