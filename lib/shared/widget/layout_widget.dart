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
  void initState() {
    BackButtonInterceptor.add(_backButton,
        name: widget.nameInterceptor, context: context);
    _scrollController = ScrollController();
    fp = Provider.of<FunctionalProvider>(context, listen: false);

    super.initState();
  }

  @override
  void dispose() {
    BackButtonInterceptor.removeByName(widget.nameInterceptor.toString());
    super.dispose();
  }

  Future<bool> _backButton(bool button, RouteInfo info) async {
    if (widget.nameInterceptor != null) {
      final fp = Provider.of<FunctionalProvider>(context, listen: false);
      if (mounted) {
        if (button) return false;
        if (fp.alertLoading.isNotEmpty ||
            (fp.alerts.last.key != widget.keyDismissPage)) {
          if (fp.closeAlertBack.isNotEmpty &&
              fp.closeAlertBack.last &&
              fp.keysAlerts.isNotEmpty) {
            fp.keysAlerts.isNotEmpty
                ? fp.dismissAlert(key: fp.keysAlerts.last)
                : null;
          } else {}

          return false;
        } else {}
        fp.dismissAlert(key: widget.keyDismissPage!);
      }
      return true;
    } else {
      return true;
    }
  }

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
