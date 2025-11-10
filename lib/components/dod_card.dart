import 'package:flutter/material.dart';
import 'dart:math' as math;

class DodCard extends StatefulWidget {
  final bool isActive;
  final int currentIndex;
  final int activeIndex;
  final int totalItems;

  const DodCard({
    super.key,
    this.isActive = false,
    this.currentIndex = 0,
    this.activeIndex = 0,
    this.totalItems = 0,
  });

  double _getRotationAngle() {
    if (isActive) return 0;
    if (currentIndex == totalItems - 1) {
      if (activeIndex == 0) {
        return -0.07;
      } else {
        return 0.09;
      }
    }
    if (currentIndex == (activeIndex - 1)) {
      return -0.07;
    } else {
      return 0.09;
    }
  }

  @override
  State<DodCard> createState() => _DodCardState();
}

class _DodCardState extends State<DodCard> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragEnd(DragEndDetails details) {
    final Animation<Offset> animation = Tween<Offset>(begin: _dragOffset, end: Offset.zero)
        .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
    animation.addListener(() => setState(() => _dragOffset = animation.value));
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: _dragOffset,
      child: GestureDetector(
        onVerticalDragUpdate: widget.isActive
            ? (details) => setState(() {
                  // Only allow dragging downwards
                  _dragOffset = Offset(0, math.max(0, _dragOffset.dy + details.delta.dy));
                })
            : null,
        onVerticalDragEnd: widget.isActive ? _onDragEnd : null,
        child: AnimatedContainer(
          transform: Matrix4.rotationZ(widget._getRotationAngle()),
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            gradient: const LinearGradient(
              colors: [Color(0xFFA1DBFF), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            boxShadow: widget.isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [],
          ),
          width: 230,
          height: widget.isActive ? 330 : 200,
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F7F9),
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: const Text(
                        "ONLY 3 LEFT",
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Image(
                        image: AssetImage("lib/assets/images/sample.png"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
