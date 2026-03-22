import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart' as pdf;
import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/app_typography.dart';
import 'package:docguard/features/documents/domain/entities/document_entity.dart';
import 'package:docguard/core/attachments/queue.dart';
import 'package:docguard/di/injection.dart';
import 'package:powersync/powersync.dart' hide Column;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_markdown_latex/flutter_markdown_latex.dart';
import 'package:http/http.dart' as http;
import 'package:markdown/markdown.dart' as md;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:ui';

enum ViewerMode { original, pro, markdown }

/// A professional PDF viewer screen that handles both local and remote files.
class PdfViewerScreen extends StatefulWidget {
  final DocumentEntity document;

  const PdfViewerScreen({super.key, required this.document});

  @override
  State<PdfViewerScreen> createState() => _PdfViewerScreenState();
}

class _PdfViewerScreenState extends State<PdfViewerScreen>
    with TickerProviderStateMixin {
  final pdf.PdfViewerController _pdfViewerController =
      pdf.PdfViewerController();
  final ScrollController _scrollController = ScrollController();
  late AnimationController _toolbarAnimationController;
  late Animation<Offset> _toolbarOffsetAnimation;
  late AnimationController _speedDialController;
  late Animation<double> _speedDialAnimation;
  bool _isSpeedDialOpen = false;

  ViewerMode _currentMode = ViewerMode.original;
  bool _isToolbarVisible = true;
  String? _markdownContent;
  bool _isLoadingMarkdown = false;
  Stream<String?>? _pathStream;
  StreamSubscription<String?>? _markdownSubscription;

  @override
  void initState() {
    super.initState();
    _toolbarAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _toolbarOffsetAnimation =
        Tween<Offset>(begin: const Offset(0, 2), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _toolbarAnimationController,
            curve: Curves.easeOutCubic,
          ),
        );

    _speedDialController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _speedDialAnimation = CurvedAnimation(
      parent: _speedDialController,
      curve: Curves.easeInOutBack,
    );

    _toolbarAnimationController.forward();
    _scrollController.addListener(_scrollListener);
    _fetchPath();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _toolbarAnimationController.dispose();
    _speedDialController.dispose();
    _markdownSubscription?.cancel();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_isToolbarVisible) {
        setState(() => _isToolbarVisible = false);
        _toolbarAnimationController.reverse();
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (!_isToolbarVisible) {
        setState(() => _isToolbarVisible = true);
        _toolbarAnimationController.forward();
      }
    }
  }

  void _fetchPath() {
    final db = getIt<PowerSyncDatabase>();
    final userId = getIt<SupabaseClient>().auth.currentUser?.id;

    debugPrint('🔍 [Viewer] Fetching path for mode: $_currentMode');
    debugPrint('🔍 [Viewer] Document ID: ${widget.document.id}');
    debugPrint('🔍 [Viewer] User ID: $userId');

    if (_currentMode == ViewerMode.pro) {
      debugPrint(
        '🔍 [Viewer] Target Pro ID: p:${widget.document.fileUrlPdfPro}.pdf',
      );
      _pathStream = watchLocalDocumentPathWithPrefix(
        widget.document.fileUrlPdfPro,
        db,
        isProcessed: true,
        extension: 'pdf',
      ).asBroadcastStream();
    } else if (_currentMode == ViewerMode.markdown) {
      debugPrint(
        '🔍 [Viewer] Target Markdown ID: p:${widget.document.fileUrlMarkdown}.md',
      );
      _pathStream = watchLocalDocumentPathWithPrefix(
        widget.document.fileUrlMarkdown,
        db,
        isProcessed: true,
        extension: 'md',
      ).asBroadcastStream();
      _listenToMarkdown();
    } else {
      debugPrint('🔍 [Viewer] Target Original ID: ${widget.document.fileUrl}');
      _pathStream = watchLocalDocumentPathWithPrefix(
        widget.document.fileUrl,
        db,
        isProcessed: false,
      ).asBroadcastStream();
    }
  }

  void _listenToMarkdown() {
    _markdownSubscription?.cancel();
    _markdownSubscription = _pathStream?.listen((path) async {
      if (path != null && File(path).existsSync()) {
        final content = await File(path).readAsString();
        if (mounted) {
          setState(() {
            _markdownContent = content;
            _isLoadingMarkdown = false;
          });
        }
      } else {
        if (mounted && _markdownContent == null) {
          _loadMarkdownContentFallback();
        }
      }
    });
  }

  Future<void> _loadMarkdownContentFallback() async {
    if (widget.document.fileUrlMarkdown == null) return;
    try {
      final url = widget.document.fileUrlMarkdown!;
      if (url.startsWith('http')) {
        setState(() => _isLoadingMarkdown = true);
        final response = await http.get(Uri.parse(url));
        if (response.statusCode == 200 && mounted) {
          setState(() {
            _markdownContent = response.body;
            _isLoadingMarkdown = false;
          });
        }
      }
    } catch (e) {
      debugPrint('Markdown fallback error: $e');
    }
  }

  Future<void> _shareFile(String format) async {
    final db = getIt<PowerSyncDatabase>();
    String? fileId;
    String fileName = 'Document.$format';

    if (format == 'pdf') {
      fileId = widget.document.fileUrl;
    } else if (format == 'pdf_pro') {
      fileId = widget.document.fileUrlPdfPro != null
          ? 'p:${widget.document.fileUrlPdfPro}.pdf'
          : null;
      fileName = 'Document_Pro.pdf';
    } else if (format == 'md') {
      fileId = widget.document.fileUrlMarkdown != null
          ? 'p:${widget.document.fileUrlMarkdown}.md'
          : null;
      fileName = 'Document.md';
    } else if (format == 'docx') {
      fileId = widget.document.fileUrlWord != null
          ? 'p:${widget.document.fileUrlWord}.docx'
          : null;
      fileName = 'Document.docx';
    }

    if (fileId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('This format is not available yet.')),
      );
      return;
    }

    try {
      final localPath = await getLocalPath(fileId, db);
      if (!mounted) return;

      if (localPath != null && await File(localPath).exists()) {
        await Share.shareXFiles([XFile(localPath, name: fileName)]);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Document is still synchronizing locally...'),
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      debugPrint('Error sharing file: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error sharing file: $e')));
    }
  }

  void _switchMode(ViewerMode mode) {
    if (_currentMode == mode) return;
    setState(() {
      _currentMode = mode;
      _markdownContent = null;
      _fetchPath();
    });
  }

  @override
  Widget build(BuildContext context) {
    final title = widget.document.docNumber?.isNotEmpty == true
        ? widget.document.docNumber!
        : (widget.document.description?.isNotEmpty == true
              ? widget.document.description!
              : 'Scanned Document');

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.grey800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          title,
          style: AppTypography.bodyLBold.copyWith(color: AppColors.grey800),
        ),
      ),
      body: Stack(children: [_buildViewerContent(), _buildFloatingUI()]),
    );
  }

  void _toggleSpeedDial() {
    setState(() {
      _isSpeedDialOpen = !_isSpeedDialOpen;
      if (_isSpeedDialOpen) {
        _speedDialController.forward();
      } else {
        _speedDialController.reverse();
      }
    });
  }

  Widget _buildFloatingUI() {
    return SlideTransition(
      position: _toolbarOffsetAnimation,
      child: Stack(
        children: [
          // Overlay to close speed dial when clicking outside
          if (_isSpeedDialOpen)
            GestureDetector(
              onTap: _toggleSpeedDial,
              child: Container(
                color: Colors.transparent,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 24, left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _buildMainToolbarWidget(),
                    _buildCustomSpeedDial(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMainToolbarWidget() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.grey800.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 4,
        children: [
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return FadeTransition(
                opacity: animation,
                child: SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  axisAlignment: -1,
                  child: child,
                ),
              );
            },
            child: _currentMode != ViewerMode.markdown
                ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(
                          Icons.zoom_out,
                          color: AppColors.white,
                          size: 20,
                        ),
                        onPressed: () => _pdfViewerController.zoomLevel -= 0.25,
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.zoom_in,
                          color: AppColors.white,
                          size: 20,
                        ),
                        onPressed: () => _pdfViewerController.zoomLevel += 0.25,
                      ),
                      Container(
                        width: 1,
                        height: 20,
                        color: AppColors.white.withValues(alpha: 0.3),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ),
          _ToolbarAction(
            icon: Icons.description_outlined,
            label: 'Orig',
            isActive: _currentMode == ViewerMode.original,
            onTap: () => _switchMode(ViewerMode.original),
          ),
          _ToolbarAction(
            icon: Icons.auto_awesome_outlined,
            label: 'Pro',
            isActive: _currentMode == ViewerMode.pro,
            isEnabled: widget.document.fileUrlPdfPro != null,
            onTap: () => _switchMode(ViewerMode.pro),
          ),
          _ToolbarAction(
            icon: Icons.article_outlined,
            label: 'MD',
            isActive: _currentMode == ViewerMode.markdown,
            isEnabled: widget.document.fileUrlMarkdown != null,
            onTap: () => _switchMode(ViewerMode.markdown),
          ),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _buildCustomSpeedDial() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Speed Dial Actions
        ...[
          _SpeedDialChild(
            icon: Icons.description,
            iconColor: Colors.blue,
            label: 'DOCX',
            animation: _speedDialAnimation,
            index: 3,
            onTap: () {
              _toggleSpeedDial();
              _shareFile('docx');
            },
          ),
          _SpeedDialChild(
            icon: Icons.article,
            iconColor: Colors.green,
            label: 'MD',
            animation: _speedDialAnimation,
            index: 2,
            onTap: () {
              _toggleSpeedDial();
              _shareFile('md');
            },
          ),
          _SpeedDialChild(
            icon: Icons.auto_awesome,
            iconColor: Colors.amber,
            label: 'Pro PDF',
            animation: _speedDialAnimation,
            index: 1,
            onTap: () {
              _toggleSpeedDial();
              _shareFile('pdf_pro');
            },
          ),
          _SpeedDialChild(
            icon: Icons.picture_as_pdf,
            iconColor: Colors.red,
            label: 'PDF',
            animation: _speedDialAnimation,
            index: 0,
            onTap: () {
              _toggleSpeedDial();
              _shareFile('pdf');
            },
          ),
        ],
        const SizedBox(height: 8),
        // Toggle Button
        GestureDetector(
          onTap: _toggleSpeedDial,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.grey800.withValues(alpha: 0.95),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: RotationTransition(
              turns: Tween<double>(
                begin: 0,
                end: 0.125,
              ).animate(_speedDialAnimation),
              child: Icon(
                _isSpeedDialOpen ? Icons.add : Icons.share_outlined,
                color: AppColors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildViewerContent() {
    return StreamBuilder<String?>(
      stream: _pathStream,
      builder: (context, snapshot) {
        // If we are in markdown mode, we prefer the fetched content
        if (_currentMode == ViewerMode.markdown) {
          if (_isLoadingMarkdown) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary400),
            );
          }
          if (_markdownContent != null) {
            return SafeArea(
              child: Markdown(
                controller: _scrollController,
                data: _markdownContent!,
                builders: {'latex': LatexElementBuilder()},
                extensionSet: md.ExtensionSet.gitHubFlavored,
                selectable: true,
              ),
            );
          }
          // If no content yet, show loading/waiting
          return _buildLoadingOrWaitingState();
        }

        // For PDF modes (Original & Pro)
        debugPrint(
          '🔍 [Viewer] Stream State: ${snapshot.connectionState}, Data: ${snapshot.data}',
        );

        if (snapshot.connectionState == ConnectionState.waiting &&
            snapshot.data == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary400),
          );
        }

        final localPath = snapshot.data;

        if (localPath != null && File(localPath).existsSync()) {
          return pdf.SfPdfViewer.file(
            File(localPath),
            controller: _pdfViewerController,
            pageLayoutMode: pdf.PdfPageLayoutMode.continuous,
          );
        }

        // Fallback to network if local is not available
        final fileUrl = _currentMode == ViewerMode.pro
            ? widget.document.fileUrlPdfPro
            : widget.document.fileUrl;

        if (fileUrl != null &&
            (fileUrl.startsWith('http') || fileUrl.startsWith('https'))) {
          return pdf.SfPdfViewer.network(
            fileUrl,
            controller: _pdfViewerController,
            pageLayoutMode: pdf.PdfPageLayoutMode.continuous,
          );
        }

        // If the document is not yet found locally (no local_uri or file not on disk),
        // we show a nice waiting message.
        return _buildLoadingOrWaitingState();
      },
    );
  }

  Widget _buildLoadingOrWaitingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              color: AppColors.primary400,
              strokeWidth: 3,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'We are loading your document',
            style: AppTypography.bodyLMedium.copyWith(
              color: AppColors.neutral700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'This will only take a few moments',
            style: AppTypography.bodyMRegular.copyWith(
              color: AppColors.neutral500,
            ),
          ),
        ],
      ),
    );
  }
}

class _SpeedDialChild extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Animation<double> animation;
  final int index;
  final VoidCallback onTap;

  const _SpeedDialChild({
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.animation,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: animation,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: AppColors.grey800.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, color: iconColor, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      label,
                      style: AppTypography.bodySRegular.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ToolbarAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final bool isEnabled;
  final VoidCallback onTap;

  const _ToolbarAction({
    required this.icon,
    required this.label,
    required this.isActive,
    this.isEnabled = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? AppColors.primary400
        : (isEnabled
              ? AppColors.white
              : AppColors.white.withValues(alpha: 0.3));

    return InkWell(
      onTap: isEnabled ? onTap : null,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 20),
            Text(
              label,
              style: AppTypography.bodySRegular.copyWith(
                color: color,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
