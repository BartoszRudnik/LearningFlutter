class Transaction {
  String _id;
  String _title;
  double _amount;
  DateTime _transactionDate;

  String get id {
    return _id;
  }

  String get title {
    return _title;
  }

  double get amount {
    return _amount;
  }

  DateTime get transactionDate {
    return _transactionDate;
  }

  set id(String id) {
    this._id = id;
  }

  set title(String title) {
    this._title = title;
  }

  set amount(double amount) {
    this._amount = amount;
  }

  set transactionDate(DateTime transactionDate) {
    this._transactionDate = transactionDate;
  }

  Transaction(
    this._amount,
    this._id,
    this._title,
    this._transactionDate,
  );
}
