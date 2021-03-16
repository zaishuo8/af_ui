import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class IconExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AfPage(
      nav: AfNav(title: 'Icon 示例', pageContext: context),
      body: Container(
        child: SingleChildScrollView(
          child: Wrap(
            children: AfIcons.iconDataList.map((iconData) => Container(
              width: screenWidth / 3,
              height: screenWidth / 3,
              child: Center(
                child: Icon(iconData, size: AfFont.Size1, color: AfColor.Black2),
              ),
            )).toList(),
          ),
        ),
      ),
    );
  }

}
