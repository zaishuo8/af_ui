import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class SearchPlaceholderExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return AfPage(
      nav: AfNav(title: '搜索框示例', pageContext: context),
      body: Column(
        children: [
          AfSearchPlaceholder(
            onPressed: () { Navigator.pushNamed(context, '/search'); },
          ),
        ],
      ),
    );
  }

}

class SearchExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AfPage(
      body: Column(
        children: [
          AfSearch(
            allowClear: true,
            allowCancel: true,
            onCancelPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      )
    );
  }
}
