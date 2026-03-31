# Curriculum Knowledge Base 📂

The Curriculum Developer Platform Knowledge Base is a collection of structured documents that you can organize into folders and use as input for AI-powered curriculum generation.

## Base URL: `/api/v1/documents/`

Your access to the knowledge base is scoped to your organization through RLS.

---

## 1. List Your Knowledge Base

Check existing documents in your knowledge base.

### List All Documents
```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/documents/ \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN" -s | jq '.'
```

### Filtering and Pagination
| Query Parameter | Description |
|-----------------|-------------|
| `filter_type` | `all`, `processed`, `pending`, `failed`, `recent` |
| `limit` | Number of documents to skip |
| `offset` | Number of documents skip |

### Example Response
```json
{
  "data": [
    {
      "document_id": "8b29a994-a2d5-48a3-a66f-01dc142a9f38",
      "original_name": "ai_foundations.pdf",
      "file_size": 125460,
      "upload_time": "2026-03-25T10:33:20Z",
      "mime_type": "application/pdf"
    }
  ],
  "meta": {
    "total": 1,
    "limit": 50,
    "offset": 0
  }
}
```

---

## 2. Upload Specified PDF File

Upload a new document to the knowledge base.

### Create and Process Document
Whenever you upload a file, the platform automatically schedules it for AI processing (cleaning, chunking, and indexing).

```bash
# Upload a PDF file
curl -X POST https://edu-staging.njyaoduo.com/api/v1/documents/ \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/path/to/your/lesson_plan.pdf" \
  -F "title=Lesson Plan - Week 1"
```

### Custom Processing Options
You can fine-tune the AI processing behavior:
- `normalizer`: `chinese`, `english`, `code`
- `chunker`: `paragraph`, `markdown`, `token`
- `max_chunk`: Max characters per chunk (default 1024)

### Example Response
```json
{
  "status": "processing",
  "message": "File 'lesson_plan.pdf' uploaded successfully, processing started in background.",
  "document_id": "8b29a994-a2d5-48a3-a66f-01dc142a9f38",
  "details": {
    "is_processing": true,
    "processing_stage": "uploaded"
  }
}
```

---

## 3. Download Knowledge Base File

Retrieve a file from the platform using its ID.

### Download Original File
```bash
# Use organization attachment download endpoint
curl -X GET https://edu-staging.njyaoduo.com/api/v1/org/attachments/YOUR_DOCUMENT_ID/download \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN" \
  --output ./document_download.pdf
```

---

## 4. Delete Knowledge Base File

Remove a document once it is no longer needed.

```bash
curl -X DELETE https://edu-staging.njyaoduo.com/api/v1/documents/YOUR_DOCUMENT_ID \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN"
```

---

## 5. View Document State

Check if a document has been successfully processed.

```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/documents/YOUR_DOCUMENT_ID/state \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN"
```

### Expected State Values
```json
{
  "document_id": "8b29a994-a2d5-48a3-a66f-01dc142a9f38",
  "has_clean": true,
  "has_chunks": true,
  "has_index": true,
  "index_status": "completed",
  "suggested_step": 3,
  "is_processing": false
}
```

---

## Folder Support (Optional)

You can organize your knowledge base into folders.

1. **Create Folder**: `POST /folders/` (Body: `{"name": "Week 1", "parent_id": null}`)
2. **Move Document**: `PATCH /documents/{id}/move` (Body: `{"folder_id": "folder_uuid"}`)
3. **Get Folder Tree**: `GET /folders/tree`
