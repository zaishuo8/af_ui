import 'package:flutter/widgets.dart';
import 'package:af_ui/af_ui.dart';

class PageControllerExample extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '页面容器示例', pageContext: context),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: AfLayout.ModuleMarginVertical),
          child: AfList(
            children: <Widget>[
              AfListGroup(
                children: [
                  AfListItem(
                    title: '普通页面',
                    onPressed: () { Navigator.pushNamed(context, '/page'); },
                  ),
                  AfListItem(
                    title: '异常页面',
                    onPressed: () { Navigator.pushNamed(context, '/page_fault'); },
                  ),
                  AfListItem(
                    title: '骨架屏',
                    onPressed: () { Navigator.pushNamed(context, '/page_skeleton'); },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PageExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '普通页面', pageContext: context),
      body: Center(
        child: Text('普通页面', style: AfFont.defaultStyle.copyWith(
          color: AfColor.Black3,
          fontSize: AfFont.Size3,
        )),
      ),
    );
  }
}

class PageFaultExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '异常页面', pageContext: context),
      fault: AfFault.error(),
    );
  }
}

class PageSkeletonExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '骨架屏', pageContext: context),
      skeleton: AfSkeleton.list(),
    );
  }
}
