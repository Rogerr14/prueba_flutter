
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:prueba_app/env/app_theme.dart';
import 'package:prueba_app/shared/providers/functional_provider.dart';
import 'package:prueba_app/shared/widget/filled_button.dart';

class AlertTemplate extends StatefulWidget {
  final Widget content;
  final GlobalKey keyToClose;
  final bool? dismissAlert;
  final bool? animation;
  final double? padding;

  const AlertTemplate(
      {Key? key,
      required this.content,
      required this.keyToClose,
      this.dismissAlert = false,
      this.animation = true,
      this.padding = 20
      //  required this.keyToClose
      })
      : super(key: key);

  @override
  State<AlertTemplate> createState() => _AlertTemplateState();
}

class _AlertTemplateState extends State<AlertTemplate> {
  //AnimationController? animateController;
  late GlobalKey keySummoner;
  @override
  void initState() {
    // keySummoner = widget.keyToClose;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black45,
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              final fp =
                  Provider.of<FunctionalProvider>(context, listen: false);
              widget.dismissAlert == true
                  ? fp.dismissAlert(key: widget.keyToClose)
                  : null;
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.transparent,
            ),
          ),
          Container(
            padding: EdgeInsets.all(widget.padding ?? 20),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // /const Expanded(child: SizedBox()),
                    widget.animation == true
                        ? FadeInUpBig(
                            animate: true,
                            controller: (controller) {},
                            duration: const Duration(milliseconds: 500),
                            child: widget.content)
                        : widget.content,
                    // const Expanded(child: SizedBox()),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlertLoading extends StatefulWidget {
  const AlertLoading({Key? key}) : super(key: key);

  @override
  State<AlertLoading> createState() => _AlertLoadingState();
}

class _AlertLoadingState extends State<AlertLoading>
    with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      //animationBehavior : AnimationBehavior.preserve,
      reverseDuration: const Duration(seconds: 1),
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final theme = AppTheme();
    return Material(
      type: MaterialType.transparency,
      child: SizedBox(
        height: 180,
        width: 240,
        child: FadeTransition(
          opacity: _animation,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/icon_loading.png', fit: BoxFit.fill, width: 120),
            ],
          ),
        ),
      ),
    );
  }
}


class AlertGeneric extends StatefulWidget {
  final bool dismissable;
  final GlobalKey? keyToClose;
  final Widget content;
  final bool? heightOption;

  const AlertGeneric(
      {Key? key,
      required this.content,
      this.heightOption = false,
      this.dismissable = false,
      this.keyToClose})
      : super(key: key);

  @override
  State<AlertGeneric> createState() => _AlertGenericState();
}

class _AlertGenericState extends State<AlertGeneric> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          //margin: EdgeInsets.all(50),
          padding: const EdgeInsets.all(15),
          width: double.infinity,
          height: widget.heightOption == true ? size.height * 0.54 : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppTheme.white,
          ),
          child:
              Material(type: MaterialType.transparency, child: widget.content),
        ),
        if (widget.dismissable)
          Positioned(
            top: -3,
            right: 0,
            child: SizedBox(
              height: 50,
              width: 50,
              child: CloseButton(
                style: const ButtonStyle(
                    iconColor: MaterialStatePropertyAll(Colors.black)),
                onPressed: () {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: widget.keyToClose!);
                },
              ),
            ),
          )
      ],
    );
  }
}



class ErrorGeneric extends StatelessWidget {
  final GlobalKey keyToClose;
  final String message;
  final String? messageButton;
  final void Function()? onPress;

  const ErrorGeneric(
      {Key? key,
      required this.message,
      required this.keyToClose,
      this.messageButton,
      this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        SizedBox(height: size.height * 0.015),
        SvgPicture.asset(AppTheme.iconErrorPath),
        SizedBox(height: size.height * 0.03),
        // titleAlerts(title: '¡Oops, algo fallo!', color: AppTheme.error),
        // SizedBox(height: size.height * 0.04),
        messageAlerts(size, message: message),
        SizedBox(height: size.height * 0.03),
        FilledButtonWidget(
          borderRadius: 20,
          width: size.width * 0.05,
          text: messageButton ?? 'Aceptar',
          onPressed: (onPress != null)
              ? onPress
              : () async {
                  final fp =
                      Provider.of<FunctionalProvider>(context, listen: false);
                  fp.dismissAlert(key: keyToClose);
                },
        ),
        SizedBox(height: size.height * 0.01),
      ],
    );
  }
}



Padding messageAlerts(Size size,
    {required String message, Color? color = Colors.lightBlue}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
    child: Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: color,
      ),
    ),
  );
}