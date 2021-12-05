import 'package:flutter/material.dart';

class RoutinePlayer extends StatelessWidget {
  final bool? isPlaying;
  final VoidCallback? playButtonPress;

  const RoutinePlayer({Key? key, this.isPlaying, this.playButtonPress})
      : super(key: key);

  final playIcon = Icons.play_arrow;
  final pauseIcon = Icons.pause;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        icon: Icon(isPlaying! ? playIcon : pauseIcon),
        onPressed: playButtonPress,
      ),
    );
  }
}
