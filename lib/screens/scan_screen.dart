import 'package:camera/camera.dart';
import 'package:cours_dsia/main.dart';
import 'package:cours_dsia/widgets/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  late CameraController cameraController;
  PageController pageController = PageController();
  bool isFlashOn = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    cameraController = CameraController(cameras[0], ResolutionPreset.max);
    cameraController.initialize().then(
      (value) {
        if (!mounted) {
          return;
        }
        setState(() {});
      },
    ).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Stack(
      children: [
        PageView(
          controller: pageController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            cameraViewWidget(),
            Container(
              color: Colors.white,
              child: CardWidget(
                width: 500,
                height: 300,
                isVertical: true,
              ),
            )
          ],
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: ToggleSwitch(
              minWidth: MediaQuery.of(context).size.width - 120,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.grey],
                [Colors.white]
              ],
              activeFgColor: selectedIndex == 1 ? Colors.black : Colors.white,
              inactiveBgColor: selectedIndex == 0 ? Colors.black : Colors.grey,
              inactiveFgColor: selectedIndex == 0 ? Colors.white : Colors.black,
              initialLabelIndex: selectedIndex,
              totalSwitches: 2,
              labels: ['Scanner un code', 'Ma carte'],
              radiusStyle: true,
              onToggle: (index) {
                setState(() {
                  selectedIndex = index!;
                });
                pageController.jumpToPage(selectedIndex);
              },
            ),
          ),
        ),
      ],
    )));
  }

  Widget cameraViewWidget() {
    return Stack(
      children: [
        AspectRatio(
            aspectRatio: MediaQuery.of(context).size.aspectRatio,
            child: CameraPreview(cameraController)),
        ColorFiltered(
          colorFilter: ColorFilter.mode(
              Colors.black.withValues(alpha: 0.3), BlendMode.srcOut),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.black,
                    backgroundBlendMode: BlendMode.dstOut),
              ),
              Center(
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 350),
          child: Text(
            "Scanner le QR code pour payer",
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: Icon(
                  isFlashOn ? Icons.flash_on : Icons.flash_off,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isFlashOn = !isFlashOn;
                    cameraController.setFlashMode(
                        isFlashOn ? FlashMode.torch : FlashMode.off);
                  });
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
