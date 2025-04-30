import 'package:cours_dsia/models/option.dart';
import 'package:cours_dsia/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVisible = true;

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
                                  text: "100.000",
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
              height: 2000,
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
                      cardWidget(),
                      GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4),
                        shrinkWrap: true,
                        itemCount: Option.listOption.length,
                        itemBuilder: (context, index) {
                          Option o = Option.listOption[index];
                          return optionWidget(
                              color: o.color, title: o.title, icon: o.icon);
                        },
                      ),
                      Divider(
                        height: 5,
                        thickness: 5,
                        color: Colors.grey.withValues(alpha: 0.2),
                      )
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

  Widget cardWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 180,
          width: 280,
          decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  image: AssetImage(bgCard),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withValues(alpha: .3), BlendMode.srcIn)),
              borderRadius: BorderRadius.circular(15)),
          child: Center(
            child: Container(
              width: 120,
              height: 140,
              padding: EdgeInsets.symmetric(vertical: 6, horizontal: 4),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              child: Column(
                children: [
                  SizedBox(
                      height: 103,
                      child: PrettyQrView.data(
                        data: 'google.com',
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(roundFactor: .1),
                          quietZone: PrettyQrQuietZone.zero,
                        ),
                      )),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        size: 16,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Scanner")
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget optionWidget(
      {required Color color, required IconData icon, required String title}) {
    return Column(
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
    );
  }
}
