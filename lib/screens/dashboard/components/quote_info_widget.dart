import 'package:admin/utils/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';

class QuoteDetails extends StatelessWidget {
  const QuoteDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 36),
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: primaryLightColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Jack Robinson",
            style: getTextStyle(),
          ),
          Padding(
            padding: EdgeInsets.all(12),
          ),
          Text(
            "Life is made of ever so many partings welded together.",
            style: getTextStyle(),
          ),
          SizedBox(height: 200),
          Row(
            children: [
              Spacer(),
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  'assets/icons/Documents.svg',
                  color: Colors.white60,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Container(
                padding: EdgeInsets.all(defaultPadding * 0.75),
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: SvgPicture.asset(
                  'assets/icons/Documents.svg',
                  color: Colors.white60,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
