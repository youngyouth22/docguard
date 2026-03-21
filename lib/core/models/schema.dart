import 'package:powersync_core/attachments/attachments.dart';
import 'package:powersync_core/powersync_core.dart';

Schema schema =  Schema([
  const Table('categories', [
    Column.text('name'),
    Column.integer('is_official'),
    Column.text('created_at'),
  ]),
  const Table('documents', [
    Column.text('user_id'),
    Column.text('category_id'),
    Column.text('owner_full_name'),
    Column.text('doc_number'),
    Column.text('description'),
    Column.text('city'),
    Column.text('neighborhood'),
    Column.text('country_code'),
    Column.text('file_url'),
    Column.text('file_extension'),
    Column.text('file_url_word'),
    Column.text('file_url_pdf_pro'),
    Column.text('file_url_markdown'),
    Column.text('extracted_content'),
    Column.text('report_type'),
    Column.text('status'),
    Column.integer('ai_processed'),
    Column.integer('is_favorite'),
    Column.text('thumbnail_url'),
    Column.text('thumbnail_extension'),
    Column.integer('file_size'),
    Column.text('ai_metadata'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
  const Table('profiles', [
    Column.text('full_name'),
    Column.text('phone_number'),
    Column.text('avatar_url'),
    Column.text('created_at'),
    Column.text('updated_at'),
  ]),
  AttachmentsQueueTable(attachmentsQueueTableName: 'attachments',),
]);
