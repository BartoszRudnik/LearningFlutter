import 'dart:io';

import 'package:PersonalExpensesApp/models/transaction.dart';
import 'package:PersonalExpensesApp/widgets/chart.dart';
import 'package:PersonalExpensesApp/widgets/newTransaction.dart';
import 'package:PersonalExpensesApp/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _listOfTransactions = [];
  bool _showChart = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  int _dayDifference(DateTime today, DateTime transactionDate) {
    return today.difference(transactionDate).inDays;
  }

  List<Transaction> get _recentTrsansactions {
    return _listOfTransactions.where((transaction) {
      return _dayDifference(DateTime.now(), transaction.transactionDate) <= 7;
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime transactionDate, String transactionId) {
    if (transactionId != null) {
      setState(() {
        Transaction transaction = _listOfTransactions.firstWhere((element) => element.id == transactionId);

        transaction.amount = amount;
        transaction.title = title;
        transaction.transactionDate = transactionDate;
      });
    } else {
      final newUserTransaction = Transaction(
        amount,
        DateTime.now().toString(),
        title,
        transactionDate,
      );

      setState(() {
        _listOfTransactions.add(newUserTransaction);
      });
    }
  }

  void _startAddNewTransaction(BuildContext buildContext) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction(_addTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _listOfTransactions.removeWhere((element) => element.id == id);
    });
  }

  void _editTransaction(BuildContext buildContext, Transaction transaction) {
    showModalBottomSheet(
      context: buildContext,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransaction.edit(_addTransaction, transaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }

  List<Widget> _buildLandscapeContent(AppBar appBar, Widget transactionList) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.05,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Show chart',
              style: Theme.of(context).textTheme.headline6,
            ),
            Switch.adaptive(
              value: _showChart,
              onChanged: (value) {
                setState(
                  () {
                    _showChart = value;
                  },
                );
              },
            ),
          ],
        ),
      ),
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.75,
              child: Chart(_recentTrsansactions),
            )
          : transactionList,
    ];
  }

  List<Widget> _buildPortraitContent(AppBar appBar, Widget transactionList) {
    return [
      Container(
        height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.3,
        child: Chart(_recentTrsansactions),
      ),
      transactionList
    ];
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;

    final PreferredSizeWidget appBar = Platform.isAndroid
        ? AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add_circle),
                onPressed: () => _startAddNewTransaction(context),
              )
            ],
          )
        : CupertinoNavigationBar(
            middle: Text(
              'Personal Expenses',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add_circled_solid),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          );

    final transactionList = Container(
      height: (MediaQuery.of(context).size.height - appBar.preferredSize.height - MediaQuery.of(context).padding.top) * 0.7,
      child: Expanded(
        child: TransactionList(_listOfTransactions, _deleteTransaction, _editTransaction),
      ),
    );

    final pageBody = SafeArea(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (isLandscape)
              ..._buildLandscapeContent(
                appBar,
                transactionList,
              ),
            if (!isLandscape)
              ..._buildPortraitContent(
                appBar,
                transactionList,
              ),
          ],
        ),
      ),
    );

    return Platform.isAndroid
        ? Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isAndroid
                ? FloatingActionButton(
                    child: Icon(Icons.add_circle),
                    onPressed: () => _startAddNewTransaction(context),
                  )
                : Container(),
          )
        : CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          );
  }
}
