import 'dart:math';
import 'package:app_core/app_core.dart'; // Giữ nguyên import của bạn
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// -----------------------------------------------------------------------------
// ENUM
// -----------------------------------------------------------------------------
enum TreeStage {
  withered(0, Colors.green),            // Úa
  sprouting(30, Colors.deepOrange),     // Nảy mầm
  blooming(45, Colors.pink),            // Ra hoa
  fullBloom(60, Colors.pink);           // Nở rộ

  final int minPetals;
  final MaterialColor color;
  const TreeStage(this.minPetals, this.color);

  static TreeStage fromCount(int count) {
    return TreeStage.values.lastWhere(
          (stage) => count >= stage.minPetals,
      orElse: () => TreeStage.withered,
    );
  }
}

// -----------------------------------------------------------------------------
// MAIN WIDGET
// -----------------------------------------------------------------------------
class TreeGrowthView extends StatefulWidget {
  final int petalCount;
  final Map<TreeStage, ImageProvider> stageImages;
  final ImageProvider petalImage;
  final double? size;

  const TreeGrowthView({
    Key? key,
    required this.petalCount,
    this.stageImages = const {
      TreeStage.withered: AssetImage('assets/images/tree_1_dry.png', package: "app_core"),
      TreeStage.sprouting: AssetImage('assets/images/tree_2_sprout.png', package: "app_core"),
      TreeStage.blooming: AssetImage('assets/images/tree_3_bloom.png', package: "app_core"),
      TreeStage.fullBloom: AssetImage('assets/images/tree_4_full.png', package: "app_core"),
    },
    this.petalImage = const AssetImage('assets/images/sakura_petal.png', package: "app_core"),
    this.size,
  }) : super(key: key);

  @override
  State<TreeGrowthView> createState() => _TreeGrowthViewState();
}

class _TreeGrowthViewState extends State<TreeGrowthView> with TickerProviderStateMixin {
  late TreeStage _currentStage;

  // Controller hiệu ứng tung hoa (Confetti)
  late AnimationController _petalController;

  // Controller hiệu ứng nảy cây (Stage Change)
  late AnimationController _treePulseController;
  late Animation<double> _treeScaleAnimation;

  // [MỚI] Controller hiệu ứng nảy số (Count Change)
  late AnimationController _countPulseController;
  late Animation<double> _countScaleAnimation;

  final List<_PetalParticle> _particles = [];
  final Random _random = Random();
  double get _size => widget.size ?? 70.r;

