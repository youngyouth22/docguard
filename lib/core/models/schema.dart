import 'package:powersync_core/powersync_core.dart';

Schema schema = Schema([
  Table('documents', [
    Column.text('user_id'),
    Column.text('report_type'),
    Column.text('doc_category'),
    Column.text('owner_full_name'),
    Column.text('doc_number'),
    Column.text('description'),
    Column.text('file_url'),
    Column.real('latitude'),
    Column.real('longitude'),
    Column.text('city'),
    Column.text('neighborhood'),
    Column.text('status'),
    Column.integer('ai_processed'),
    Column.text('ai_metadata'),
    Column.text('created_at'),
    Column.text('updated_at'),
    Column.text('country_code'),
    Column.text('file_type')
  ]),
  Table('profiles', [
    Column.text('full_name'),
    Column.text('phone_number'),
    Column.text('avatar_url'),
    Column.text('created_at'),
    Column.text('updated_at')
  ]),
  Table('m', [
    Column.text('lost_document_id'),
    Column.text('found_document_id'),
    Column.real('confidence_score'),
    Column.integer('is_notified'),
    Column.text('created_at')
  ])
]);
