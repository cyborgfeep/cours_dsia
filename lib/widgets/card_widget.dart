import 'package:cours_dsia/screens/scan_screen.dart';
import 'package:cours_dsia/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CardWidget extends StatefulWidget {
  const CardWidget(
      {super.key,
      this.isVertical = false,
      this.onPressed,
      this.height,
      this.width});
  final double? height;
  final double? width;
  final bool isVertical;
  final VoidCallback? onPressed;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed ?? () {},
      child: RotatedBox(
        quarterTurns: widget.isVertical ? 1 : 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: widget.height ?? 180,
              width: widget.width ?? 280,
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
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      widget.isVertical
                          ? SizedBox.shrink()
                          : Row(
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
        ),
      ),
    );
  }
}
