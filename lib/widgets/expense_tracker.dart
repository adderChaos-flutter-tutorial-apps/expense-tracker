import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/create_new_expense.dart';
import 'package:expense_tracker/widgets/expense_list/expenses_list.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

class ExpensesTracker extends StatefulWidget {
  const ExpensesTracker({super.key});
  @override
  State<ExpensesTracker> createState() => _ExpenseTrackerState();
}

class _ExpenseTrackerState extends State<ExpensesTracker> {
  final List<Expense> _registeredExpenses = [
    Expense(
        title: "Flutter Course",
        amount: 420,
        date: DateTime.now(),
        category: ExpenseCategory.work),
    Expense(
        title: "Python Course",
        amount: 369,
        date: DateTime.now(),
        category: ExpenseCategory.work),
    Expense(
        title: "AI Course",
        amount: 404,
        date: DateTime.now(),
        category: ExpenseCategory.work),
    Expense(
        title: "Movie",
        amount: 170,
        date: DateTime.now(),
        category: ExpenseCategory.leisure),
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      constraints: const BoxConstraints.expand(),
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(onAddExpense: _addNewExpenseToList),
    );
  }

  void _addNewExpenseToList(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void _removeExpenseFromList(Expense expense) {
    final expenseIndex = _registeredExpenses.indexOf(expense);
    setState(() {
      _registeredExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 2),
      content: const Text('Expense deleted!!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          _registeredExpenses.insert(expenseIndex, expense);
          setState(() {});
        },
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Widget mainContent = _registeredExpenses.isEmpty
        ? const Center(
            child: Text('No expenses found. Plase add some!!'),
          )
        : ExpensesList(
            expenses: _registeredExpenses,
            onRemoveExpense: _removeExpenseFromList,
          );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Expense Tracker'),
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: screenWidth < 600
          ? Column(
              children: [
                Chart(expenses: _registeredExpenses),
                Expanded(child: mainContent),
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: _registeredExpenses)),
                Expanded(child: mainContent),
              ],
            ),
    );
  }
}
