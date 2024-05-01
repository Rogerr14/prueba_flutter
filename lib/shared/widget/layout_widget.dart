import 'package:animate_do/animate_do.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:prueba_app/env/app_theme.dart';
import 'package:prueba_app/shared/providers/functional_provider.dart';
import 'package:prueba_app/shared/widget/alert_modal.dart';

class LayoutPageWidget extends StatefulWidget {
  const LayoutPageWidget({
    super.key,
    required this.child,
    this.keyDismissPage,
    required this.titleAppBar,
    this.requiredStack = true,
    this.nameInterceptor,
  });

  final Widget child;
  final bool requiredStack;
  final String titleAppBar;
  final GlobalKey<State<StatefulWidget>>? keyDismissPage;
  final String? nameInterceptor;

  @override
  State<LayoutPageWidget> createState() => _LayoutPageWidgetState();
}

class _LayoutPageWidgetState extends State<LayoutPageWidget> {
  ScrollController _scrollController = ScrollController();
  late FunctionalProvider fp;

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primaryColor,
      body: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: BounceInUp(
                  delay: const Duration(milliseconds: 100),
                  child: Container(
                    child: widget.child,
                  ),
                ),
              )
            ],
          ),
          // widget.child,
          if (widget.requiredStack) const AlertModal(),
        ],
      ),
    );
  }
}
