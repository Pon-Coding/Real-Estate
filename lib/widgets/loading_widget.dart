import 'package:blue_real_estate/constants/constants.dart';
import 'package:blue_real_estate/helpers/fonts/text_style_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  final String? percentage;
  const LoadingWidget({Key? key, this.percentage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: percentage == null
          ? const SpinKitSpinningLines(color: ColorConstants.primaryColor)
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SpinKitSpinningLines(color: ColorConstants.primaryColor),
                Text(
                  "${percentage.toString()} %",
                  style: TextStyleTheme()
                      .headline4(textColor: ColorConstants.primaryColor),
                ),
              ],
            ),
      // SpinKitDoubleBounce(
      //   color: ColorConstants.primaryColor,
      //   size: 100.0,
      // ),
    );
  }
}
