import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            HoverCard(
                image:
                    'https://images.unsplash.com/photo-1614610767572-89b84742a2f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2030&q=80'),
            HoverCard(
              image:
                  'https://images.unsplash.com/photo-1641534802506-f315ae0537e0?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80',
            ),
            HoverCard(
                image:
                    'https://images.unsplash.com/photo-1618782658650-2c6eb20e62ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1974&q=80'),
          ],
        ),
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  final String image;
  const HoverCard({Key? key, required this.image}) : super(key: key);

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<Color?> _colorAnimation;

  late Animation<double> _headTextOpacityAnimation;
  late Animation<double> _subTextOpacityAnimation;

  double height = 600.0;
  double width = 500.0;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 750,
        ));

    _rotationAnimation = Tween(begin: math.pi / 2, end: 0.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn)));

    _colorAnimation = ColorTween(
            begin: const Color(0x00ffffff), end: Colors.black.withOpacity(0.6))
        .animate(
            CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn));

    _headTextOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.4, 0.8, curve: Curves.ease)));

    _subTextOpacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.7, 1.0, curve: Curves.ease)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        _controller.forward();
      },
      onExit: (event) {
        _controller.reverse();
      },
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            SizedBox(
              height: height,
              width: width,
              child: Image.network(
                widget.image,
                fit: BoxFit.cover,
                filterQuality: FilterQuality.medium,
              ),
            ),
            Positioned(
              right: 0.0,
              child: SizedBox(
                height: height,
                width: width / 2,
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        color: _colorAnimation.value,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              child: SizedBox(
                height: height,
                width: width / 2,
                child: AnimatedBuilder(
                  animation: _rotationAnimation,
                  builder: (context, child) {
                    return Transform.rotate(
                      angle: _rotationAnimation.value,
                      alignment: Alignment.topRight,
                      child: Container(
                        color: _colorAnimation.value,
                      ),
                    );
                  },
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                      animation: _headTextOpacityAnimation,
                      builder: (context, child) {
                        return Container(
                          height: 80.0,
                          alignment: Alignment(
                              0.0, _headTextOpacityAnimation.value - 1.1),
                          child: FadeTransition(
                            opacity: _headTextOpacityAnimation,
                            child: Text(
                              'Heading',
                              style: GoogleFonts.dancingScript(
                                fontWeight: FontWeight.w600,
                                fontSize: 40.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        );
                      }),
                  AnimatedBuilder(
                      animation: _subTextOpacityAnimation,
                      builder: (context, child) {
                        return Container(
                          height: 120.0,
                          alignment: Alignment(
                              0.0, _subTextOpacityAnimation.value - 1.1),
                          child: FadeTransition(
                            opacity: _subTextOpacityAnimation,
                            child: SizedBox(
                              width: width - 100,
                              child: Text(
                                'Lorem ipsum dolor sit amet. Et perspiciatis molestias At exercitationem omnis ut sint suscipit non maiores nulla cum consequatur debitis et voluptatibus aliquam!',
                                style: GoogleFonts.overpass(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20.0,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
