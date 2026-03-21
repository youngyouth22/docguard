import 'package:docguard/common/app_colors.dart';
import 'package:docguard/common/image_resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:flutter_svg/svg.dart';
import 'package:docguard/features/documents/presentation/blocs/document_event.dart';
import 'package:docguard/features/documents/presentation/blocs/document_bloc.dart';

class FloatingScannerButton extends StatefulWidget {
  const FloatingScannerButton({super.key});

  @override
  State<FloatingScannerButton> createState() => _FloatingScannerButtonState();
}

class _FloatingScannerButtonState extends State<FloatingScannerButton> {
   Future<void> _scanDocument() async {
    try {
      final result = await FlutterDocScanner().getScannedDocumentAsPdf();
      if (result == null) return; // User cancelled

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Uploading scanned document...')),
        );
        context.read<DocumentBloc>().add(
              DocumentEvent.scannedDocumentUploadRequested(result.pdfUri),
            );
      }
    } on DocScanException catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Scan failed: ${e.message}')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error during scan: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        onPressed: _scanDocument,
        shape: const CircleBorder(),
        backgroundColor: AppColors.primary400,
        foregroundColor: AppColors.white,
        elevation: 0,
        child: SvgPicture.asset(
          ImageResources.scanCheckSelect,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
        ),
      );
  }
}