import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DividerWithMargins extends StatelessWidget {
  const DividerWithMargins({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Gap(20),
        Divider(),
        Gap(20),
      ],
    );
  }
}
