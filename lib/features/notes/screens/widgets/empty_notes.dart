import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyNotes extends StatelessWidget {
  const EmptyNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SvgPicture.asset(
          'assets/no_notes.svg',
          width: MediaQuery.sizeOf(context).width * 0.5,
        ),
        const SizedBox(height: 16),
        Center(
          child: Text(
            'No notes yet',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ],
    );
  }
}
