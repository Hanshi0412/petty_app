import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  final double rating;
  final int reviewCount;
  final Color starColor;
  final double iconSize;
  final TextStyle? textStyle;

  const RatingStars({
    super.key,
    required this.rating,
    this.reviewCount = 0,
    this.starColor = Colors.amber,
    this.iconSize = 16.0,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: List.generate(5, (index) {
            return Icon(
              index < rating.floor()
                  ? Icons.star
                  : index < rating
                  ? Icons.star_half
                  : Icons.star_border,
              color: starColor,
              size: iconSize,
            );
          }),
        ),
        const SizedBox(width: 8),
        Text(
          '$rating ($reviewCount Reviews)',
          style: textStyle ?? Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
