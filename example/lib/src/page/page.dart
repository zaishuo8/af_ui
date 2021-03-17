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
                    title: '空页面',
                    onPressed: () { Navigator.pushNamed(context, '/page_fault_empty'); },
                  ),
                  AfListItem(
                    title: '异常页面',
                    onPressed: () { Navigator.pushNamed(context, '/page_fault_error'); },
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

class PageFaultErrorExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '异常页面', pageContext: context),
      fault: AfFault.error(),
    );
  }
}

class PageFaultEmptyExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AfPage(
      nav: AfNav(title: '空页面', pageContext: context),
      fault: AfFault.empty(description: '空页面空页面空页面空页面空页面空页面空页面空页面空页面空页面'),
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
