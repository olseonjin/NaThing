import 'package:flutter/material.dart';

class IssueItem extends StatelessWidget {
  final String title;
  final String description;
  final String createdAt;
  final void Function(BuildContext context, String title, String description, double blurStrength)? onTap;

  const IssueItem(
      this.title,
      this.description,
      this.createdAt, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 남은 만료 기간(0~24시간)을 0~10 스케일로 변환
    final created = DateTime.parse(createdAt.replaceAll(',', ' '));
    final now = DateTime.now();
    final diff = now.difference(created);
    final hours = diff.inMinutes / 60.0;
    double blurStrength = (hours / 24.0) * 10.0;
    if (blurStrength < 0) blurStrength = 0;
    if (blurStrength > 10) blurStrength = 10;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap != null
                ? () => onTap!(context, title, description, blurStrength)
                : null,
            child: Container(
              padding: const EdgeInsets.all(12),
              width: double.infinity,
              height: 80,
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(title, style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(color: Colors.grey),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
