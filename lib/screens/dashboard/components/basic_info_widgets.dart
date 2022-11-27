import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:admin/models/statistics_info.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'basic_info_card_widget.dart';

class BasicInfoWidgets extends StatelessWidget {
  const BasicInfoWidgets({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Basic info",
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.all(6),
                    alignment: Alignment.center,
                    width: 120,
                    decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(12)),
                    height: 52,
                    child: Text(
                      'Change theme',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                  onTap: () {
                    AdaptiveTheme.of(context).toggleThemeMode();
                  },
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: defaultPadding),
        Responsive(
          mobile: BasicInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
          ),
          tablet: BasicInfoCardGridView(),
          desktop: BasicInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class BasicInfoCardGridView extends StatelessWidget {
  const BasicInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demoMyFiles.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => BasicInfoCard(info: demoMyFiles[index]),
    );
  }
}