  @override
  void initState() {
    super.initState();
    _currentStage = TreeStage.fromCount(widget.petalCount);

    // 1. Setup Petal Rain
    _petalController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    // 2. Setup Tree Pulse (Khi đổi Stage)
    _treePulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _treeScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.15)
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.15, end: 1.0)
            .chain(CurveTween(curve: Curves.bounceOut)),
        weight: 60,
      ),
    ]).animate(_treePulseController);

    // 3. [MỚI] Setup Count Pulse (Khi đổi số lượng) - Nảy nhanh và mạnh hơn
    _countPulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Rất nhanh (0.3s)
    );

    _countScaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.0, end: 1.3) // Phình to 1.3 lần
            .chain(CurveTween(curve: Curves.easeOut)),
        weight: 50,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.3, end: 1.0)
            .chain(CurveTween(curve: Curves.elasticOut)), // Co lại nảy nảy
        weight: 50,
      ),
    ]).animate(_countPulseController);

    _generateParticles();
  }

  @override
  void didUpdateWidget(TreeGrowthView oldWidget) {
    super.didUpdateWidget(oldWidget);

    // [LOGIC 1] Kiểm tra thay đổi số lượng để nảy số (Heartbeat)
    if (widget.petalCount != oldWidget.petalCount) {
      // Reset về 0 và chạy lại animation nảy số
      _countPulseController.forward(from: 0.0);
    }

    // [LOGIC 2] Kiểm tra thay đổi Stage để nảy Cây + Tung hoa
    final newStage = TreeStage.fromCount(widget.petalCount);
    if (newStage != _currentStage) {
      _currentStage = newStage;
      _generateParticles();
      _petalController.forward(from: 0.0);
      _treePulseController.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _petalController.dispose();
    _treePulseController.dispose();
    _countPulseController.dispose();
    super.dispose();
  }

  void _generateParticles() {
    _particles.clear();
    for (int i = 0; i < 50; i++) {
      _particles.add(_PetalParticle(
        vx: (_random.nextDouble() - 0.5) * 1.5,
        vy: -1.2 - _random.nextDouble(),
        scale: 0.15 + _random.nextDouble() * 0.4,
        rotationSpeed: (_random.nextDouble() - 0.5) * 10,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _size,
      height: _size,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // LAYER 0: PROGRESS BAR
          TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: widget.petalCount.toDouble()),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeOutCubic,
            builder: (context, animatedPetalCount, child) {
              return CustomPaint(
                size: Size(_size, _size),
                painter: _SegmentedProgressPainter(
                  currentPetals: animatedPetalCount,
                  progressBackgroundColor: context.colorScheme.surfaceContainerHigh,
                ),
              );
            },
          ),

          // LAYER 1: CÂY
          Padding(
            padding: EdgeInsets.all(_size / 6),
            child: ScaleTransition(
              scale: _treeScaleAnimation,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 600),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: Image(
                  key: ValueKey<TreeStage>(_currentStage),
                  image: widget.stageImages[_currentStage]!,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // LAYER 2: HOA TUNG LÊN
          AnimatedBuilder(
            animation: _petalController,
            builder: (context, child) {
              if (!_petalController.isAnimating) return const SizedBox();

              double t = _petalController.value;
              double movementMultiplier = _size / 1.2;
              double gravity = 4.0;

              return Stack(
                alignment: Alignment.center,
                children: _particles.map((particle) {
                  double dx = particle.vx * t * movementMultiplier;
                  double dy = (particle.vy * t + 0.5 * gravity * t * t) * movementMultiplier;

                  double opacity = 1.0;
                  if (t > 0.8) {
                    opacity = (1.0 - t) * 5.0;
                  }

                  return Positioned(
                    left: (_size / 2) + dx - (15 * particle.scale),
                    top: (_size / 2) + dy,
                    child: Opacity(
                      opacity: opacity.clamp(0.0, 1.0),
                      child: Transform.rotate(
                        angle: particle.rotationSpeed * t,
                        child: Image(
                          image: widget.petalImage,
                          width: 30 * particle.scale,
                          height: 30 * particle.scale,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );
            },
          ),

          // LAYER 3: [MỚI] COUNT BADGE (HIỂN THỊ SỐ HOA)
          Positioned(
            top: - _size / 10, // Cách đáy widget một chút
            right: - _size / 5, // Cách đáy widget một chút
            child: ScaleTransition(
              scale: _countScaleAnimation, // Hiệu ứng nhịp tim khi số thay đổi
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3).r,
                decoration: BoxDecoration(
                  color: context.colorScheme.onSurface.withAlpha(50), // Nền trắng mờ
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image(
                      image: widget.petalImage,
                      width: _size / 5,
                      height: _size / 5,
                    ),
                    SizedBox(width: 3.r),
                    Text(
                      '${widget.petalCount}',
                      style: context.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: _size / 6,
                        color: context.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CUSTOM PAINTER (Giữ nguyên logic của bạn)
// -----------------------------------------------------------------------------
class _SegmentedProgressPainter extends CustomPainter {
  final double currentPetals;
  final Color progressBackgroundColor;

  _SegmentedProgressPainter({
    required this.currentPetals,
    required this.progressBackgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2 - 4;
    final strokeWidth = size.width / 15;

    final segments = List.generate(TreeStage.values.length - 1, (index) {
      final currentStage = TreeStage.values[index];
      final nextStage = TreeStage.values[index + 1];
      final range = (nextStage.minPetals - currentStage.minPetals).toDouble();
      return _SegmentSpec(range: range, color: currentStage.color, alpha: 150 + index * 50);
    });

    double startAngle = -pi / 2;
    final double gapAngle = strokeWidth / 25;
    final totalGapAngle = gapAngle * segments.length;
    final availableAngle = 2 * pi - totalGapAngle;

    double remainingTotalRange = 0;
    for (int i = 1; i < segments.length; i++) {
      remainingTotalRange += segments[i].range;
    }

    double accumulatedPetals = 0;

    for (int i = 0; i < segments.length; i++) {
      final segment = segments[i];

      double sweepAngle;
      if (i == 0) {
        sweepAngle = availableAngle * 0.8;
      } else {
        if (remainingTotalRange > 0) {
          double ratio = segment.range / remainingTotalRange;
          sweepAngle = availableAngle * 0.2 * ratio;
        } else {
          sweepAngle = 0;
        }
      }

      // Track
      final trackPaint = Paint()
        ..color = progressBackgroundColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        trackPaint,
      );

      // Progress
      double progressInThisSegment = 0;
      if (currentPetals > accumulatedPetals) {
        double amount = currentPetals - accumulatedPetals;
        progressInThisSegment = amount.clamp(0.0, segment.range);
      }

      if (progressInThisSegment > 0) {
        final progressRatio = progressInThisSegment / segment.range;
        final progressPaint = Paint()
          ..color = segment.color.shade300.withAlpha(segment.alpha)
          ..style = PaintingStyle.stroke
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle * progressRatio,
          false,
          progressPaint,
        );
      }

      startAngle += sweepAngle + gapAngle;
      accumulatedPetals += segment.range;
    }
  }

  @override
  bool shouldRepaint(covariant _SegmentedProgressPainter oldDelegate) {
    return oldDelegate.currentPetals != currentPetals;
  }
}

class _SegmentSpec {
  final double range;
  final MaterialColor color;
  final int alpha;

  _SegmentSpec({required this.range, required this.color, required this.alpha});
}

class _PetalParticle {
  final double vx;
  final double vy;
  final double rotationSpeed;
  final double scale;

  _PetalParticle({
    required this.vx,
    required this.vy,
    required this.rotationSpeed,
    required this.scale,
  });
}