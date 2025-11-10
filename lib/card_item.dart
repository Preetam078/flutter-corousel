import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:corousel/product_model.dart';

class ProductCard extends StatefulWidget {
  final int activeIndex;
  final int currentIndex;
  final Product product;
  final Function(Product) onAddToCart;

  const ProductCard({
    super.key,
    required this.activeIndex,
    required this.currentIndex,
    required this.product,
    required this.onAddToCart,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  Offset _dragOffset = Offset.zero;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onAddToCart(widget.product);
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onDragEnd(DragEndDetails details) {
    // If dragged down far enough, trigger add to cart
    if (_dragOffset.dy > 150) {
      // Animate the card away completely
      final Animation<Offset> animation = Tween<Offset>(begin: _dragOffset, end: const Offset(0, 500))
          .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
      animation.addListener(() => setState(() => _dragOffset = animation.value));
      _animationController.forward(from: 0);
    } else {
      // Otherwise, animate back to the original position
      final Animation<Offset> animation =
          Tween<Offset>(begin: _dragOffset, end: Offset.zero)
              .animate(CurvedAnimation(parent: _animationController, curve: Curves.easeOut));
      animation.addListener(() => setState(() => _dragOffset = animation.value));
      _animationController.forward(from: 0);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine if this card is the active one.
    final bool isActive = widget.activeIndex == widget.currentIndex;

    // Determine if this card is the active one.
    // Set the rotation angle. 0 for the active card, and a small angle for others.
    // The angle is in radians. We'll use about -5 degrees for non-active cards.
    final double angle = _getRotationAngle(widget.activeIndex, widget.currentIndex);

    return AnimatedRotation(
      // We apply the rotation here.
      // For a more dynamic effect, you could vary the angle based on
      // how far the card is from the active one (e.g., `currentIndex - activeIndex`).
      turns: angle / (2 * math.pi),
      duration: const Duration(milliseconds: 350),
      //angle: angle,
      child: Transform.translate(
        offset: _dragOffset,
        child: GestureDetector(
          onVerticalDragUpdate: isActive
              ? (details) => setState(() {
                    // Only allow dragging downwards
                    _dragOffset = Offset(0, math.max(0, _dragOffset.dy + details.delta.dy));
                  })
              : null,
          onVerticalDragEnd: isActive ? _onDragEnd : null,
          child: Container(
            margin: isActive
                ? const EdgeInsets.symmetric(horizontal: 20, vertical: 20)
                : const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
            padding: const EdgeInsets.all(13),
            constraints: const BoxConstraints(),
            decoration: BoxDecoration(
              color: const Color(0xFFB5DDFF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Image and "Only 3 left" badge
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // ✅ moved color inside BoxDecoration
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'ONLY ${widget.product.id + 2} LEFT', // Example dynamic text
                        style: TextStyle(
                          color: Colors.pink.shade400,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.8,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          color: Colors.grey.shade100,
                          padding: const EdgeInsets.all(16),
                          child: Image.asset(
                            widget.product.imageAsset,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                height: 150,
                                color: Colors.grey.shade300,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Product info
                Column(
                  children: [
                    Text(
                      widget.product.name,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'beige and linen\nformal look', // This can also be from product model
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Price section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                '₹3,000 ', // This can also be from product model
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                '₹5,499', // This can also be from product model
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        decoration: TextDecoration.lineThrough,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '20% off',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double _getRotationAngle(int activeIndex, int currentIndex) {
    if (activeIndex == currentIndex) {
      return 0;
    }
    return currentIndex == activeIndex - 1 ? (-math.pi / 36) : (math.pi / 36);
  }
}
