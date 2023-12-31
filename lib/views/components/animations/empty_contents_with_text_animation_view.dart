import 'package:flutter/material.dart';
import 'package:instagram_clone_app/views/components/animations/empty_contents_animation_view.dart';

class EmptyContentsWithAnimationView extends StatelessWidget {
  final String text;

  const EmptyContentsWithAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(25),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white54,
                    fontSize: 16,
                  ),
            ),
          ),
          const Expanded(
            child: EmptyContentsAnimationView(),
          ),
        ],
      ),
    );
  }
}
