class Transaction {
  String title;
  int amount;
  DateTime date;
  TType type;

  Transaction(
      {required this.title,
      required this.amount,
      required this.date,
      required this.type});

  static List<Transaction> transList = [
    Transaction(
        title: "Modou FALL 777777777",
        amount: 10000,
        date: DateTime.now(),
        type: TType.envoi),
    Transaction(
        title: "Adama FALL 777777777",
        amount: 50000,
        date: DateTime.now(),
        type: TType.reception),
    Transaction(
        title: "Canal +",
        amount: 15000,
        date: DateTime.now(),
        type: TType.paiement),
    Transaction(
        title: "Cadeaux 500F",
        amount: 500,
        date: DateTime.now(),
        type: TType.cadeaux)
  ];
}

enum TType { retrait, envoi, reception, paiement, cadeaux, depot, credit }
