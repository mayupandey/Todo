import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageController;

  late AnimationController _textController;

  late Animation<double> _imageAnimation;

  late Animation<double> _textAnimation;

  bool hasImageAnimationStarted = false;

  bool hasTextAnimationStarted = false;

  @override
  void initState() {
    super.initState();

    _imageController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _textController = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _imageAnimation =
        Tween<double>(begin: 1, end: 1.5).animate(_imageController);

    _textAnimation = Tween<double>(begin: 3, end: 0.5).animate(_textController);

    _imageController.addListener(imageControllerListener);

    _textController.addListener(textControllerListener);

    run();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void imageControllerListener() {
    if (_imageController.status == AnimationStatus.completed) {
      Future.delayed(const Duration(milliseconds: 100), () {
        setState(() {
          hasTextAnimationStarted = true;
        });

        _textController.forward().orCancel;
      });
    }
  }

  void textControllerListener() {
    if (_textController.status == AnimationStatus.completed) {
      Future.delayed(const Duration(milliseconds: 1000), () {
        context.go("/authCheck");
      });
    }
  }

  void run() {
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        hasImageAnimationStarted = true;
      });

      _imageController.forward().orCancel;
    });
  }

  @override
  dispose() {
    _imageController.dispose();

    _textController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          AnimatedBuilder(
            animation: _imageController,
            child: Column(
              children: const [],
            ),
            builder: (context, child) => Transform.scale(
              scale: 1 * _imageAnimation.value,
              child: child,
            ),
          ),
          hasTextAnimationStarted
              ? Center(
                  child: AnimatedBuilder(
                    animation: _textController,
                    child: Icon(
                      Icons.today_outlined,
                      color: Colors.black.withOpacity(0.8),
                      size: MediaQuery.of(context).size.width / 2,
                    ),
                    // child: Image.asset(
                    //   'assets/img/dj.png',
                    // ),
                    builder: (context, child) => Transform.scale(
                      scale: 2 * _textAnimation.value,
                      alignment: Alignment.center,
                      child: child,
                    ),
                  ),
                )
              : Container(
                  height: 0,
                ),
        ],
      ),
    );
  }
}
