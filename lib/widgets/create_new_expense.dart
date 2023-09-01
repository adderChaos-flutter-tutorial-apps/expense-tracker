import 'package:flutter/material.dart';

import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  ExpenseCategory _selectedCategory = ExpenseCategory.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController
        .text); // tryParse('Hello') => null, tryParse('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text(
              'Please make sure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            ),
          ],
        ),
      );
      return;
    }

    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    prefixText: '₹ ',
                    label: Text('Amount'),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date selected'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(
                        Icons.calendar_month,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: ExpenseCategory.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(
                          category.name.toUpperCase(),
                        ),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = value;
                  });
                },
              ),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text('Save Expense'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}







// import 'package:expense_tracker/models/expense.dart';
// import 'package:flutter/material.dart';

// enum WidgetName {
//   enterTitle,
//   enterAmount,
//   verticalSpacing,
//   horizontalSpacing,
//   chooseCategory,
//   datePicker,
//   actionsRow
// }

// class CreateNewExpense extends StatefulWidget {
//   const CreateNewExpense(this.onAddExpense, {super.key});

//   final void Function(Expense) onAddExpense;

//   @override
//   State<CreateNewExpense> createState() => _CreateNewExpenseState();
// }

// class _CreateNewExpenseState extends State<CreateNewExpense> {
//   final _titleController = TextEditingController();
//   final _amountController = TextEditingController();
//   ExpenseCategory _selectedCategory = ExpenseCategory.leisure;
//   DateTime? _selectedDate;

//   void _presentDatePicker() async {
//     final now = DateTime.now();
//     final firstDate = DateTime(now.year - 1, now.month, now.day);
//     final pickedDate = await showDatePicker(
//         context: context,
//         initialDate: now,
//         firstDate: firstDate,
//         lastDate: now);
//     setState(() {
//       _selectedDate = pickedDate;
//     });
//   }

//   void _submitResponse() {
//     final enteredAmount = double.tryParse(_amountController.text);
//     if (_titleController.text.trim().isEmpty ||
//         enteredAmount == null ||
//         enteredAmount <= 0 ||
//         _selectedDate == null) {
//       showDialog(
//         context: context,
//         builder: ((ctx) => AlertDialog(
//               title: const Text('Invalid Input'),
//               content: const Text('Please enter valid title, amount and date'),
//               actions: [
//                 TextButton(
//                   onPressed: () {
//                     Navigator.pop(ctx);
//                   },
//                   child: const Text('Okay'),
//                 )
//               ],
//             )),
//       );
//       return;
//     }
//     final newExpense = Expense(
//         title: _titleController.text.trim(),
//         amount: enteredAmount,
//         date: _selectedDate!,
//         category: _selectedCategory);

//     widget.onAddExpense(newExpense);
//     Navigator.pop(context);
//   }

//   @override
//   void dispose() {
//     _titleController.dispose();
//     super.dispose();
//   }

//   Widget getWidget(WidgetName name) {
//     switch (name) {
//       case WidgetName.enterTitle:
//         return TextField(
//           controller: _titleController,
//           maxLength: 50,
//           decoration: const InputDecoration(label: Text('Title')),
//         );
//       case WidgetName.enterAmount:
//         return TextField(
//           controller: _amountController,
//           keyboardType: TextInputType.number, //WithOptions(decimal: true),
//           decoration: const InputDecoration(
//             prefixText: '₹',
//             label: Text('Amount'),
//           ),
//         );
//       case WidgetName.chooseCategory:
//         return DropdownButton(
//           value: _selectedCategory,
//           items: ExpenseCategory.values
//               .map((category) => DropdownMenuItem(
//                   value: category, child: Text(category.name.toUpperCase())))
//               .toList(),
//           onChanged: (value) {
//             if (value == null) {
//               return;
//             }
//             setState(() {
//               _selectedCategory = value;
//             });
//           },
//         );
//       case WidgetName.verticalSpacing:
//         return const SizedBox(height: 20);
//       case WidgetName.horizontalSpacing:
//         return const SizedBox(width: 20);
//       case WidgetName.datePicker:
//         return Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text(
//               _selectedDate == null
//                   ? 'No Date selected'
//                   : formatter.format(_selectedDate!),
//             ),
//             IconButton(
//               onPressed: _presentDatePicker,
//               icon: const Icon(Icons.calendar_month),
//             ),
//           ],
//         );
//       case WidgetName.actionsRow:
//         return Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: const Text('Cancel')),
//             ElevatedButton(
//                 onPressed: _submitResponse, child: const Text('Save Expense'))
//           ],
//         );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

//     return LayoutBuilder(builder: (ctx, constraints) {
//       final maxWidth = constraints.maxWidth;
//       return SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
//           child: maxWidth >= 600
//               // Wide Layout
//               ? Column(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Expanded(
//                           child: getWidget(WidgetName.enterTitle),
//                         ),
//                         getWidget(WidgetName.horizontalSpacing),
//                         Expanded(
//                           child: getWidget(WidgetName.enterAmount),
//                         ),
//                       ],
//                     ),
//                     getWidget(WidgetName.verticalSpacing),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: getWidget(WidgetName.chooseCategory),
//                         ),
//                         getWidget(WidgetName.horizontalSpacing),
//                         Expanded(
//                           child: getWidget(WidgetName.datePicker),
//                         ),
//                       ],
//                     ),
//                     getWidget(WidgetName.verticalSpacing),
//                     getWidget(WidgetName.actionsRow),
//                   ],
//                 )
//               : Column(
//                   children: [
//                     getWidget(WidgetName.enterTitle),
//                     getWidget(WidgetName.verticalSpacing),
//                     Row(
//                       children: [
//                         Expanded(
//                           child: getWidget(WidgetName.enterAmount),
//                         ),
//                         getWidget(WidgetName.horizontalSpacing),
//                         Expanded(
//                           child: getWidget(WidgetName.datePicker),
//                         ),
//                       ],
//                     ),
//                     getWidget(WidgetName.verticalSpacing),
//                     Row(
//                       children: [
//                         getWidget(WidgetName.chooseCategory),
//                         const Spacer(),
//                         getWidget(WidgetName.actionsRow),
//                       ],
//                     )
//                   ],
//                 ),
//         ),
//       );
//     });
//   }
// }
