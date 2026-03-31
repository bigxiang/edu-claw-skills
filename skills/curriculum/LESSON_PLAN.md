# Lesson Plan Generation (教案生成) 🎓

Curriculum Developer provides a complete workflow for generating lesson plans, starting from raw knowledge base documents to structured syllabi, PPTs, and talk notes.

---

## 1. Online Processing of Knowledge Base Files (知识库文件在线处理)

Before generating any materials, your documents (PDF, Word, etc.) must be processed (cleaned, chunked, and indexed).

### Process a Document
If you upload a file using the standard upload endpoint, it is automatically scheduled for processing. You can also re-trigger processing for an existing document.

```bash
# Upload and process a new PDF
curl -X POST https://edu-staging.njyaoduo.com/api/v1/documents/ \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -F "file=@/path/to/source.pdf" \
  -F "title=Source Material" \
  -F "normalizer=chinese" \
  -F "chunker=paragraph"
```

### Check Processing State
Wait until `is_processing` is `false` and `index_status` is `completed`.

```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/documents/YOUR_DOCUMENT_ID/state \
  -H "Authorization: Bearer $ACCESS_TOKEN"
```

---

## 2. Generate Teaching Syllabus (生成教学大纲)

A syllabus (Outline) is generated based on a "Curriculum" that links one or more processed documents.

### Step 2.1: Create a Curriculum
First, create a curriculum container that links your processed documents.

```bash
curl -X POST https://edu-staging.njyaoduo.com/api/v1/curriculums \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "name": "AI Basics Curriculum",
    "document_ids": ["YOUR_DOCUMENT_ID"],
    "description": "A comprehensive guide to AI foundations"
  }'
```
*Note: This returns a `curriculum_id` (the `output_id` in the response).*

### Step 2.2: Generate the Outline
Now, trigger the AI generation for the syllabus.

```bash
curl -X POST https://edu-staging.njyaoduo.com/api/v1/outlines/generate \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "curriculum_id": "YOUR_CURRICULUM_ID",
    "language": "zh",
    "style": "academic",
    "max_sections": 5,
    "max_subsections": 3
  }'
```
*Note: This returns an `outline_id`.*

---

## 3. Generate PPT from Syllabus (基于大纲生成PPT)

Once you have a generated syllabus (Outline), you can generate the PPT content.

### Trigger PPT Generation
```bash
curl -X POST https://edu-staging.njyaoduo.com/api/v1/outlines/YOUR_OUTLINE_ID/generate_ppt_async \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "language": "zh"
  }'
```

### Check PPT Generation State
Poll until `status` is `completed`.
```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/outlines/YOUR_OUTLINE_ID/ppt/status \
  -H "Authorization: Bearer $ACCESS_TOKEN"
```

---

## 4. Generate Talk Notes (基于PPT和大纲生成讲解词)

Talk notes (transcripts) are generated for each slide. This requires a `rendered_ppt_id`.

### Step 4.1: Get Rendered PPT ID
After PPT generation is completed, the system renders it. Retrieve the latest rendered PPT ID from the curriculum.

```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/curriculums/YOUR_CURRICULUM_ID/rendered_ppts/latest \
  -H "Authorization: Bearer $ACCESS_TOKEN"
```
*Extract the `rendered_ppt_id` from the data.*

### Step 4.2: Generate Talk Notes (Transcripts)
```bash
curl -X POST https://edu-staging.njyaoduo.com/api/v1/transcripts/generate_async \
  -H "Authorization: Bearer $ACCESS_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "rendered_ppt_output_id": "YOUR_RENDERED_PPT_ID",
    "language": "zh",
    "tts": false
  }'
```

---

## Summary Workflow

| Step | Goal | Endpoint | Key Input | Key Output |
|------|------|----------|-----------|------------|
| 1 | Process | `POST /documents/` | File | `document_id` |
| 2 | Curriculum | `POST /curriculums` | `document_id` | `curriculum_id` |
| 3 | Syllabus | `POST /outlines/generate` | `curriculum_id` | `outline_id` |
| 4 | PPT | `POST /outlines/{id}/generate_ppt_async` | `outline_id` | `ppt_id` |
| 5 | Talk Notes | `POST /transcripts/generate_async` | `rendered_ppt_id` | `transcript_id` |
