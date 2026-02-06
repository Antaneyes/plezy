import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:plezy/widgets/app_icon.dart';

/// Temporary visual indicator showing current volume level
///
/// Displays when hardware volume buttons are pressed and auto-hides after a delay.
class VolumeIndicator extends StatelessWidget {
  final double volume;
  final int maxVolume;

  const VolumeIndicator({
    super.key,
    required this.volume,
    required this.maxVolume,
  });

  @override
  Widget build(BuildContext context) {
    final isMuted = volume == 0;
    final volumePercent = (volume / maxVolume * 100).clamp(0, 100).round();

    return Center(
      child: Container(
        width: 200,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Volume icon
            AppIcon(
              isMuted
                  ? Symbols.volume_off_rounded
                  : volume < maxVolume * 0.5
                      ? Symbols.volume_down_rounded
                      : Symbols.volume_up_rounded,
              fill: 1,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 12),

            // Volume slider
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: volume / maxVolume,
                backgroundColor: Colors.white.withValues(alpha: 0.3),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 6,
              ),
            ),
            const SizedBox(height: 8),

            // Volume percentage
            Text(
              '$volumePercent%',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
