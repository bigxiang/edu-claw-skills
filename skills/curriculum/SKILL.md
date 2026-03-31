---
name: curriculum
version: 1.0.0
description: Curriculum Developer Platform - Automate curriculum creation, manage knowledge bases, and process documents with AI.
metadata: {"emoji":"📚","category":"education","api_base":"/api/v1"}
---

# Curriculum Developer 📚

The ultimate platform for AI-powered curriculum development. Manage your knowledge base, upload documents for processing, and generate comprehensive learning materials.

## Skill Files

| File | Path |
|------|------|
| **SKILL.md** (this file) | `skills/curriculum/SKILL.md` |
| **AUTH.md** | `skills/curriculum/AUTH.md` |
| **KNOWLEDGE.md** | `skills/curriculum/KNOWLEDGE.md` |
| **LESSON_PLAN.md** | `skills/curriculum/LESSON_PLAN.md` |
| **skill.json** (metadata) | `skills/curriculum/skill.json` |

---

## What is Curriculum Developer?

Curriculum Developer is a powerful toolset for educators and AI agents to:
- **Manage Knowledge Bases** — Organize documents into folders and retrieve them easily.
- **AI Document Processing** — Upload PDFs, Word docs, or text and let AI extract clean content, chunk it, and index it for RAG.
- **Curriculum Generation** — Create structured curriculums with syllabi (outlines), PPTs, videos, and quizzes from your processed documents.
- **Talk Notes (讲解词)** — Generate slide-by-slide scripts for your curriculum based on PPT and syllabus.
- **Workflow Automation** — Automate the entire pipeline from file upload to final learning material.

---

## Quick Start

### 1. Authenticate

You need an account to use the platform. Authentication provides a JWT token for all subsequent requests.

```bash
# Login to get your access token
curl -X POST https://edu-staging.njyaoduo.com/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "admin@example.com", "password": "Yd123456"}'
```

### 2. List Knowledge Base

Check your existing documents in the knowledge base.

```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/documents/ \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN"
```

### 3. Upload a Document

Add a new PDF to your knowledge base for processing.

```bash
curl -X POST https://edu-staging.njyaoduo.com/api/v1/documents/ \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  -F "file=@/path/to/your/document.pdf" \
  -F "title=My New Curriculum Source"
```

### 4. Download a File

Retrieve a file from the platform.

```bash
curl -X GET https://edu-staging.njyaoduo.com/api/v1/org/attachments/YOUR_DOCUMENT_ID/download \
  -H "Authorization: Bearer YOUR_ACCESS_TOKEN" \
  --output downloaded_file.pdf
```

---

## API Endpoints Summary

| Feature | Endpoint | Method | Description |
|---------|----------|--------|-------------|
| **Auth** | `/auth/login` | POST | Login and get JWT token |
| **Auth** | `/auth/me` | GET | Get current user profile |
| **Knowledge** | `/documents/` | GET | List knowledge base documents |
| **Knowledge** | `/documents/` | POST | Upload and process new document |
| **Knowledge** | `/documents/{id}` | DELETE | Remove document from knowledge base |
| **Download** | `/org/attachments/{id}/download` | GET | Download original file |

---

## Credentials Storage

You can store your access token securely to avoid re-authenticating frequently.

```json
{
  "access_token": "your_jwt_token_here",
  "email": "your_email@example.com",
  "org_id": "your_organization_id"
}
```

---

## Security Principles

1. **Tokens are sensitive** — Your JWT token grants full access to your organization's data.
2. **RLS Scoping** — The platform uses Row Level Security (RLS) to ensure you only access data within your organization.
3. **Quota Managed** — Document uploads and AI generations are subject to your account's quotas.

---

## Need Help?

- 📖 Full API Design Conventions: `src/api/API_DESIGN_CONVENTIONS.md`
- 🛠️ Internal Implementation: `src/api/v1/`
