import 'package:cours_dsia/models/option.dart';
import 'package:cours_dsia/models/transaction.dart';
import 'package:cours_dsia/screens/scan_screen.dart';
import 'package:cours_dsia/screens/transaction_screen.dart';
import 'package:cours_dsia/utils/constants.dart';
import 'package:cours_dsia/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;

  @override
  void initState() {
    super.initState();
    setLocale();
  }

  setLocale() async {
    await Jiffy.setLocale('fr_ca');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: primaryColor,
            expandedHeight: 100,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isVisible
                        ? RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "1.000.000",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                  children: [
                                    TextSpan(
                                      text: "F",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600),
                                    )
                                  ])
                            ]),
                          )
                        : Text(
                            "•••••••••",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(
                      isVisible ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ),
            leading: IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  margin: EdgeInsets.only(right: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.sim_card,
                        color: Colors.black,
                        size: 16,
                      ),
                      SizedBox(
                        width: 2,
                      ),
                      Text(
                        "3673",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 1000,
              child: Stack(
                children: [
                  Container(
                    color: primaryColor,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25))),
                    margin: EdgeInsets.only(top: 100),
                  ),
                  Column(
                    children: [
                      CardWidget(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanScreen(),
                              ));
                        },
                      ),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: Option.listOption.length,
                        itemBuilder: (context, index) {
                          Option o = Option.listOption[index];
                          return optionWidget(
                              index: index,
                              color: o.color,
                              title: o.title,
                              icon: o.icon);
                        },
                      ),
                      Divider(
                        height: 5,
                        thickness: 5,
                        color: Colors.grey.withValues(alpha: 0.2),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 8),
                        physics: ClampingScrollPhysics(),
                        itemCount: Transaction.transList.length,
                        itemBuilder: (context, index) {
                          Transaction t = Transaction.transList[index];
                          return transWidget(
                              title: t.title,
                              amount: t.amount,
                              date: t.date,
                              type: t.type);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget optionWidget(
      {required Color color,
      required IconData icon,
      required String title,
      required index}) {
    return GestureDetector(
      onTap: () {
        if (index == 0 || index == 2) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TransactionScreen(index: index),
              ));
        }
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: color.withValues(alpha: .2),
                borderRadius: BorderRadius.circular(45)),
            padding: EdgeInsets.all(10),
            child: Icon(
              icon,
              color: color,
              size: 35,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

Widget transWidget(
    {required String title,
    required int amount,
    required DateTime date,
    required TType type}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${type == TType.envoi ? "À " : type == TType.reception ? "De " : ""}$title",
              style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              "${type == TType.envoi || type == TType.paiement || type == TType.retrait ? "-" : ""}${amount}F",
              style: TextStyle(
                  fontSize: 16,
                  color: primaryColor,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
        Text(
          Jiffy.parse(date.toString())
              .format(pattern: "dd MMMM yyyy à HH:mm")
              .toString(),
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}
