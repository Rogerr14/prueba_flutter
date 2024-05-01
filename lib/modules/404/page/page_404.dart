import 'package:flutter/material.dart';

import '../widget/page_404.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound
({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return drawerWidget404(context);
  }
}