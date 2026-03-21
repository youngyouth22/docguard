import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/image_resources.dart';
import 'package:docguard/features/documents/presentation/blocs/document_bloc.dart';
import 'package:docguard/features/documents/presentation/blocs/document_event.dart';

class FavoriteToggle extends StatefulWidget {
  final String documentId;
  final bool isFavorite;

  const FavoriteToggle({
    super.key,
    required this.documentId,
    required this.isFavorite,
  });

  @override
  State<FavoriteToggle> createState() => _FavoriteToggleState();
}

class _FavoriteToggleState extends State<FavoriteToggle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onToggle() {
    _controller.forward(from: 0.0);
    context.read<DocumentBloc>().add(
      DocumentEvent.favoriteToggled(widget.documentId, !widget.isFavorite),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: IconButton(
        icon: SvgPicture.asset(
          ImageResources.star,
          colorFilter: ColorFilter.mode(
            widget.isFavorite ? AppColors.warning200 : AppColors.neutral400,
            BlendMode.srcIn,
          ),
        ),
        onPressed: _onToggle,
      ),
    );
  }
}
