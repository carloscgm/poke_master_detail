import 'package:flutter/material.dart';
import 'package:poke_master_detail/presentation/common/resources/app_styles.dart';

class Panel extends StatelessWidget {
  final String title;
  final Widget child;
  const Panel({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade600,
            spreadRadius: 2,
            blurRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: const EdgeInsets.only(left: 8, top: 5),
              child: Text(
                title,
                style: AppStyles.appTheme.textTheme.titleMedium,
              )),
          const SizedBox(height: 5),
          SizedBox(width: double.infinity, child: child),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
