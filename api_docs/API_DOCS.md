# Curriculum API (v1.0.0)

API for managing curriculum content

## GET /

**Summary**: Root

## GET /health

**Summary**: Health Check

## GET /health/database

**Summary**: Database Health

Detailed database health check endpoint.

## GET /health/migration-status

**Summary**: Migration Status

Migration monitoring endpoint - tracks deprecated endpoint usage.

Returns statistics about deprecated endpoint usage to monitor
frontend migration progress.

**Deprecated endpoints** will be removed on 2026-07-26.

## GET /api/v1/documents/{document_id}/state

**Summary**: Get Document State

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

## POST /api/v1/documents/{document_id}/run-all

**Summary**: Run All Steps

Run all remaining pipeline steps from current step using the service's state-aware runner.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProcessingRequest`

## GET /api/v1/documents/{document_id}/clean

**Summary**: Get Clean Content

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

## PUT /api/v1/documents/{document_id}/clean

**Summary**: Update Clean Content

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

### Request Body
- `application/x-www-form-urlencoded`: Reference `Body_update_clean_content_api_v1_documents__document_id__clean_put`

## POST /api/v1/documents/

**Summary**: Create Document

Create a document by uploading a file and immediately schedule processing.

Returns a ProcessingResponse containing the document_id for frontend polling.

### Request Body
- `multipart/form-data`: Reference `Body_create_document_api_v1_documents__post`

## GET /api/v1/documents/

**Summary**: List Documents

List documents using database-only metadata.

File system is not consulted for listings.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| filter_type | query | False | string | Filter type: 'all' or 'recent' |
| limit | query | False | integer | Number of documents to return |
| offset | query | False | integer | Number of documents to skip |

## DELETE /api/v1/documents/{document_id}

**Summary**: Delete Document

Delete a document by metadata first, then cleanup binary files.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

## PATCH /api/v1/documents/{document_id}/move

**Summary**: Move Document

Move a document to a folder.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DocumentMoveRequest`

## POST /api/v1/folders/

**Summary**: Create Folder

Create a new folder.

### Request Body
- `application/json`: Reference `FolderCreateRequest`

## PATCH /api/v1/folders/{folder_id}

**Summary**: Update Folder

Update a folder (rename or move).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| folder_id | path | True | string |  |

### Request Body
- `application/json`: Reference `FolderUpdateRequest`

## DELETE /api/v1/folders/{folder_id}

**Summary**: Delete Folder

Delete a folder. Must be empty.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| folder_id | path | True | string |  |

## GET /api/v1/folders/tree

**Summary**: Get Folder Tree

Get the full folder and document tree structure.

## POST /api/v1/outlines/generate

**Summary**: Generate Outline Async

Generate a curriculum outline asynchronously.

Creates an initial outline record and triggers a background task.
Returns the created outline immediately.

### Request Body
- `application/json`: Reference `OutlineGeneration`

## POST /api/v1/outlines/api/v1/curriculums/{curriculum_id}/outlines/create_with_tree

**Summary**: Create Outline With Tree

Create an empty outline with associated tree structure.

This endpoint is used when the user wants to build an outline tree from scratch.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/outlines/{outline_id}

**Summary**: Get Outline

Get a specific generated outline.

Args:
    outline_id: Outline ID

Returns:
    dict: The outline content and metadata

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## PUT /api/v1/outlines/{outline_id}

**Summary**: Update Outline

Update a specific outline.

Args:
    outline_id: Outline ID
    request: Update request containing new content/title

Returns:
    dict: The updated outline content and metadata

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineUpdate`

## POST /api/v1/outlines/{outline_id}/generate_ppt_async

**Summary**: Generate Ppt Content Async

Generate PPT content for a specific outline.

Args:
    outline_id: Outline ID to generate PPT for
    request: PPT generation request parameters

Returns:
    GeneratePPTAsyncResponse: Status and IDs for tracking generation

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

### Request Body
- `application/json`: Reference `GeneratePPTAsyncRequest`

## GET /api/v1/outlines/{outline_id}/ppt/status

**Summary**: Get Ppt Status

Return latest PPT status with saved slide count for an outline.

Used by frontend polling to decide when to fetch full PPT data.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## POST /api/v1/outline-node-attachments/upload

**Summary**: Upload Attachment

Upload an attachment for an outline node.

### Request Body
- `multipart/form-data`: Reference `Body_upload_attachment_api_v1_outline_node_attachments_upload_post`

## PUT /api/v1/outline-node-attachments/{attachment_id}

**Summary**: Replace Attachment

Replace an existing attachment.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_replace_attachment_api_v1_outline_node_attachments__attachment_id__put`

## DELETE /api/v1/outline-node-attachments/{attachment_id}

**Summary**: Delete Attachment

Delete an attachment.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## GET /api/v1/outline-node-attachments/node/{outline_node_id}

**Summary**: List Attachments

List attachments for an outline node.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_node_id | path | True | string |  |

## GET /api/v1/outlines/public/{outline_id}/tree

**Summary**: Get Public Outline Tree

Get public outline tree for learning.

Only works for outlines belonging to approved and active curriculums.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## GET /api/v1/outlines/{outline_id}/tree

**Summary**: Get Outline Tree

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## POST /api/v1/outlines/{outline_id}/tree/nodes

**Summary**: Create Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeCreateRequest`

## POST /api/v1/outlines/tree/nodes/{node_id}/move

**Summary**: Move Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeMoveRequest`

## PATCH /api/v1/outlines/tree/nodes/{node_id}

**Summary**: Update Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeUpdateRequest`

## DELETE /api/v1/outlines/tree/nodes/{node_id}

**Summary**: Delete Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

## PUT /api/v1/outlines/tree/nodes/{node_id}/text-content

**Summary**: Update Outline Node Text Content

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeTextUpdateRequest`

## GET /api/v1/ppt-templates/

**Summary**: Get Templates

Get all PPT templates.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| q | query | False | string | Search query for template name |
| page | query | False | integer | Page number |
| page_size | query | False | integer | Items per page |

## POST /api/v1/ppt-templates/

**Summary**: Create Template

Create a new PPT template.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

### Request Body
- `application/json`: Reference `PPTTemplateCreateRequest`

## GET /api/v1/ppt-templates/public

**Summary**: Get Public Templates

Get all approved and active PPT templates.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/public` instead.
    This endpoint will be removed on 2026-07-26.

No authentication required, returns only approved and active templates.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| q | query | False | string | Search query for template name |
| page | query | False | integer | Page number |
| page_size | query | False | integer | Items per page |

## GET /api/v1/ppt-templates/{template_id}

**Summary**: Get Template

Get a specific PPT template by ID.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/{template_id}` instead.
    This endpoint will be removed on 2026-07-26.

Requires authentication. Returns templates that are either:
- Created by the current user
- Approved and active (public templates)

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## PUT /api/v1/ppt-templates/{template_id}

**Summary**: Update Template

Update an existing PPT template.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/{template_id}` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

### Request Body
- `application/json`: Reference `PPTTemplateUpdateRequest`

## DELETE /api/v1/ppt-templates/{template_id}

**Summary**: Delete Template

Delete a PPT template.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/{template_id}` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/ppt-templates/from-pptx

**Summary**: Create Template From Pptx

Create a template from a PPTX file.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/from-pptx` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

## POST /api/v1/ppt-templates/{template_id}/submit

**Summary**: Submit Template

Submit a PPT template for approval.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/{template_id}/submit` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/ppt-templates/{template_id}/approve

**Summary**: Approve Template

Approve a submitted PPT template.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/{template_id}/approve` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/ppt-templates/{template_id}/reject

**Summary**: Reject Template

Reject a submitted PPT template.

.. deprecated::
    Use `/api/v1/org-admin/ppt-templates/{template_id}/reject` instead.
    This endpoint will be removed on 2026-07-26.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/curriculums

**Summary**: Create Curriculum

Create a curriculum with multiple documents.

### Request Body
- `application/json`: Reference `CurriculumCreateRequest`

## GET /api/v1/curriculums/public

**Summary**: List Public Curriculums

List publicly available curriculums.

.. deprecated::
    Use `/api/v1/org/curriculums/public` instead.
    This endpoint will be removed on 2026-07-26.

Only returns curriculums that are approved and active.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| difficulty_level | query | False |  |  |
| min_duration | query | False |  |  |
| max_duration | query | False |  |  |
| search | query | False |  |  |
| resource_type_id | query | False |  |  |

## GET /api/v1/curriculums/public/{curriculum_id}

**Summary**: Get Public Curriculum By Id

Get public curriculum metadata by curriculum ID.

.. deprecated::
    Use `/api/v1/org/curriculums/public/{curriculum_id}` instead.
    This endpoint will be removed on 2026-07-26.

Only returns approved and active curriculums.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/public/{curriculum_id}/outlines/latest

**Summary**: Get Public Latest Outline

Get the latest public outline for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/public/{curriculum_id}/transcripts/latest

**Summary**: Get Public Latest Transcripts

Get the latest public transcript content and metadata for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/public/{curriculum_id}/ppts/latest

**Summary**: Get Public Latest Ppt

Get the latest public PPT content and metadata for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/public/{curriculum_id}/rendered_ppts/latest

**Summary**: Get Public Latest Rendered Ppt

Get the latest public rendered PPT content and metadata for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/

**Summary**: List Curriculums

List documents that have a curriculum (one per doc).

Returns a normalized envelope: { data: [...], meta: { total, limit, offset } }

Supports filtering by:
- difficulty_level: beginner, intermediate, advanced
- min_duration/max_duration: duration range in minutes
- search: search term in name or description
- status: draft, pending, approved, rejected
- is_active: true/false
- resource_type_id: filter by resource type

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| difficulty_level | query | False |  |  |
| min_duration | query | False |  |  |
| max_duration | query | False |  |  |
| search | query | False |  |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |

## GET /api/v1/curriculums/by-curriculum

**Summary**: Get Curriculum By Id Missing Param

Handle requests to by-curriculum without parameter.

## GET /api/v1/curriculums/by-curriculum/{curriculum_id}

**Summary**: Get Curriculum By Id

Get curriculum metadata by curriculum ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/{curriculum_id}/outlines/latest

**Summary**: Get Latest Outline

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/{curriculum_id}/ppts/latest

**Summary**: Get Latest Ppt

Get the latest PPT content and metadata for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/{curriculum_id}/rendered_ppts/latest

**Summary**: Get Latest Rendered Ppt

Get the latest rendered PPT content and metadata for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/curriculums/{curriculum_id}/transcripts/latest

**Summary**: Get Latest Transcripts

Get the latest transcript content and metadata for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## POST /api/v1/curriculums/{curriculum_id}/qa/

**Summary**: Curriculum Qa

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

### Request Body
- `application/json`: Reference `QARequest`

## PUT /api/v1/curriculums/{curriculum_id}

**Summary**: Update Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

### Request Body
- `application/json`: Reference `CurriculumUpdateRequest`

## POST /api/v1/curriculums/{curriculum_id}/practice-questions

**Summary**: Add Practice Questions

Add existing questions to curriculum as practice questions.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AddPracticeQuestionsRequest`

## GET /api/v1/curriculums/{curriculum_id}/practice-questions

**Summary**: Get Practice Questions

Get practice questions for a curriculum with pagination.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## PATCH /api/v1/curriculums/{curriculum_id}/submit

**Summary**: Submit Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## PATCH /api/v1/curriculums/{curriculum_id}/approve

**Summary**: Approve Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## PATCH /api/v1/curriculums/{curriculum_id}/reject

**Summary**: Reject Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## PATCH /api/v1/curriculums/{curriculum_id}/practice-questions/{question_id}

**Summary**: Update Practice Question

Update a practice question in a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| question_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UpdatePracticeQuestionRequest`

## GET /api/v1/curriculum-sets/public

**Summary**: List Curriculum Sets Public

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| created_by_id | query | False |  |  |
| search | query | False |  |  |
| min_minutes | query | False |  |  |
| max_minutes | query | False |  |  |
| difficulty | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| name | query | False |  | Filter by curriculum name |
| created_by_name | query | False |  | Filter by person in charge name |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/curriculum-sets/public/{id}

**Summary**: Get Curriculum Set Public

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/curriculum-sets/my-purchased

**Summary**: List My Purchased Curriculum Sets

List curriculum sets purchased by the current user.

.. deprecated::
    Use `/api/v1/org/curriculum-sets/my-purchased` instead.
    This endpoint will be removed on 2026-07-26.

Returns curriculum sets that the user has valid access to through purchases.
Items are considered valid if:
- expire_time is None (permanent access)
- expire_time is in the future (still within valid period)

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/curriculum-sets/management/stats

**Summary**: Get Curriculum Management Stats

Get curriculum management statistics for the organization.

.. deprecated::
    Use `/api/v1/org-admin/curriculum-sets/management/stats` instead.
    This endpoint will be removed on 2026-07-26.

## POST /api/v1/curriculum-sets/

**Summary**: Create Curriculum Set

Create a curriculum set.

.. deprecated::
    Use `/api/v1/org-admin/curriculum-sets/` (POST) instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `CurriculumSetCreateRequest`

## GET /api/v1/curriculum-sets/

**Summary**: List Curriculum Sets

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| created_by_id | query | False |  |  |
| search | query | False |  |  |
| min_minutes | query | False |  |  |
| max_minutes | query | False |  |  |
| difficulty | query | False |  |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| name | query | False |  | Filter by curriculum name |
| created_by_name | query | False |  | Filter by person in charge name |

## PATCH /api/v1/curriculum-sets/{id}

**Summary**: Update Curriculum Set

Update a curriculum set.

.. deprecated::
    Use `/api/v1/org-admin/curriculum-sets/{id}` (PATCH) instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `CurriculumSetUpdateRequest`

## GET /api/v1/curriculum-sets/{id}

**Summary**: Get Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/curriculum-sets/{id}

**Summary**: Delete Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/curriculum-sets/my-tasks

**Summary**: List My Tasks

List curriculum sets that the current user has started but not finished.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## PATCH /api/v1/curriculum-sets/{id}/submit

**Summary**: Submit Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/curriculum-sets/{id}/approve

**Summary**: Approve Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/curriculum-sets/{id}/reject

**Summary**: Reject Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/curriculum-sets/{id}/progress

**Summary**: Get Curriculum Set Progress

Get progress for a curriculum set.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/curriculum-sets/{id}/resume

**Summary**: Get Curriculum Set Resume Position

Get resume position for a curriculum set.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/curriculum-sets/{id}/progress/recalculate

**Summary**: Recalculate Curriculum Set Progress

Recalculate progress for a curriculum set.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/curriculum-question-instances/next-question

**Summary**: Get next unanswered question

Get the next unanswered question for a progress record.

Returns the first question that hasn't been answered yet.
If all questions are answered, returns null.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## GET /api/v1/curriculum-question-instances/list-unanswered

**Summary**: List all unanswered questions

List all unanswered questions for a progress record.

Returns all questions that haven't been answered yet.
Useful for loading all questions at once for navigation and progress display.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## GET /api/v1/curriculum-question-instances/list-all

**Summary**: List all questions (answered and unanswered)

List all questions for a progress record.

Returns both answered and unanswered questions.
Allows users to review all questions and their answers.
Useful for navigation through completed practice and review mode.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## POST /api/v1/curriculum-question-instances/submit-answer

**Summary**: Submit answer and get feedback

Submit an answer and get immediate feedback.

Automatically updates progress after answer submission.

Request body:
- **progress_id**: Progress record ID
- **question_instance_id**: Question instance to answer
- **organization_id**: Organization ID
- **selected_option_ids**: Selected options (for choice questions)
- **answer_text**: Text answer (for fill-in-blank/open text)
- **time_spent_seconds**: Time taken to answer
- **answer_metadata**: Additional metadata
- **is_skipped**: Whether question was skipped

Response includes:
- **is_correct**: Whether answer was correct
- **correct_option_id/ids**: Correct answer(s)
- **explanation**: Question explanation
- **attempt_number**: Which attempt this is

### Request Body
- `application/json`: Reference `SubmitAnswerRequest`

## GET /api/v1/curriculum-question-instances/questions-with-incorrect-attempts

**Summary**: Get questions with incorrect attempts

Get questions that have at least one incorrect attempt.

Returns questions the user struggled with for final review.
Includes correct answers and explanations.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## GET /api/v1/curriculum-question-instances/stats

**Summary**: Get question statistics

Get detailed question statistics for a progress record.

Returns aggregate statistics and per-unit completion details.

- **progress_id**: Progress record ID

Response includes:
- **question_units_total**: Total number of question units
- **question_units_completed**: Units with all questions answered
- **question_completion_percentage**: Question unit completion percentage
- **questions_correct_count**: First attempts that were correct
- **questions_incorrect_count**: First attempts that were wrong
- **overall_completion_percentage**: Overall progress (slides + media + questions)
- **unit_completion_details**: Per-unit breakdown

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |

## GET /api/v1/curriculum-question-instances/unit-progress

**Summary**: Get question unit progress

Get progress for a specific question unit.

Returns detailed completion information for a single unit.

- **progress_id**: Progress record ID
- **outline_node_id**: Unit ID (null to get comprehensive questions)

Response includes:
- **outline_node_id**: Unit ID
- **total_questions**: Total questions in unit
- **answered_count**: Questions with at least one attempt
- **first_attempt_correct_count**: First attempts that were correct
- **completion_percentage**: Unit completion percentage

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter (null = comprehensive questions) |

## GET /api/v1/resource-types/public/tree

**Summary**: Get Resource Type Tree Public

Get all resource types as a tree structure for public display.

## GET /api/v1/resource-types/public/tree-with-counts

**Summary**: Get Resource Type Tree With Counts Public

Get all resource types as a tree structure with resource counts for public display.

## POST /api/v1/resource-types/

**Summary**: Create Resource Type

Create a new resource type.

### Request Body
- `application/json`: Reference `ResourceTypeCreateRequest`

## GET /api/v1/resource-types/

**Summary**: List Resource Types

List all resource types (flat list with pagination).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/resource-types/tree

**Summary**: Get Resource Type Tree

Get all resource types as a tree structure.

## GET /api/v1/resource-types/tree-with-counts

**Summary**: Get Resource Type Tree With Counts

Get all resource types as a tree structure with resource counts.

## GET /api/v1/resource-types/{id}

**Summary**: Get Resource Type

Get a resource type by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/resource-types/{id}

**Summary**: Update Resource Type

Update a resource type.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `ResourceTypeUpdateRequest`

## DELETE /api/v1/resource-types/{id}

**Summary**: Delete Resource Type

Delete a resource type.

Prevents deletion if the resource type has children or associated generation tasks.
Other references (questions, curriculums, exam papers, etc.) will be set to NULL.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/dictionaries/batch

**Summary**: Batch get dictionaries

Get multiple dictionaries by their type codes

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| codes | query | True | array |  |

## GET /api/v1/dictionaries/types

**Summary**: List dictionary types

List all dictionary types for current user's organization and system-wide types

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer | Number of records to skip |
| limit | query | False | integer | Maximum number of records to return |
| active_only | query | False | boolean | Only return active dictionary types |

## POST /api/v1/dictionaries/types

**Summary**: Create dictionary type

Create a new dictionary type.

### Request Body
- `application/json`: Reference `DictionaryTypeCreate`

## PUT /api/v1/dictionaries/types/{type_id}

**Summary**: Update dictionary type

Update a dictionary type.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| type_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DictionaryTypeUpdate`

## DELETE /api/v1/dictionaries/types/{type_id}

**Summary**: Delete dictionary type

Delete a dictionary type.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| type_id | path | True | string |  |

## POST /api/v1/dictionaries/values

**Summary**: Create dictionary value

Create a new dictionary value.

### Request Body
- `application/json`: Reference `DictionaryValueCreate`

## PUT /api/v1/dictionaries/values/{value_id}

**Summary**: Update dictionary value

Update a dictionary value.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| value_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DictionaryValueUpdate`

## DELETE /api/v1/dictionaries/values/{value_id}

**Summary**: Delete dictionary value

Delete a dictionary value.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| value_id | path | True | string |  |

## POST /api/v1/transcripts/generate_async

**Summary**: Generate Transcripts Async

### Request Body
- `application/json`: Reference `GenerateTranscriptRequest`

## GET /api/v1/transcripts/{rendered_ppt_id}

**Summary**: Get Transcript

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

## PUT /api/v1/transcripts/{rendered_ppt_id}

**Summary**: Update Transcript

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `TranscriptUpdateRequest`

## POST /api/v1/transcripts/slide

**Summary**: Generate Slide Transcript

Generate transcript for a single rendered slide.

### Request Body
- `application/json`: Reference `GenerateSlideTranscriptRequest`

## GET /api/v1/audios/{audio_id}/file

**Summary**: Serve Audio File

Serve an audio file by its ID.

.. deprecated::
    Use `/api/v1/org/audios/{audio_id}/file` instead.
    This endpoint will be removed on 2026-07-26.

- Retrieves audio metadata from database
- Uses the stored file_path directly from the database
- Serves the audio file with proper content-type headers
- Includes security checks and error handling

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| audio_id | path | True | string |  |

## POST /api/v1/audios/generate_all_async

**Summary**: Generate All Audios Async

### Request Body
- `application/json`: Reference `GenerateAudiosRequest`

## POST /api/v1/audios/generate

**Summary**: Generate Slide Audio

Generate or update audio for a single selected rendered slide.

- Finds the transcript by rendered slide ID
- Synthesizes audio via VoxCPM
- Stores audio using the new Audio model

### Request Body
- `application/json`: Reference `GenerateSlideAudioRequest`

## POST /api/v1/videos/upload

**Summary**: Upload Video

Upload a video file for a manual curriculum outline node.

Args:
    file: The video file to upload
    outline_node_id: ID of the outline node this video belongs to
    video_service: Injected video service
    current_user: Authenticated user
    session: Database session

Returns:
    VideoUploadResponse with video metadata

### Request Body
- `multipart/form-data`: Reference `Body_upload_video_api_v1_videos_upload_post`

## GET /api/v1/videos/{video_id}/file

**Summary**: Serve Video File

Serve a video file by its ID using JWT token authentication.

.. deprecated::
    Use `/api/v1/org/videos/{video_id}/file` instead.
    This endpoint will be removed on 2026-07-26.

- Authenticates user via JWT token (from header or query parameter)
- Retrieves video metadata from database
- Uses the stored file_path directly from the database
- Serves the video file with proper content-type headers
- Includes security checks and error handling

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| video_id | path | True | string |  |

## POST /api/v1/videos/generate

**Summary**: Generate Slide Video

Generate or update video for a single selected slide.

- Finds the slide and its corresponding audio file from the latest transcript for the curriculum.
- Generates video via HeyGem using the audio file.
- Registers video as a `video` artifact and updates the transcript.
- Requires that audio has been generated for the slide first.

### Request Body
- `application/json`: Reference `GenerateSlideVideoRequest`

## POST /api/v1/videos/generate_all_async

**Summary**: Generate All Videos Async

### Request Body
- `application/json`: Reference `GenerateVideosRequest`

## POST /api/v1/auth/register

**Summary**: Register User

Register a new user.

Args:
    user_data: User registration data

Returns:
    Created user information

Raises:
    HTTPException: If email already exists or registration fails

### Request Body
- `application/json`: Reference `UserRegister`

## POST /api/v1/auth/login

**Summary**: Login User

Authenticate user and return JWT tokens.

Args:
    user_credentials: User login credentials

Returns:
    JWT access and refresh tokens

Raises:
    HTTPException: If authentication fails

### Request Body
- `application/json`: Reference `UserLogin`

## POST /api/v1/auth/refresh

**Summary**: Refresh Token

Refresh access token using refresh token.

Args:
    body: JSON body containing `refresh_token`

Returns:
    New JWT access and refresh tokens

Raises:
    HTTPException: If refresh token is invalid

### Request Body
- `application/json`: Reference `TokenRefresh`

## GET /api/v1/auth/me

**Summary**: Get Current User Profile

Get current user profile.

Args:
    current_user: Current authenticated user
    auth_entry: Authentication entry service
    session: Database session with RLS context

Returns:
    Current user information

## PUT /api/v1/auth/me

**Summary**: Update Current User Profile

Update current user profile.

Args:
    user_update: User update data
    current_user: Current authenticated user

Returns:
    Updated user information

Raises:
    HTTPException: If update fails

### Request Body
- `application/json`: Reference `UserUpdate`

## PUT /api/v1/auth/me/learning-directions

**Summary**: Update Learning Directions

Update current user's learning directions.

Args:
    req: Learning directions update data
    current_user: Current authenticated user

Returns:
    Updated user information

### Request Body
- `application/json`: Reference `UserLearningDirectionsUpdateRequest`

## POST /api/v1/auth/change-password

**Summary**: Change Password

Change user password.

Args:
    password_change: Password change data
    current_user: Current authenticated user

Returns:
    Success message

Raises:
    HTTPException: If password change fails

### Request Body
- `application/json`: Reference `PasswordChange`

## POST /api/v1/auth/login/phone/code

**Summary**: Send Phone Verification Code

Send verification code to phone number.

Args:
    body: Request body containing phone number
    user_entry: User entry service

Returns:
    Success message

Raises:
    HTTPException: If sending fails

### Request Body
- `application/json`: Reference `SendVerificationCodeRequest`

## POST /api/v1/auth/login/phone

**Summary**: Login With Phone

Authenticate user with phone number and verification code.

Args:
    body: Request body containing phone number and code
    user_entry: User entry service

Returns:
    JWT access and refresh tokens

Raises:
    HTTPException: If authentication fails

### Request Body
- `application/json`: Reference `PhoneLoginRequest`

## POST /api/v1/auth/register/invitation

**Summary**: Register With Invitation

Register a new user through an invitation link.

This endpoint allows users to register by providing:
- Invitation code
- Email address
- Phone number (optional)
- Password

The user will automatically be assigned to the organization, department,
and role specified in the invitation.

Args:
    request: Invitation registration request

Returns:
    Created user information

Raises:
    HTTPException: If invitation is invalid or registration fails

### Request Body
- `application/json`: Reference `InvitationRegisterRequest`

## GET /api/v1/auth/organizations

**Summary**: List User Organizations

Get all organizations the user is a member of.

Uses admin_session to bypass RLS and retrieve all organization memberships,
not just the current organization's membership.

## POST /api/v1/auth/organizations/{target_org_id}/switch

**Summary**: Switch Organization

Switch user's current organization context.

Validates that user is a member of target organization,
then issues a new JWT token with updated current_org_id.

Uses admin_session to bypass RLS for cross-organization queries.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| target_org_id | path | True | string |  |

## POST /api/v1/certificates

**Summary**: Create a new certificate

Create a new certificate with acquisition conditions

### Request Body
- `application/json`: Reference `CertificateCreateRequest`

## GET /api/v1/certificates

**Summary**: List certificates

List certificates with pagination and filters

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| is_active | query | False |  |  |
| level | query | False |  |  |
| source_type | query | False |  |  |

## GET /api/v1/certificates/{certificate_id}

**Summary**: Get a certificate

Get a certificate by ID

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| certificate_id | path | True | string |  |

## PUT /api/v1/certificates/{certificate_id}

**Summary**: Update a certificate

Update an existing certificate

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| certificate_id | path | True | string |  |

### Request Body
- `application/json`: Reference `CertificateUpdateRequest`

## DELETE /api/v1/certificates/{certificate_id}

**Summary**: Delete a certificate

Delete a certificate by ID

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| certificate_id | path | True | string |  |

## POST /api/v1/user-favorites

**Summary**: Add a resource to user favorites

Add a resource (e.g., curriculum, curriculum set) to current user's favorites.

.. deprecated::
    Use `/api/v1/org-admin/user-favorites/` instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `UserFavoriteCreateRequest`

## GET /api/v1/user-favorites

**Summary**: List user favorites

Retrieve a list of resources favorited by current user.

.. deprecated::
    Use `/api/v1/org-admin/user-favorites/` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| object_type | query | False |  | Filter by object type (e.g., 'curriculum', 'curriculum_set') |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## DELETE /api/v1/user-favorites/{object_type}/{object_id}

**Summary**: Remove a resource from user favorites

Remove a resource from current user's favorites by its type and ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| object_type | path | True | string |  |
| object_id | path | True | string |  |

## GET /api/v1/user-favorites/curriculum-sets

**Summary**: List curriculum set favorites with enriched data

Retrieve curriculum set favorites with full curriculum set details.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/user-favorites/training-classes

**Summary**: List training class favorites with enriched data

Retrieve training class favorites with full training class details.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/user-favorites/exam-schedules

**Summary**: List exam schedule favorites with enriched data

Retrieve exam schedule favorites with full exam schedule details.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/user-certificates/my

**Summary**: List My Certificates

Get the current user's earned certificates.

.. deprecated::
    Use `/api/v1/org/user-certificates/my` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/platform/organizations

**Summary**: List Organizations

List all organizations (platform-wide view).

Requires: PLATFORM_RUNNER_ALL permission

Uses admin_session to bypass RLS and retrieve all organizations.
Includes platform-specific fields like member_count.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| search | query | False |  |  |
| type | query | False |  |  |
| is_active | query | False |  |  |

## POST /api/v1/platform/organizations

**Summary**: Create Organization

Create a new organization with an owner user.

Requires: PLATFORM_RUNNER_ALL permission

Creates both the organization and the owner user in a single transaction.
The owner user is created with the provided email, name, and phone,
and automatically becomes the first organization admin.

Note: Created organizations will have is_primary=False (set by DB default).
Only one organization can be primary (set by migration).

### Request Body
- `application/json`: Reference `OrganizationCreateRequest`

## GET /api/v1/platform/organizations/{id}

**Summary**: Get Organization

Get organization details (platform view).

Requires: PLATFORM_RUNNER_ALL permission

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/platform/organizations/{id}

**Summary**: Update Organization

Update an existing organization.

Requires: PLATFORM_RUNNER_ALL permission

Updates the organization's fields. Only the fields provided in the request
will be updated (partial update).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `OrganizationUpdateRequest`

## GET /api/v1/platform/organizations/{id}/analytics

**Summary**: Get Organization Analytics

Get analytics for a specific organization (platform view).

Requires: PLATFORM_RUNNER_ALL permission

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/platform/operators

**Summary**: List Platform Operators

List all platform operators.

Requires: PLATFORM_RUNNER_ALL permission

Returns all users with platform_operator role (system-wide).

## POST /api/v1/platform/operators

**Summary**: Create Platform Operator

Create a new platform operator.

Requires: PLATFORM_RUNNER_ALL permission

Creates a user with:
- platform_operator role (system-wide, cross-org access)
- owner role for primary organization
- unlimited quota in primary organization

### Request Body
- `application/json`: Reference `PlatformOperatorCreateRequest`

## PUT /api/v1/platform/operators/{id}

**Summary**: Update Platform Operator

Update a platform operator.

Requires: PLATFORM_RUNNER_ALL permission

Updates the operator's fields. Only the fields provided in the request
will be updated (partial update).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `PlatformOperatorUpdateRequest`

## GET /api/v1/platform/analytics

**Summary**: Get Platform Analytics

Get comprehensive platform-wide analytics (LEGACY - use specific endpoints).

This endpoint returns all metrics at once. For better performance,
consider using the specific endpoints:
- GET /analytics/summary - Fast overview stats
- GET /analytics/trends - 30-day growth trends
- GET /analytics/engagement - User engagement metrics
- GET /analytics/exams - Detailed exam metrics
- GET /analytics/content - Content performance metrics

Requires: PLATFORM_RUNNER_ALL permission

## GET /api/v1/platform/analytics/summary

**Summary**: Get Analytics Summary

Get fast platform summary statistics.

Lightweight endpoint for quick overview. Loads fastest as it only
requires simple count queries without complex joins.

Requires: PLATFORM_RUNNER_ALL permission

## GET /api/v1/platform/analytics/trends

**Summary**: Get Analytics Trends

Get 30-day growth trends.

Tracks platform growth over the last 30 days including:
- New user registrations
- User growth rate percentage
- New curriculums created
- New documents uploaded
- New enrollments
- Completed courses
- Exam attempts

Requires: PLATFORM_RUNNER_ALL permission

## GET /api/v1/platform/analytics/engagement

**Summary**: Get Analytics Engagement

Get user engagement and activity metrics.

Provides insights into:
- Daily/Weekly/Monthly active users (DAU/WAU/MAU)
- Learning session statistics
- Content interaction metrics

Requires: PLATFORM_RUNNER_ALL permission

## GET /api/v1/platform/analytics/exams

**Summary**: Get Analytics Exams

Get detailed exam analytics.

Returns comprehensive exam metrics:
- Attempt status breakdown (in_progress, submitted, expired, abandoned)
- Grading pipeline status (pending, partially, fully marked, published)
- Score statistics (avg, median, highest, lowest)
- Average completion time

Requires: PLATFORM_RUNNER_ALL permission

## GET /api/v1/platform/analytics/content

**Summary**: Get Analytics Content

Get content performance metrics.

Analyzes curriculum effectiveness:
- Distribution by difficulty level (beginner/intermediate/expert)
- Completion rates by difficulty
- Distribution by generation type (AI/manual)
- Distribution by status (draft/pending/approved/rejected)

Requires: PLATFORM_RUNNER_ALL permission

## GET /api/v1/users/me/learning-overview

**Summary**: Get My Learning Overview

Get the current user's learning progress overview.

.. deprecated::
    Use `/api/v1/org/users/me/learning-overview` instead.
    This endpoint will be removed on 2026-07-26.

## GET /api/v1/users

**Summary**: List Users

List users with pagination and filters.

.. deprecated::
    Use `/api/v1/org-admin/users` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer | Page number |
| limit | query | False | integer | Items per page |
| search | query | False |  | Search term for name/email |
| role | query | False |  | Filter by role |
| status | query | False |  | Filter by status |
| department_id | query | False |  | Filter by department ID |

## GET /api/v1/users/public

**Summary**: List Public Users

List active users with active roles only for public display.

.. deprecated::
    Use `/api/v1/org/users` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer | Page number |
| limit | query | False | integer | Items per page |
| search | query | False |  | Search term for name/email |
| role | query | False |  | Filter by active role |
| department_id | query | False |  | Filter by department ID |

## GET /api/v1/users/stats

**Summary**: Get User Stats

Get user statistics.

.. deprecated::
    Use `/api/v1/org-admin/users/stats` instead.
    This endpoint will be removed on 2026-07-26.

## GET /api/v1/users/{user_id}

**Summary**: Get User

Get user by ID.

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}` instead.
    This endpoint will be removed on 2026-07-26.

Args:
    user_id: User ID
    current_user: Current admin user

Returns:
    User information

Raises:
    HTTPException: If user not found

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

## PUT /api/v1/users/{user_id}

**Summary**: Update User

Update user (admin only).

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}` instead.
    This endpoint will be removed on 2026-07-26.

Args:
    user_id: User ID to update
    user_update: User update data with admin privileges (including quotas)
    current_user: Current admin user

Returns:
    Updated user information

Raises:
    HTTPException: If user not found or update fails

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserUpdateRequest`

## DELETE /api/v1/users/{user_id}

**Summary**: Delete User

Delete user (admin only).

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}` instead.
    This endpoint will be removed on 2026-07-26.

Args:
    user_id: User ID to delete
    current_user: Current admin user

Returns:
    Success message

Raises:
    HTTPException: If user not found or deletion fails

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

## POST /api/v1/users/

**Summary**: Create User

Create a new user with full admin options (quota, role, department).

.. deprecated::
    Use `/api/v1/org-admin/users/` instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `UserCreateRequest`

## POST /api/v1/users/batch-invite

**Summary**: Batch Invite Users

Batch invite users with auto-generated passwords (admin only).

.. deprecated::
    Use `/api/v1/org-admin/users/batch-invite` instead.
    This endpoint will be removed on 2026-07-26.

This endpoint creates multiple users at once with automatically generated passwords.
All invited users will be marked to change their password on first login.

Args:
    request: Batch invite request containing emails, role_ids, and optional department
    current_user: Current admin user
    user_entry: User entry service
    session: Database session

Returns:
    BatchInviteUsersResponse with created users and their generated passwords

Raises:
    HTTPException: If any email already exists or creation fails

### Request Body
- `application/json`: Reference `BatchInviteUsersRequest`

## GET /api/v1/users/{user_id}/quota

**Summary**: Get User Quota

Get user quota information.

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}/quota` instead.
    This endpoint will be removed on 2026-07-26.

Args:
    user_id: User ID
    current_user: Current admin user

Returns:
    User quota and usage information

Raises:
    HTTPException: If user not found

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

## PUT /api/v1/users/{user_id}/role

**Summary**: Update User Role

Assign roles to a user (Admin only).

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}/role` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserRoleUpdateRequest`

## PATCH /api/v1/users/{user_id}/department

**Summary**: Update User Department

Assign a department to a user (Admin only).

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}/department` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserDepartmentUpdateRequest`

## PUT /api/v1/users/{user_id}/password

**Summary**: Reset User Password

Reset user password.

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}/password` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `PasswordResetRequest`

## PUT /api/v1/users/{user_id}/status

**Summary**: Update User Status

Update user status.

.. deprecated::
    Use `/api/v1/org-admin/users/{user_id}/status` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserStatusUpdateRequest`

## POST /api/v1/organizations/

**Summary**: Create a new organization

Create a new organization.

### Request Body
- `application/json`: Reference `OrganizationCreateRequest`

## GET /api/v1/organizations/

**Summary**: List organizations

List organizations.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| search | query | False |  |  |
| type | query | False |  |  |
| is_active | query | False |  |  |

## GET /api/v1/organizations/{id}

**Summary**: Get organization by ID

Get organization by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/organizations/{id}

**Summary**: Update organization

Update organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `OrganizationUpdateRequest`

## DELETE /api/v1/organizations/{id}

**Summary**: Delete organization

Delete organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/organizations/{id}/members/

**Summary**: Add member to organization

Add member to organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `OrganizationMemberCreateRequest`

## GET /api/v1/organizations/{id}/members/

**Summary**: List organization members

List organization members.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/organizations/{id}/members/{member_id}

**Summary**: Get organization member

Get organization member.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| member_id | path | True | string |  |

## PUT /api/v1/organizations/{id}/members/{member_id}

**Summary**: Update organization member

Update organization member.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| member_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OrganizationMemberUpdateRequest`

## DELETE /api/v1/organizations/{id}/members/{member_id}

**Summary**: Remove member from organization

Remove member from organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| member_id | path | True | string |  |

## POST /api/v1/organizations/{id}/users/import/json

**Summary**: Bulk import users from JSON

Bulk import users from JSON.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserImportRequest`

## POST /api/v1/organizations/{id}/users/import/csv

**Summary**: Bulk import users from CSV

Bulk import users from CSV.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_import_users_csv_api_v1_organizations__id__users_import_csv_post`

## POST /api/v1/departments/

**Summary**: Create a new department

Create a new department.

.. deprecated::
    Use `/api/v1/org-admin/departments` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Request Body
- `application/json`: Reference `DepartmentCreateRequest`

## GET /api/v1/departments

**Summary**: List departments for management

List departments for management.

.. deprecated::
    Use `/api/v1/org-admin/departments` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| search | query | False |  |  |
| is_active | query | False |  |  |

## GET /api/v1/departments/public

**Summary**: List active departments for public display

List active departments for public display.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| search | query | False |  |  |

## GET /api/v1/departments/{id}

**Summary**: Get department by ID

Get department by ID.

.. deprecated::
    Use `/api/v1/org-admin/departments/{id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/departments/{id}

**Summary**: Update department

Update department.

.. deprecated::
    Use `/api/v1/org-admin/departments/{id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `DepartmentUpdateRequest`

## DELETE /api/v1/departments/{id}

**Summary**: Delete department

Delete department.

.. deprecated::
    Use `/api/v1/org-admin/departments/{id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/departments/{id}/move

**Summary**: Move department to a new parent

Move department to a new parent.

.. deprecated::
    Use `/api/v1/org-admin/departments/{id}/move` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `DepartmentMoveRequest`

## GET /api/v1/digital-teachers/public

**Summary**: List Teachers Public

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| name | query | False |  |  |

## GET /api/v1/digital-teachers

**Summary**: List Teachers

Admin view: List all digital teachers in the system.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| name | query | False |  |  |
| audit_status | query | False |  |  |
| is_shared | query | False |  |  |
| copyright_owner_name | query | False |  |  |

## POST /api/v1/digital-teachers

**Summary**: Create Teacher

### Request Body
- `multipart/form-data`: Reference `Body_create_teacher_api_v1_digital_teachers_post`

## GET /api/v1/digital-teachers/my

**Summary**: List My Teachers

User view: List digital teachers available to the current user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| name | query | False |  |  |

## GET /api/v1/digital-teachers/{teacher_id}

**Summary**: Get Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## PUT /api/v1/digital-teachers/{teacher_id}

**Summary**: Update Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_update_teacher_api_v1_digital_teachers__teacher_id__put`

## DELETE /api/v1/digital-teachers/{teacher_id}

**Summary**: Delete Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## GET /api/v1/digital-teachers/{teacher_id}/audio-file

**Summary**: Serve Teacher Audio

Serve the audio file for a digital teacher.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## GET /api/v1/digital-teachers/{teacher_id}/video-file

**Summary**: Serve Teacher Video

Serve the video file for a digital teacher.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## POST /api/v1/digital-teachers/{teacher_id}/submit

**Summary**: Submit Digital Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## POST /api/v1/digital-teachers/{teacher_id}/approve

**Summary**: Approve Digital Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## POST /api/v1/digital-teachers/{teacher_id}/reject

**Summary**: Reject Digital Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## PUT /api/v1/digital-teachers/{teacher_id}/status

**Summary**: Update Teacher Status

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DigitalTeacherStatusUpdateRequest`

## GET /api/v1/roles/functions

**Summary**: Get Available Functions

Get all available function codes with metadata for role assignment.

.. deprecated::
    Use `/api/v1/org-admin/roles/functions` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

Returns a dictionary of function codes and their metadata that can be
assigned to roles. This endpoint is used by the frontend to display
available permissions when creating or editing roles.

## GET /api/v1/roles/functions/categories

**Summary**: Get Available Functions By Category

Get all available function codes grouped by category.

.. deprecated::
    Use `/api/v1/org-admin/roles/functions/categories` instead.
    This endpoint will be removed on 2026-07-26.

Returns a list of categories, each containing its function codes and metadata.
This endpoint allows the frontend to fully organize categories and functions
based on backend configuration.

## POST /api/v1/roles

**Summary**: Create Role

Create a new role with permissions.

.. deprecated::
    Use `/api/v1/org-admin/roles` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

Args:
    request: Role creation request including name, description, and permissions
    current_user: Current authenticated admin user
    session: Database session

Returns:
    Created role with permissions

Raises:
    HTTPException: 400 if role name exists or invalid permissions

### Request Body
- `application/json`: Reference `RoleCreateRequest`

## GET /api/v1/roles

**Summary**: List Roles

List roles with optional active status filter.

.. deprecated::
    Use `/api/v1/org-admin/roles` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| is_active | query | False |  |  |

## PUT /api/v1/roles/{role_id}

**Summary**: Update Role

Update a role and its permissions.

.. deprecated::
    Use `/api/v1/org-admin/roles/{role_id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

Args:
    role_id: UUID of the role to update
    request: Role update request with optional fields
    current_user: Current authenticated admin user
    session: Database session

Returns:
    Updated role with permissions

Raises:
    HTTPException: 404 if role not found, 400 if invalid permissions

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| role_id | path | True | string |  |

### Request Body
- `application/json`: Reference `RoleUpdateRequest`

## GET /api/v1/roles/{role_id}

**Summary**: Get Role

Get role details.

.. deprecated::
    Use `/api/v1/org-admin/roles/{role_id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| role_id | path | True | string |  |

## DELETE /api/v1/roles/{role_id}

**Summary**: Delete Role

Delete a role.

.. deprecated::
    Use `/api/v1/org-admin/roles/{role_id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

Deletes a role and all associated permissions.
User-role associations are automatically cleaned up.
Fixed roles cannot be deleted.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| role_id | path | True | string |  |

## GET /api/v1/roles/public

**Summary**: List Public Roles

List only active roles for public display.

.. deprecated::
    Use `/api/v1/org-admin/roles/public` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |

## POST /api/v1/questions/

**Summary**: Create Question

### Request Body
- `application/json`: Reference `QuestionCreateRequest`

## GET /api/v1/questions/

**Summary**: List Questions

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| resource_type_id | query | False |  |  |
| curriculum_id | query | False |  |  |
| full_text | query | False |  |  |
| category_code | query | False |  |  |
| difficulty_level | query | False |  |  |
| is_active | query | False |  |  |
| status | query | False |  |  |
| purposes | query | False |  |  |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## POST /api/v1/questions/with-practice

**Summary**: Create Question With Practice

Create a new question with practice question association.

### Request Body
- `application/json`: Reference `PracticeQuestionCreateRequest`

## POST /api/v1/questions/{id}/resubmit

**Summary**: Resubmit Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/questions/{id}/approve

**Summary**: Approve Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/questions/{id}/reject

**Summary**: Reject Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/questions/{id}/toggle-activation

**Summary**: Toggle Activation

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/questions/public

**Summary**: List Public Questions

List public questions for question selection.

Returns only active and approved questions from all curriculums.
This endpoint is used by:
- Curriculum practice questions (requires curriculums:write)
- Exam paper builder (requires exam_papers:write)

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| resource_type_id | query | False |  | Filter by resource type ID |
| curriculum_id | query | False |  | Filter by curriculum ID |
| full_text | query | False |  | Search in question content |
| category_code | query | False |  | Filter by question category |
| difficulty_level | query | False |  | Filter by difficulty level |
| purposes | query | False |  | Filter by question purposes |
| limit | query | False | integer | Number of questions to return |
| offset | query | False | integer | Offset for pagination |

## GET /api/v1/questions/{id}

**Summary**: Get Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/questions/{id}

**Summary**: Update Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `QuestionUpdateRequest`

## DELETE /api/v1/questions/{id}

**Summary**: Delete Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/question-assets/upload

**Summary**: Upload Question Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_type | query | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_upload_question_asset_api_v1_question_assets_upload_post`

## PUT /api/v1/question-assets/{asset_id}/attach

**Summary**: Attach Question Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

### Request Body
- `application/json`: Reference `QuestionAssetAttachRequest`

## GET /api/v1/question-assets/{asset_id}/file

**Summary**: Get Question Asset File

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## DELETE /api/v1/question-assets/{asset_id}

**Summary**: Delete Question Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## POST /api/v1/question-option-assets/upload

**Summary**: Upload Option Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_type | query | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_upload_option_asset_api_v1_question_option_assets_upload_post`

## PUT /api/v1/question-option-assets/{asset_id}/attach

**Summary**: Attach Option Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

### Request Body
- `application/json`: Reference `QuestionOptionAssetAttachRequest`

## GET /api/v1/question-option-assets/{asset_id}/file

**Summary**: Get Option Asset File

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## DELETE /api/v1/question-option-assets/{asset_id}

**Summary**: Delete Option Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## POST /api/v1/question-generation/tasks

**Summary**: Create Generation Task

### Request Body
- `application/json`: Reference `QuestionGenerationCreateRequest`

## GET /api/v1/question-generation/tasks

**Summary**: List Generation Tasks

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| resource_type_id | query | False |  |  |
| curriculum_id | query | False |  |  |
| status | query | False |  |  |

## GET /api/v1/question-generation/tasks/{task_id}

**Summary**: Get Generation Task

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## GET /api/v1/question-generation/tasks/{task_id}/status

**Summary**: Get Generation Task Status

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## PUT /api/v1/question-generation/tasks/{task_id}/resubmit

**Summary**: Resubmit Generation Task

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## POST /api/v1/exam-papers/

**Summary**: Create Exam Paper

### Request Body
- `application/json`: Reference `ExamPaperCreateRequest`

## GET /api/v1/exam-papers/

**Summary**: List Exam Papers

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| title_like | query | False |  |  |
| purpose | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |

## PATCH /api/v1/exam-papers/{id}

**Summary**: Update Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `ExamPaperUpdateRequest`

## GET /api/v1/exam-papers/{id}

**Summary**: Get Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/exam-papers/{id}

**Summary**: Delete Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/exam-papers/{id}/preview

**Summary**: Preview Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/exam-papers/{id}/approve

**Summary**: Approve Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/exam-papers/{id}/reject

**Summary**: Reject Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/exam-papers/{id}/resubmit

**Summary**: Resubmit Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/exam-papers/{id}/toggle-activation

**Summary**: Toggle Exam Paper Activation

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/exam-schedules/

**Summary**: Create Exam Schedule

### Request Body
- `application/json`: Reference `ExamScheduleCreateRequest`

## GET /api/v1/exam-schedules/

**Summary**: List Exam Schedules

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| purpose | query | False |  |  |
| q | query | False |  |  |
| status | query | False |  |  |
| scope_type | query | False |  |  |
| is_active | query | False |  |  |
| bucket | query | False |  |  |
| time_from | query | False |  |  |
| time_to | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/exam-schedules/stats

**Summary**: Get Exam Schedule Stats

## PATCH /api/v1/exam-schedules/{id}

**Summary**: Update Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `ExamScheduleUpdateRequest`

## GET /api/v1/exam-schedules/{id}

**Summary**: Get Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/exam-schedules/{id}

**Summary**: Delete Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/exam-schedules/public

**Summary**: List Public Exam Schedules

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| purpose | query | False |  |  |
| q | query | False |  |  |
| time_from | query | False |  |  |
| time_to | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/exam-schedules/public/{id}

**Summary**: Get Public Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/exam-schedules/registered

**Summary**: List Registered Exam Schedules

List exam schedules that the current user has registered for.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |

## GET /api/v1/exam-schedules/my-purchased

**Summary**: List My Purchased Exam Schedules

List exam schedules purchased by the current user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/exam-schedules/{id}/registrations

**Summary**: List Exam Schedule Registrations

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| page | query | False | integer |  |
| limit | query | False | integer |  |

## POST /api/v1/exam-schedules/{id}/registrations

**Summary**: Register Exam

Register for exam.

.. deprecated::
    Use `/api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations` (POST) instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/exam-schedules/{id}/registrations

**Summary**: Cancel Exam

Cancel exam registration.

.. deprecated::
    Use `/api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations` (DELETE) instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/exam-schedules/{id}/publish

**Summary**: Publish Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/exam-schedules/{id}/attempts/stats

**Summary**: Get Exam Attempt Stats

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/exam-schedules/{id}/attempts

**Summary**: List Exam Attempts

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| q | query | False |  |  |
| status | query | False |  |  |
| is_cheating | query | False |  |  |

## GET /api/v1/exam-schedules/{id}/attempts/{attempt_id}/timeline

**Summary**: Get Exam Attempt Timeline

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| attempt_id | path | True | string |  |
| sort | query | False | string |  |

## DELETE /api/v1/exam-schedules/{id}/registrations/{user_id}

**Summary**: Cancel User Registration

Cancel a user's exam registration (admin only).

.. deprecated::
    Use `/api/v1/org-admin/exam-schedule-registrations/exam-schedules/{id}/registrations/{user_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| user_id | path | True | string |  |

## GET /api/v1/exam-schedules/{id}/registrations/summary

**Summary**: Registration Summary

Get exam registration summary.

.. deprecated::
    Use `/api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations/summary` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/exam-schedules/{id}/registrations/me

**Summary**: Get My Registration

Get my exam registration.

.. deprecated::
    Use `/api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations/me` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/exam-runtime/attempts/me

**Summary**: List My Attempts

List my exam attempts.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/me` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |

## POST /api/v1/exam-runtime/schedules/{schedule_id}/attempts

**Summary**: Start Attempt

Start an exam attempt.

.. deprecated::
    Use `/api/v1/org/exam-runtime/schedules/{schedule_id}/attempts` (POST) instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## GET /api/v1/exam-runtime/attempts/my

**Summary**: Get My Attempt For Schedule

Get my attempt for a schedule.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/my` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | query | True | string |  |

## GET /api/v1/exam-runtime/attempts/{attempt_id}

**Summary**: Get Attempt

Get an exam attempt.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/exam-runtime/attempts/{attempt_id}/instance

**Summary**: Get Attempt Instance

Get exam instance.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/instance` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## POST /api/v1/exam-runtime/attempts/{attempt_id}/anti-cheat

**Summary**: Log Anti Cheat

Log anti-cheat event.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/anti-cheat` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AntiCheatEventCreateRequest`

## GET /api/v1/exam-runtime/attempts/{attempt_id}/anti-cheat/count

**Summary**: Get Anti Cheat Count

Get anti-cheat event count.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/anti-cheat/count` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |
| event_type | query | True | string |  |

## POST /api/v1/exam-runtime/attempts/{attempt_id}/answers

**Summary**: Upsert Answer

Submit exam answer.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/answers` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AnswerUpsertRequest`

## POST /api/v1/exam-runtime/attempts/{attempt_id}/submit

**Summary**: Submit Attempt

Submit exam attempt.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/submit` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/exam-runtime/attempts/{attempt_id}/results/student

**Summary**: Get Student Results

Get student exam results.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/results/student` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/exam-runtime/attempts/{attempt_id}/results/instructor

**Summary**: Get Instructor Results

Get instructor exam results.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/results/instructor` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/exam-runtime/heartbeat

**Summary**: Heartbeat

Heartbeat endpoint.

.. deprecated::
    Use `/api/v1/org/exam-runtime/heartbeat` instead.
    This endpoint will be removed on 2026-07-26.

Heartbeat returns remaining time for the user's in-progress attempt, enforcing auto-submission server-side.

## POST /api/v1/exam-runtime/attempts/{attempt_id}/sessions

**Summary**: Create Session

Create exam session.

.. deprecated::
    Use `/api/v1/org/exam-runtime/attempts/{attempt_id}/sessions` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ExamAttemptSessionCreateRequest`

## PATCH /api/v1/exam-runtime/sessions/{session_id}/end

**Summary**: End Session

End exam session.

.. deprecated::
    Use `/api/v1/org/exam-runtime/sessions/{session_id}/end` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| session_id | path | True | string |  |

## GET /api/v1/exam-runtime/schedules/{schedule_id}/start-info

**Summary**: Get Start Info

Get exam start info.

.. deprecated::
    Use `/api/v1/org/exam-runtime/schedules/{schedule_id}/start-info` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## POST /api/v1/invitations/

**Summary**: Create a new invitation

Create a new invitation with the specified details.

.. deprecated::
    Use `/api/v1/org-admin/invitations` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Request Body
- `application/json`: Reference `InvitationCreateRequest`

## GET /api/v1/invitations/

**Summary**: List invitations

List invitations for the current user's organization.

.. deprecated::
    Use `/api/v1/org-admin/invitations` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| is_active | query | False | boolean |  |

## GET /api/v1/invitations/code/{code}

**Summary**: Get invitation by code

Get invitation details by code. This endpoint is publicly accessible for registration purposes.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| code | path | True | string |  |

## GET /api/v1/invitations/{id}

**Summary**: Get invitation by ID

Get invitation details by ID.

.. deprecated::
    Use `/api/v1/org-admin/invitations/{id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/invitations/{id}

**Summary**: Update invitation

Update an existing invitation.

.. deprecated::
    Use `/api/v1/org-admin/invitations/{id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `InvitationUpdateRequest`

## DELETE /api/v1/invitations/{id}

**Summary**: Delete invitation

Delete an invitation.

.. deprecated::
    Use `/api/v1/org-admin/invitations/{id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/invitations/{code}/valid

**Summary**: Check invitation validity

Check if an invitation code is valid. This endpoint is publicly accessible.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| code | path | True | string |  |

## GET /api/v1/exam-marking/attempts

**Summary**: List Attempts For Marking

List exam attempts for marking with filters.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | query | False |  | Filter by exam schedule |
| marking_status | query | False |  | Filter by marking status |
| student_id | query | False |  | Filter by student |
| student_search | query | False |  | Search by student name or email |
| date_from | query | False |  | Filter by submitted date (from) |
| date_to | query | False |  | Filter by submitted date (to) |
| page | query | False | integer | Page number |
| limit | query | False | integer | Items per page |

## GET /api/v1/exam-marking/attempts/{attempt_id}

**Summary**: Get Marking Detail

Get complete marking detail for an attempt including questions and answers.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/exam-marking/attempts/{attempt_id}/progress

**Summary**: Get Marking Progress

Calculate marking progress for an attempt.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/progress` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/exam-marking/attempts/{attempt_id}/ai-grading-progress

**Summary**: Get Ai Grading Progress

Get AI grading progress for an attempt.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/ai-grading-progress` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/exam-marking/answers/{answer_id}/score

**Summary**: Update Answer Score

Update manual score for an answer.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/answers/{answer_id}/score` instead.
    This endpoint will be removed on 2026-07-26.

- manual_score: The score to set (null to clear)
- grader_comments: Optional comments for this answer

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| answer_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UpdateAnswerScoreRequest`

## PATCH /api/v1/exam-marking/attempts/{attempt_id}/publish

**Summary**: Publish Attempt

Publish an attempt's results to make them visible to the student.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/publish` instead.
    This endpoint will be removed on 2026-07-26.

Only allowed when all questions have been graded.
Requires EXAM_MARKING_ALL permission as this is a dangerous operation.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/exam-marking/attempts/{attempt_id}/unpublish

**Summary**: Unpublish Attempt

Unpublish an attempt's results to hide them from the student.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/unpublish` instead.
    This endpoint will be removed on 2026-07-26.

Requires EXAM_MARKING_ALL permission as this is a dangerous operation.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/exam-marking/attempts/{attempt_id}/comments

**Summary**: Update Grader Comments

Update overall grader comments for an attempt.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/comments` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UpdateGraderCommentsRequest`

## POST /api/v1/exam-marking/schedules/{schedule_id}/bulk-publish

**Summary**: Bulk Publish Schedule

Publish all fully graded attempts for a schedule.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/schedules/{schedule_id}/bulk-publish` instead.
    This endpoint will be removed on 2026-07-26.

Requires EXAM_MARKING_ALL permission as this is a dangerous operation.
Only attempts with marking_status=FULLY_MARKED will be published.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## POST /api/v1/exam-marking/schedules/{schedule_id}/bulk-unpublish

**Summary**: Bulk Unpublish Schedule

Unpublish all published attempts for a schedule.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/schedules/{schedule_id}/bulk-unpublish` instead.
    This endpoint will be removed on 2026-07-26.

Requires EXAM_MARKING_ALL permission as this is a dangerous operation.
Only attempts with marking_status=PUBLISHED will be unpublished.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## POST /api/v1/exam-marking/attempts/{attempt_id}/lock

**Summary**: Acquire Grading Lock

Acquire grading lock for an attempt to prevent concurrent grading.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/lock` instead.
    This endpoint will be removed on 2026-07-26.

Returns lock_acquired=False if another user is already grading this attempt.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## DELETE /api/v1/exam-marking/attempts/{attempt_id}/lock

**Summary**: Release Grading Lock

Release grading lock for an attempt.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/lock` (DELETE) instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## POST /api/v1/exam-marking/answers/{answer_id}/ai-grade

**Summary**: Request Ai Grading

Request AI grading for an answer.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/answers/{answer_id}/ai-grade` instead.
    This endpoint will be removed on 2026-07-26.

Creates an AI grading task and queues it for background processing.
Only works for fill-in-blank and open-text questions.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| answer_id | path | True | string |  |

### Request Body
- `application/json`: Reference `RequestAIGradingRequest`

## GET /api/v1/exam-marking/tasks/{task_id}

**Summary**: Get Ai Task Status

Get the status and results of an AI grading task.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/tasks/{task_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## GET /api/v1/exam-marking/attempts/{attempt_id}/audit-log

**Summary**: Get Attempt Audit Log

Get audit log for an attempt.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/audit-log` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |
| limit | query | False | integer | Maximum number of logs to return |

## GET /api/v1/exam-marking/answers/{answer_id}/audit-log

**Summary**: Get Answer Audit Log

Get audit log for a specific answer.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/answers/{answer_id}/audit-log` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| answer_id | path | True | string |  |
| limit | query | False | integer | Maximum number of logs to return |

## POST /api/v1/exam-marking/attempts/{attempt_id}/bulk-ai-grade

**Summary**: Bulk Ai Grade Attempt

Bulk AI grade all subjective questions in an attempt.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/attempts/{attempt_id}/bulk-ai-grade` instead.
    This endpoint will be removed on 2026-07-26.

Creates AI grading tasks for all fill-in-blank and open-text questions that:
- Haven't been manually graded yet
- Are of supported question types

Each question will be graded as a separate background task.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `BulkAIGradingRequest`

## POST /api/v1/exam-marking/schedules/{schedule_id}/bulk-ai-grade

**Summary**: Bulk Ai Grade Schedule

Bulk AI grade all subjective questions across all attempts in a schedule.

.. deprecated::
    Use `/api/v1/org-admin/exam-marking/schedules/{schedule_id}/bulk-ai-grade` instead.
    This endpoint will be removed on 2026-07-26.

Creates AI grading tasks for all fill-in-blank and open-text questions that:
- Haven't been manually graded yet
- Are of supported question types
- Belong to any attempt in the schedule

Each question will be graded as a separate background task.
This can create a large number of tasks for schedules with many attempts.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

### Request Body
- `application/json`: Reference `BulkAIGradingRequest`

## POST /api/v1/learning-progress/sessions/start

**Summary**: Start Learning Session

Start a new learning session or resume an existing one.

.. deprecated::
    Use `/api/v1/org/learning-progress/sessions/start` instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `SessionStartRequest`

## POST /api/v1/learning-progress/sessions/{session_id}/end

**Summary**: End Learning Session

End a learning session.

.. deprecated::
    Use `/api/v1/org/learning-progress/sessions/{session_id}/end` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| session_id | path | True | string |  |

## POST /api/v1/learning-progress/slides/track

**Summary**: Track Slide Progress

Track slide view progress.

.. deprecated::
    Use `/api/v1/org/learning-progress/slides/track` instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `TrackSlideProgressRequest`

## POST /api/v1/learning-progress/media/track

**Summary**: Track Media Progress

Track media (audio/video) progress.

.. deprecated::
    Use `/api/v1/org/learning-progress/media/track` instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `TrackMediaProgressRequest`

## GET /api/v1/learning-progress/resume

**Summary**: Get Resume Position

Get resume position for a user in a curriculum.

.. deprecated::
    Use `/api/v1/org/learning-progress/resume` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | query | True | string | Curriculum ID |
| outline_id | query | False |  | Optional outline ID |

## GET /api/v1/learning-progress/analytics

**Summary**: Get Learning Analytics

Get learning analytics for a user.

.. deprecated::
    Use `/api/v1/org/learning-progress/analytics` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | query | True | string | Curriculum ID |
| outline_id | query | True | string | Outline ID |

## GET /api/v1/learning-progress/curriculum/{curriculum_id}/progress

**Summary**: Get Curriculum Progress

Get curriculum progress for a user.

.. deprecated::
    Use `/api/v1/org/learning-progress/curriculum/{curriculum_id}/progress` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| outline_id | query | False | string | Optional outline ID |

## GET /api/v1/learning-progress/curriculum/{curriculum_id}/outline-node-progress

**Summary**: Get Outline Node Progress

Get media progress aggregated by outline node for a curriculum.

.. deprecated::
    Use `/api/v1/org/learning-progress/curriculum/{curriculum_id}/outline-node-progress` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| outline_id | query | False |  | Optional outline ID |

## POST /api/v1/learning-progress/batch/progress

**Summary**: Get Batch Curriculum Progress

Get curriculum progress for multiple curriculums in one batch call.

.. deprecated::
    Use `/api/v1/org/learning-progress/batch/progress` instead.
    This endpoint will be removed on 2026-07-26.

This endpoint is used by the curriculum set learning page to fetch
progress for all curriculums in a set efficiently, avoiding N+1 queries.

Args:
    curriculum_ids: List of curriculum IDs to fetch progress for

Returns:
    Dictionary mapping curriculum_id to progress data

### Request Body
- `application/json`: array

## GET /api/v1/announcements/public

**Summary**: List Announcements Public

Get list of announcements for public display.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| search | query | False |  | Search by title or content |

## GET /api/v1/announcements/public/{announcement_id}

**Summary**: Get Announcement Public

Get announcement by ID for public display.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## POST /api/v1/announcements

**Summary**: Create Announcement

Create a new announcement.

### Request Body
- `application/json`: Reference `AnnouncementCreateRequest`

## GET /api/v1/announcements

**Summary**: Get Announcements

Get list of announcements with filters.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| search | query | False |  | Search by title or content |
| status | query | False |  | Filter by status |
| is_active | query | False |  | Filter by is_active |
| category | query | False |  | Filter by category |

## GET /api/v1/announcements/{announcement_id}

**Summary**: Get Announcement

Get announcement by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PUT /api/v1/announcements/{announcement_id}

**Summary**: Update Announcement

Update announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AnnouncementUpdateRequest`

## DELETE /api/v1/announcements/{announcement_id}

**Summary**: Delete Announcement

Delete announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/announcements/{announcement_id}/approve

**Summary**: Approve Announcement

Approve announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/announcements/{announcement_id}/publish

**Summary**: Publish Announcement

Publish announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/announcements/{announcement_id}/unpublish

**Summary**: Unpublish Announcement

Unpublish announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/announcements/{announcement_id}/submit-audit

**Summary**: Submit Audit Announcement

Submit announcement for audit.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/announcements/{announcement_id}/reject

**Summary**: Reject Announcement

Reject announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## POST /api/v1/attachments/test

**Summary**: Test Upload

Test upload endpoint without authentication or file requirements.

## POST /api/v1/attachments/

**Summary**: Upload Attachment

Upload an attachment file.

### Request Body
- `multipart/form-data`: Reference `Body_upload_attachment_api_v1_attachments__post`

## GET /api/v1/attachments/

**Summary**: List Attachments

List attachments for the current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer | Number of attachments to return |
| offset | query | False | integer | Number of attachments to skip |
| search | query | False |  | Search by filename |
| only_images | query | False | boolean | Filter only image files |

## GET /api/v1/attachments/{attachment_id}

**Summary**: Get Attachment

Get attachment information by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## DELETE /api/v1/attachments/{attachment_id}

**Summary**: Delete Attachment

Delete an attachment.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## GET /api/v1/attachments/{attachment_id}/download

**Summary**: Download Attachment

Download an attachment file.

.. deprecated::
    Use `/api/v1/org/attachments/{attachment_id}/download` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## GET /api/v1/banners/public

**Summary**: List Banners Public

Get list of banners for public display.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| platform | query | False |  | Filter by platform |

## GET /api/v1/banners/public/{banner_id}

**Summary**: Get Banner Public

Get banner by ID for public display.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

## POST /api/v1/banners

**Summary**: Create Banner

Create a new banner.

### Request Body
- `application/json`: Reference `BannerCreateRequest`

## GET /api/v1/banners

**Summary**: Get Banners

Get list of banners with filters.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| search | query | False |  | Search by title |
| is_enabled | query | False |  | Filter by is_enabled |
| platform | query | False |  | Filter by platform |

## GET /api/v1/banners/{banner_id}

**Summary**: Get Banner

Get banner by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

## PUT /api/v1/banners/{banner_id}

**Summary**: Update Banner

Update banner.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

### Request Body
- `application/json`: Reference `BannerUpdateRequest`

## DELETE /api/v1/banners/{banner_id}

**Summary**: Delete Banner

Delete banner.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

## POST /api/v1/training-classes/

**Summary**: Create Training Class

### Request Body
- `application/json`: Reference `TrainingClassCreateRequest`

## GET /api/v1/training-classes/

**Summary**: List Training Classes

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| q | query | False |  |  |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## PATCH /api/v1/training-classes/{id}

**Summary**: Update Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `TrainingClassUpdateRequest`

## GET /api/v1/training-classes/{id}

**Summary**: Get Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/training-classes/{id}

**Summary**: Delete Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/training-classes/stats

**Summary**: Get Training Class Stats

Get training class statistics.

## GET /api/v1/training-classes/public

**Summary**: List Training Classes Public

List public (APPROVED and ACTIVE) training classes.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| q | query | False |  |  |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |
| start_date_from | query | False |  |  |
| start_date_to | query | False |  |  |

## GET /api/v1/training-classes/public/{id}

**Summary**: Get Training Class Public

Get a public (APPROVED and ACTIVE) training class by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/training-classes/purchase-status/{id}

**Summary**: Get Training Class Purchase Status

Check if the current user has purchased the training class.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/training-classes/my-purchased

**Summary**: List My Purchased Training Classes

List training classes purchased by the current user.

Returns training classes that the user has valid access to through purchases.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |

## PATCH /api/v1/training-classes/{id}/publish

**Summary**: Publish Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/training-classes/{id}/unpublish

**Summary**: Unpublish Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/training-classes/{id}/submit-audit

**Summary**: Submit Audit Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/training-classes/{id}/approve

**Summary**: Approve Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/training-classes/{id}/reject

**Summary**: Reject Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/teacher-manages/public

**Summary**: List Teacher Manages Public

Get list of teacher manages for public display (only approved and active).

.. deprecated::
    Use `/api/v1/org/teacher-manages/public` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| q | query | False |  | Search by name or description |

## GET /api/v1/teacher-manages/public/{id}

**Summary**: Get Teacher Manage Public

Get teacher manage by ID for public display (only approved and active).

.. deprecated::
    Use `/api/v1/org/teacher-manages/public/{id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/teacher-manages/

**Summary**: Create Teacher Manage

Create a new teacher manage.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/` instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `TeacherManageCreateRequest`

## GET /api/v1/teacher-manages/

**Summary**: List Teacher Manages

List teacher manages.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| q | query | False |  |  |

## PATCH /api/v1/teacher-manages/{id}

**Summary**: Update Teacher Manage

Update teacher manage.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `TeacherManageUpdateRequest`

## GET /api/v1/teacher-manages/{id}

**Summary**: Get Teacher Manage

Get teacher manage by ID.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/teacher-manages/{id}

**Summary**: Delete Teacher Manage

Delete teacher manage.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/teacher-manages/{id}/publish

**Summary**: Publish Teacher Manage

Publish teacher manage.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}/publish` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/teacher-manages/{id}/unpublish

**Summary**: Unpublish Teacher Manage

Unpublish teacher manage.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}/unpublish` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/teacher-manages/{id}/submit-audit

**Summary**: Submit Audit Teacher Manage

Submit teacher manage for audit.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}/submit-audit` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/teacher-manages/{id}/approve

**Summary**: Approve Teacher Manage

Approve teacher manage.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}/approve` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/teacher-manages/{id}/reject

**Summary**: Reject Teacher Manage

Reject teacher manage.

.. deprecated::
    Use `/api/v1/org-admin/teacher-manages/{id}/reject` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/orders

**Summary**: Create Order

Create a new order.

.. deprecated::
    Use `/api/v1/org/orders` (POST) instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `OrderCreateRequest`

## GET /api/v1/orders

**Summary**: List My Orders

List orders for the current user.

.. deprecated::
    Use `/api/v1/org/orders` (GET) instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/orders/{order_id}

**Summary**: Get Order Details

Get order details.

.. deprecated::
    Use `/api/v1/org/orders/{order_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |

## POST /api/v1/orders/{order_id}/pay

**Summary**: Initiate Payment

Initiate payment for an order.

.. deprecated::
    Use `/api/v1/org/orders/{order_id}/pay` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |
| payment_channel | query | True | PaymentChannel |  |

## POST /api/v1/orders/{order_id}/cancel

**Summary**: Cancel Order

Cancel an unpaid order.

.. deprecated::
    Use `/api/v1/org/orders/{order_id}/cancel` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |

## GET /api/v1/orders/purchased/items

**Summary**: List Purchased Items

List items purchased by the user.

.. deprecated::
    Use `/api/v1/org/orders/purchased/items` instead.
    This endpoint will be removed on 2026-07-26.

## GET /api/v1/orders/purchased/check

**Summary**: Check Purchased Item

Check if a specific product or item is purchased and valid.

.. deprecated::
    Use `/api/v1/org-admin/orders/purchased/check` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | query | False |  |  |
| product_type | query | False |  |  |
| external_id | query | False |  |  |

## GET /api/v1/admin/orders

**Summary**: List All Orders

List all orders with optional filters (Admin only).

.. deprecated::
    Use `/api/v1/org-admin/orders` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

Query Parameters:
- user_id: Filter by specific user
- product_id: Filter orders containing a specific product
- product_type: Filter orders containing products of a specific type
- status: Filter by order status (created, pending_payment, paid, cancelled, etc.)
- order_no: Search by order number (supports partial matching)
- min_amount/max_amount: Filter by total amount range
- created_after/created_before: Filter by creation date range
- limit/offset: Pagination parameters

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | query | False |  | Filter by user ID |
| product_id | query | False |  | Filter by product ID |
| product_type | query | False |  | Filter by product type (e.g., curriculum_set) |
| status | query | False |  | Filter by order status |
| order_no | query | False |  | Search by order number (partial match) |
| min_amount | query | False |  | Minimum total amount (in cents) |
| max_amount | query | False |  | Maximum total amount (in cents) |
| created_after | query | False |  | Filter orders created after this date (ISO format) |
| created_before | query | False |  | Filter orders created before this date (ISO format) |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/admin/orders/{order_id}

**Summary**: Get Order Details Admin

Get order details including payment records (Admin only).

.. deprecated::
    Use `/api/v1/org-admin/orders/{order_id}` instead.
    This endpoint will be removed on 2026-07-26.
    RLS behavior may differ from new endpoint.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |

## POST /api/v1/payments/callback/{channel}

**Summary**: Payment Callback

Handle payment callback from third-party payment providers.

This endpoint uses an administrative service to bypass RLS policies
as it's a system-level callback with no user context.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| channel | path | True | string |  |

## POST /api/v1/products/

**Summary**: Create a new product

Create a new product.

.. deprecated::
    Use `/api/v1/org-admin/products/` instead.
    This endpoint will be removed on 2026-07-26.

### Request Body
- `application/json`: Reference `ProductCreateRequest`

## GET /api/v1/products/

**Summary**: List products

List products with pagination and filtering.

.. deprecated::
    Use `/api/v1/org-admin/products/` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer | Maximum number of items to return |
| offset | query | False | integer | Number of items to skip |
| name | query | False |  | Filter by product name (partial match) |
| product_type | query | False |  | Filter by product type |
| is_active | query | False |  | Filter by active status |

## GET /api/v1/products/free

**Summary**: List Free Products

List all free products (price = 0).

.. deprecated::
    Use `/api/v1/org/products/free` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/products/limited-time-free

**Summary**: List Limited Time Free Products

List paid products that are currently free via campaign.

.. deprecated::
    Use `/api/v1/org/products/limited-time-free` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/products/paid

**Summary**: List Paid Products

List paid products (price > 0 or with paid campaigns).

.. deprecated::
    Use `/api/v1/org/products/paid` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/products/{product_id}

**Summary**: Get a product by ID

Get a product by its ID.

.. deprecated::
    Use `/api/v1/org-admin/products/{product_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

## PUT /api/v1/products/{product_id}

**Summary**: Update a product

Update an existing product.

.. deprecated::
    Use `/api/v1/org-admin/products/{product_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductUpdateRequest`

## DELETE /api/v1/products/{product_id}

**Summary**: Delete a product

Delete a product.

.. deprecated::
    Use `/api/v1/org-admin/products/{product_id}` instead.
    This endpoint will be removed on 2026-07-26.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

## POST /api/v1/products/{product_id}/campaigns

**Summary**: Create Pricing Campaign

Create a pricing campaign for a product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductPricingCampaignCreateRequest`

## GET /api/v1/products/{product_id}/campaigns

**Summary**: List Pricing Campaigns

List all pricing campaigns for a product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

## PATCH /api/v1/products/campaigns/{campaign_id}

**Summary**: Update Pricing Campaign

Update a pricing campaign.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| campaign_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductPricingCampaignUpdateRequest`

## DELETE /api/v1/products/campaigns/{campaign_id}

**Summary**: Delete Pricing Campaign

Delete a pricing campaign.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| campaign_id | path | True | string |  |

## POST /api/v1/products/{product_id}/time-periods

**Summary**: Create a product time period

Create a new product time period.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductTimePeriodCreateRequest`

## GET /api/v1/products/{product_id}/time-periods

**Summary**: List product time periods

List all time periods for a product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |
| period_type | query | False |  | Filter by period type |
| is_active | query | False |  | Filter by active status |

## DELETE /api/v1/products/{product_id}/time-periods

**Summary**: Batch delete product time periods

Batch delete time periods for a product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |
| period_type | query | False |  | Filter by period type |

## POST /api/v1/products/{product_id}/time-periods/batch

**Summary**: Batch create product time periods

Batch create product time periods.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductTimePeriodBatchCreateRequest`

## GET /api/v1/products/time-periods/current/recommendations

**Summary**: List current recommended products

List products with current active recommendation periods.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/products/time-periods/current/pinned

**Summary**: List current pinned products

List products with current active pinning periods.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/products/time-periods/{period_id}

**Summary**: Get a product time period by ID

Get a product time period by its ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| period_id | path | True | string |  |

## PUT /api/v1/products/time-periods/{period_id}

**Summary**: Update a product time period

Update an existing product time period.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| period_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductTimePeriodUpdateRequest`

## DELETE /api/v1/products/time-periods/{period_id}

**Summary**: Delete a product time period

Delete a product time period.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| period_id | path | True | string |  |

## POST /api/v1/products/time-periods/multi-product-batch

**Summary**: Batch create time periods for multiple products

Batch create time periods for multiple products.

### Request Body
- `application/json`: Reference `MultiProductTimePeriodBatchCreateRequest`

## GET /api/v1/org-admin/users

**Summary**: List Users

List users in current organization with pagination and filters.

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer | Page number |
| limit | query | False | integer | Items per page |
| search | query | False |  | Search term for name/email |
| role | query | False |  | Filter by role |
| status | query | False |  | Filter by status |
| department_id | query | False |  | Filter by department ID |

## GET /api/v1/org-admin/users/public

**Summary**: List Public Users

List active users with active roles only for public display.

RLS automatically filters to current organization.
Requires user to have at least one permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer | Page number |
| limit | query | False | integer | Items per page |
| search | query | False |  | Search term for name/email |
| role | query | False |  | Filter by active role |
| department_id | query | False |  | Filter by department ID |

## GET /api/v1/org-admin/users/stats

**Summary**: Get User Stats

Get user statistics for current organization.

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

## GET /api/v1/org-admin/users/{user_id}

**Summary**: Get User

Get user by ID from current organization.

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

Args:
    user_id: User ID
    current_user: Current admin user

Returns:
    User information

Raises:
    HTTPException: If user not found

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

## PUT /api/v1/org-admin/users/{user_id}

**Summary**: Update User

Update user in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

Args:
    user_id: User ID to update
    user_update: User update data with admin privileges (including quotas)
    current_user: Current admin user

Returns:
    Updated user information

Raises:
    HTTPException: If user not found or update fails

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserUpdateRequest`

## DELETE /api/v1/org-admin/users/{user_id}

**Summary**: Delete User

Delete user from current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

Args:
    user_id: User ID to delete
    current_user: Current admin user

Returns:
    Success message

Raises:
    HTTPException: If user not found or deletion fails

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

## POST /api/v1/org-admin/users/

**Summary**: Create User

Create a new user in current organization with full admin options (quota, role, department).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Request Body
- `application/json`: Reference `UserCreateRequest`

## POST /api/v1/org-admin/users/batch-invite

**Summary**: Batch Invite Users

Batch invite users with auto-generated passwords (org-admin only).

This endpoint creates multiple users at once with automatically generated passwords.
All invited users will be marked to change their password on first login.

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

Args:
    request: Batch invite request containing emails, role_ids, and optional department
    current_user: Current admin user
    user_entry: User entry service
    session: Database session

Returns:
    BatchInviteUsersResponse with created users and their generated passwords

Raises:
    HTTPException: If any email already exists or creation fails

### Request Body
- `application/json`: Reference `BatchInviteUsersRequest`

## GET /api/v1/org-admin/users/{user_id}/quota

**Summary**: Get User Quota

Get user quota information from current organization.

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

Args:
    user_id: User ID
    current_user: Current admin user

Returns:
    User quota and usage information

Raises:
    HTTPException: If user not found

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

## PUT /api/v1/org-admin/users/{user_id}/role

**Summary**: Update User Role

Assign roles to a user in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserRoleUpdateRequest`

## PATCH /api/v1/org-admin/users/{user_id}/department

**Summary**: Update User Department

Assign a department to a user in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserDepartmentUpdateRequest`

## PUT /api/v1/org-admin/users/{user_id}/password

**Summary**: Reset User Password

Reset user password in current organization.

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `PasswordResetRequest`

## PUT /api/v1/org-admin/users/{user_id}/status

**Summary**: Update User Status

Update user status in current organization.

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserStatusUpdateRequest`

## GET /api/v1/org-admin/roles/functions

**Summary**: Get Available Functions

Get all available function codes with metadata for role assignment.

## GET /api/v1/org-admin/roles/functions/categories

**Summary**: Get Available Functions By Category

Get all available function codes grouped by category.

Returns a list of categories, each containing its function codes and metadata.
This endpoint allows the frontend to fully organize categories and functions
based on backend configuration.

## POST /api/v1/org-admin/roles

**Summary**: Create Role

Create a new role with permissions.

### Request Body
- `application/json`: Reference `RoleCreateRequest`

## GET /api/v1/org-admin/roles

**Summary**: List Roles

List roles with optional active status filter.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| is_active | query | False |  |  |

## PUT /api/v1/org-admin/roles/{role_id}

**Summary**: Update Role

Update a role and its permissions.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| role_id | path | True | string |  |

### Request Body
- `application/json`: Reference `RoleUpdateRequest`

## GET /api/v1/org-admin/roles/{role_id}

**Summary**: Get Role

Get role details.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| role_id | path | True | string |  |

## DELETE /api/v1/org-admin/roles/{role_id}

**Summary**: Delete Role

Delete a role.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| role_id | path | True | string |  |

## GET /api/v1/org-admin/roles/public

**Summary**: List Public Roles

List only active roles for public display.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |

## POST /api/v1/org-admin/departments/

**Summary**: Create a new department

Create a new department.

### Request Body
- `application/json`: Reference `DepartmentCreateRequest`

## GET /api/v1/org-admin/departments

**Summary**: List departments for management

List departments for management.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| search | query | False |  |  |
| is_active | query | False |  |  |

## GET /api/v1/org-admin/departments/{id}

**Summary**: Get department by ID

Get department by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/org-admin/departments/{id}

**Summary**: Update department

Update department.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `DepartmentUpdateRequest`

## DELETE /api/v1/org-admin/departments/{id}

**Summary**: Delete department

Delete department.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/departments/{id}/move

**Summary**: Move department to a new parent

Move department to a new parent.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `DepartmentMoveRequest`

## POST /api/v1/org-admin/invitations/

**Summary**: Create a new invitation

Create a new invitation with the specified details.

### Request Body
- `application/json`: Reference `InvitationCreateRequest`

## GET /api/v1/org-admin/invitations/

**Summary**: List invitations

List invitations for the current user's organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer | Items per page |
| offset | query | False | integer | Items to skip |
| status | query | False |  | Filter by status |

## GET /api/v1/org-admin/invitations/code/{code}

**Summary**: Get invitation by code

Get invitation details by code. This endpoint is publicly accessible for registration purposes.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| code | path | True | string |  |

## GET /api/v1/org-admin/invitations/{id}

**Summary**: Get invitation by ID

Get invitation details by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/org-admin/invitations/{id}

**Summary**: Update invitation

Update an existing invitation.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `InvitationUpdateRequest`

## DELETE /api/v1/org-admin/invitations/{id}

**Summary**: Delete invitation

Delete an invitation.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/invitations/{code}/valid

**Summary**: Check invitation validity

Check if an invitation code is valid. This endpoint is publicly accessible.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| code | path | True | string |  |

## POST /api/v1/org-admin/organizations/

**Summary**: Create a new organization

Create a new organization.

### Request Body
- `application/json`: Reference `OrganizationCreateRequest`

## GET /api/v1/org-admin/organizations/

**Summary**: List organizations

List organizations.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| search | query | False |  |  |
| type | query | False |  |  |
| is_active | query | False |  |  |

## GET /api/v1/org-admin/organizations/{id}

**Summary**: Get organization by ID

Get organization by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/org-admin/organizations/{id}

**Summary**: Update organization

Update organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `OrganizationUpdateRequest`

## DELETE /api/v1/org-admin/organizations/{id}

**Summary**: Delete organization

Delete organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/organizations/{id}/members/

**Summary**: Add member to organization

Add member to organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `OrganizationMemberCreateRequest`

## GET /api/v1/org-admin/organizations/{id}/members/

**Summary**: List organization members

List organization members.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org-admin/organizations/{id}/members/{member_id}

**Summary**: Get organization member

Get organization member.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| member_id | path | True | string |  |

## PUT /api/v1/org-admin/organizations/{id}/members/{member_id}

**Summary**: Update organization member

Update organization member.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| member_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OrganizationMemberUpdateRequest`

## DELETE /api/v1/org-admin/organizations/{id}/members/{member_id}

**Summary**: Remove member from organization

Remove member from organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| member_id | path | True | string |  |

## POST /api/v1/org-admin/organizations/{id}/users/import/json

**Summary**: Bulk import users from JSON

Bulk import users from JSON.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `UserImportRequest`

## POST /api/v1/org-admin/organizations/{id}/users/import/csv

**Summary**: Bulk import users from CSV

Bulk import users from CSV.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_import_users_csv_api_v1_org_admin_organizations__id__users_import_csv_post`

## GET /api/v1/org-admin/dictionaries/dictionaries/batch

**Summary**: Batch get dictionaries

Get multiple dictionaries by their type codes

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| codes | query | True | array |  |

## GET /api/v1/org-admin/dictionaries/dictionaries/types

**Summary**: List dictionary types

List all dictionary types for current user's organization and system-wide types

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer | Number of records to skip |
| limit | query | False | integer | Maximum number of records to return |
| active_only | query | False | boolean | Only return active dictionary types |

## POST /api/v1/org-admin/dictionaries/dictionaries/types

**Summary**: Create dictionary type

Create a new dictionary type.

### Request Body
- `application/json`: Reference `DictionaryTypeCreate`

## PUT /api/v1/org-admin/dictionaries/dictionaries/types/{type_id}

**Summary**: Update dictionary type

Update a dictionary type.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| type_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DictionaryTypeUpdate`

## DELETE /api/v1/org-admin/dictionaries/dictionaries/types/{type_id}

**Summary**: Delete dictionary type

Delete a dictionary type.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| type_id | path | True | string |  |

## POST /api/v1/org-admin/dictionaries/dictionaries/values

**Summary**: Create dictionary value

Create a new dictionary value.

### Request Body
- `application/json`: Reference `DictionaryValueCreate`

## PUT /api/v1/org-admin/dictionaries/dictionaries/values/{value_id}

**Summary**: Update dictionary value

Update a dictionary value.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| value_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DictionaryValueUpdate`

## DELETE /api/v1/org-admin/dictionaries/dictionaries/values/{value_id}

**Summary**: Delete dictionary value

Delete a dictionary value.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| value_id | path | True | string |  |

## GET /api/v1/org-admin/orders

**Summary**: List All Orders

List all orders in current organization with optional filters (Org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

This is per-org billing - orders are scoped to the current organization.

Query Parameters:
- user_id: Filter by specific user
- product_id: Filter orders containing a specific product
- product_type: Filter orders containing products of a specific type
- status: Filter by order status (created, pending_payment, paid, cancelled, etc.)
- order_no: Search by order number (supports partial matching)
- min_amount/max_amount: Filter by total amount range
- created_after/created_before: Filter by creation date range
- limit/offset: Pagination parameters

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| user_id | query | False |  | Filter by user ID |
| product_id | query | False |  | Filter by product ID |
| product_type | query | False |  | Filter by product type (e.g., curriculum_set) |
| status | query | False |  | Filter by order status |
| order_no | query | False |  | Search by order number (partial match) |
| min_amount | query | False |  | Minimum total amount (in cents) |
| max_amount | query | False |  | Maximum total amount (in cents) |
| created_after | query | False |  | Filter orders created after this date (ISO format) |
| created_before | query | False |  | Filter orders created before this date (ISO format) |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org-admin/orders/purchased-records

**Summary**: List Product Purchase Records

List purchase records for products in current organization (Org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

Query Parameters:
- product_id: Filter by specific product
- user_name: Filter by user name (supports partial matching on name or email)
- created_after: Filter records created after this date (ISO format)
- created_before: Filter records created before this date (ISO format)
- limit/offset: Pagination parameters

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | query | False |  | Filter by product ID |
| user_name | query | False |  | Filter by user name (partial match) |
| created_after | query | False |  | Filter records created after this date (ISO format) |
| created_before | query | False |  | Filter records created before this date (ISO format) |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org-admin/orders/{order_id}

**Summary**: Get Order Details Admin

Get order details including payment records from current organization (Org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

This is per-org billing - order is scoped to the current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |

## POST /api/v1/org-admin/certificates/certificates

**Summary**: Create a new certificate

Create a new certificate with acquisition conditions

### Request Body
- `application/json`: Reference `CertificateCreateRequest`

## GET /api/v1/org-admin/certificates/certificates

**Summary**: List certificates

List certificates with pagination and filters

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| is_active | query | False |  |  |
| level | query | False |  |  |
| source_type | query | False |  |  |

## GET /api/v1/org-admin/certificates/certificates/{certificate_id}

**Summary**: Get a certificate

Get a certificate by ID

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| certificate_id | path | True | string |  |

## PUT /api/v1/org-admin/certificates/certificates/{certificate_id}

**Summary**: Update a certificate

Update an existing certificate

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| certificate_id | path | True | string |  |

### Request Body
- `application/json`: Reference `CertificateUpdateRequest`

## DELETE /api/v1/org-admin/certificates/certificates/{certificate_id}

**Summary**: Delete a certificate

Delete a certificate by ID

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| certificate_id | path | True | string |  |

## GET /api/v1/org-admin/system/status

**Summary**: Get System Status

获取当前系统状态（用户数、课程数、进行中考试数、增长率及待审核统计）。

## GET /api/v1/org-admin/system/todo

**Summary**: Get Todo List

获取待办事项列表（各类审核项）。

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |

## GET /api/v1/org-admin/system/activity-trend

**Summary**: Get User Activity Trend

获取用户活跃度趋势统计。

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| period | query | False | string |  |
| count | query | False | integer |  |

## GET /api/v1/org-admin/system/course-proportions

**Summary**: Get Course Category Proportions

获取课程分类占比统计。

## GET /api/v1/org-admin/system/recent-activity

**Summary**: Get Recent Activities

获取系统最近活动（课程、课件、考试、学习等，短列表）。

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |

## GET /api/v1/org-admin/system/activities

**Summary**: Get All Recent Activities

获取系统最近活动的分页列表。

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |

## POST /api/v1/org-admin/training-classes/

**Summary**: Create Training Class

### Request Body
- `application/json`: Reference `TrainingClassCreateRequest`

## GET /api/v1/org-admin/training-classes/

**Summary**: List Training Classes

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| q | query | False |  |  |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |
| start_date_from | query | False |  |  |
| start_date_to | query | False |  |  |

## GET /api/v1/org-admin/training-classes/{id}/enrolled-users

**Summary**: Get Enrolled Users

Get enrolled users for a training class.

Accessible to users with TRAINING_CLASSES_READ or TRAINING_CLASSES_ALL permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| name | query | False |  | Filter by user name |

## GET /api/v1/org-admin/training-classes/{id}/learning-users

**Summary**: Get Learning Users

Get learning users for a training class.

Accessible to users with TRAINING_CLASSES_READ or TRAINING_CLASSES_ALL permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| name | query | False |  | Filter by user name |

## GET /api/v1/org-admin/training-classes/stats

**Summary**: Get Training Class Stats

Get training class statistics.

Accessible to users with TRAINING_CLASSES_READ, WRITE, or ALL permission.
RLS automatically filters to current organization.

## GET /api/v1/org-admin/training-classes/{id}

**Summary**: Get Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/training-classes/{id}

**Summary**: Update Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `TrainingClassUpdateRequest`

## DELETE /api/v1/org-admin/training-classes/{id}

**Summary**: Delete Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/training-classes/{id}/publish

**Summary**: Publish Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/training-classes/{id}/unpublish

**Summary**: Unpublish Training Class

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/training-classes/{id}/submit-audit

**Summary**: Submit Audit Training Class

Submit training class for audit.

Accessible to users with TRAINING_CLASSES_WRITE or ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/training-classes/{id}/approve

**Summary**: Approve Training Class

Approve training class.

Accessible to users with TRAINING_CLASSES_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/training-classes/{id}/reject

**Summary**: Reject Training Class

Reject training class.

Accessible to users with TRAINING_CLASSES_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/teacher-manages/

**Summary**: Create Teacher Manage

Create a new teacher manage (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Request Body
- `application/json`: Reference `TeacherManageCreateRequest`

## GET /api/v1/org-admin/teacher-manages/

**Summary**: List Teacher Manages

List teacher manages in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| q | query | False |  |  |

## PATCH /api/v1/org-admin/teacher-manages/{id}

**Summary**: Update Teacher Manage

Update teacher manage (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `TeacherManageUpdateRequest`

## GET /api/v1/org-admin/teacher-manages/{id}

**Summary**: Get Teacher Manage

Get teacher manage by ID from current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/org-admin/teacher-manages/{id}

**Summary**: Delete Teacher Manage

Delete teacher manage from current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/teacher-manages/{id}/publish

**Summary**: Publish Teacher Manage

Publish teacher manage in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/teacher-manages/{id}/unpublish

**Summary**: Unpublish Teacher Manage

Unpublish teacher manage in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/teacher-manages/{id}/submit-audit

**Summary**: Submit Audit Teacher Manage

Submit teacher manage for audit in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/teacher-manages/{id}/approve

**Summary**: Approve Teacher Manage

Approve teacher manage in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/teacher-manages/{id}/reject

**Summary**: Reject Teacher Manage

Reject teacher manage in current organization (org-admin only).

RLS automatically filters to current organization.
Only org admins (owner or users with permissions) can access.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/products/

**Summary**: Create a new product

Create a new product.

### Request Body
- `application/json`: Reference `ProductCreateRequest`

## GET /api/v1/org-admin/products/

**Summary**: List products

List products with pagination and filtering.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer | Maximum number of items to return |
| offset | query | False | integer | Number of items to skip |
| name | query | False |  | Filter by product name (partial match) |
| product_type | query | False |  | Filter by product type |
| is_active | query | False |  | Filter by active status |

## GET /api/v1/org-admin/products/{product_id}

**Summary**: Get a product by ID

Get a product by its ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

## PUT /api/v1/org-admin/products/{product_id}

**Summary**: Update a product

Update an existing product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductUpdateRequest`

## DELETE /api/v1/org-admin/products/{product_id}

**Summary**: Delete a product

Delete a product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

## POST /api/v1/org-admin/product-pricing-campaigns/{product_id}/campaigns

**Summary**: Create Pricing Campaign

Create a pricing campaign for a product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductPricingCampaignCreateRequest`

## GET /api/v1/org-admin/product-pricing-campaigns/{product_id}/campaigns

**Summary**: List Pricing Campaigns

List all pricing campaigns for a product.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

## PATCH /api/v1/org-admin/product-pricing-campaigns/campaigns/{campaign_id}

**Summary**: Update Pricing Campaign

Update a pricing campaign.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| campaign_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductPricingCampaignUpdateRequest`

## DELETE /api/v1/org-admin/product-pricing-campaigns/campaigns/{campaign_id}

**Summary**: Delete Pricing Campaign

Delete a pricing campaign.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| campaign_id | path | True | string |  |

## POST /api/v1/org-admin/products/products/{product_id}/time-periods

**Summary**: Create a product time period

Create a new product time period.

Accessible to users with PRODUCTS_WRITE or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductTimePeriodCreateRequest`

## GET /api/v1/org-admin/products/products/{product_id}/time-periods

**Summary**: List product time periods

List all time periods for a product.

Accessible to users with PRODUCTS_READ or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |
| period_type | query | False |  | Filter by period type |
| is_active | query | False |  | Filter by active status |

## DELETE /api/v1/org-admin/products/products/{product_id}/time-periods

**Summary**: Batch delete product time periods

Batch delete time periods for a product.

Accessible to users with PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |
| period_type | query | False |  | Filter by period type |

## POST /api/v1/org-admin/products/products/{product_id}/time-periods/batch

**Summary**: Batch create product time periods

Batch create product time periods.

Accessible to users with PRODUCTS_WRITE or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductTimePeriodBatchCreateRequest`

## GET /api/v1/org-admin/products/products/time-periods/current/recommendations

**Summary**: List current recommended products

List products with current active recommendation periods.

Accessible to users with PRODUCTS_READ or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org-admin/products/products/time-periods/current/pinned

**Summary**: List current pinned products

List products with current active pinning periods.

Accessible to users with PRODUCTS_READ or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org-admin/products/products/time-periods/{period_id}

**Summary**: Get a product time period by ID

Get a product time period by its ID.

Accessible to users with PRODUCTS_READ or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| period_id | path | True | string |  |

## PUT /api/v1/org-admin/products/products/time-periods/{period_id}

**Summary**: Update a product time period

Update an existing product time period.

Accessible to users with PRODUCTS_WRITE or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| period_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProductTimePeriodUpdateRequest`

## DELETE /api/v1/org-admin/products/products/time-periods/{period_id}

**Summary**: Delete a product time period

Delete a product time period.

Accessible to users with PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| period_id | path | True | string |  |

## POST /api/v1/org-admin/products/products/time-periods/multi-product-batch

**Summary**: Batch create time periods for multiple products

Batch create time periods for multiple products.

Accessible to users with PRODUCTS_WRITE or PRODUCTS_ALL permission.
RLS automatically filters to current organization.

### Request Body
- `application/json`: Reference `MultiProductTimePeriodBatchCreateRequest`

## POST /api/v1/org-admin/announcements

**Summary**: Create Announcement

Create a new announcement.

### Request Body
- `application/json`: Reference `AnnouncementCreateRequest`

## GET /api/v1/org-admin/announcements

**Summary**: Get Announcements

Get list of announcements with filters.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| search | query | False |  | Search by title or content |
| status | query | False |  | Filter by status |
| is_active | query | False |  | Filter by is_active |
| category | query | False |  | Filter by category |

## GET /api/v1/org-admin/announcements/{announcement_id}

**Summary**: Get Announcement

Get announcement by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PUT /api/v1/org-admin/announcements/{announcement_id}

**Summary**: Update Announcement

Update announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AnnouncementUpdateRequest`

## DELETE /api/v1/org-admin/announcements/{announcement_id}

**Summary**: Delete Announcement

Delete announcement.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/org-admin/announcements/{announcement_id}/approve

**Summary**: Approve Announcement

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/org-admin/announcements/{announcement_id}/publish

**Summary**: Publish Announcement

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/org-admin/announcements/{announcement_id}/unpublish

**Summary**: Unpublish Announcement

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/org-admin/announcements/{announcement_id}/submit-audit

**Summary**: Submit Audit Announcement

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## PATCH /api/v1/org-admin/announcements/{announcement_id}/reject

**Summary**: Reject Announcement

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## POST /api/v1/org-admin/banners

**Summary**: Create Banner

Create a new banner.

### Request Body
- `application/json`: Reference `BannerCreateRequest`

## GET /api/v1/org-admin/banners

**Summary**: List Banners

List all banners for current organization (admin view).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| search | query | False |  | Search by title |
| platform | query | False |  | Filter by platform |
| is_enabled | query | False |  | Filter by enabled status |

## GET /api/v1/org-admin/banners/{banner_id}

**Summary**: Get Banner

Get a specific banner by ID (admin view).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

## PUT /api/v1/org-admin/banners/{banner_id}

**Summary**: Update Banner

Update an existing banner.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

### Request Body
- `application/json`: Reference `BannerUpdateRequest`

## DELETE /api/v1/org-admin/banners/{banner_id}

**Summary**: Delete Banner

Delete a banner.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

## POST /api/v1/org-admin/user-favorites

**Summary**: Add a resource to user favorites

Add a resource (e.g., curriculum, curriculum set) to current user's favorites.

### Request Body
- `application/json`: Reference `UserFavoriteCreateRequest`

## GET /api/v1/org-admin/user-favorites

**Summary**: List Favorites

List current user's favorite resources.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| object_type | query | False |  | Filter by object type |

## GET /api/v1/org-admin/user-favorites/{favorite_id}

**Summary**: Get Favorite

Get a specific favorite by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| favorite_id | path | True | string |  |

## DELETE /api/v1/org-admin/user-favorites/{favorite_id}

**Summary**: Remove Favorite

Remove a resource from user's favorites.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| favorite_id | path | True | string |  |

## GET /api/v1/org-admin/curriculum-sets/my-purchased

**Summary**: List My Purchased Curriculum Sets

List curriculum sets purchased by the current user.

Returns curriculum sets that the user has valid access to through purchases.
Items are considered valid if:
- expire_time is None (permanent access)
- expire_time is in the future (still within valid period)

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## POST /api/v1/org-admin/curriculum-sets/

**Summary**: Create Curriculum Set

### Request Body
- `application/json`: Reference `CurriculumSetCreateRequest`

## GET /api/v1/org-admin/curriculum-sets/

**Summary**: List Curriculum Sets

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| created_by_id | query | False |  |  |
| search | query | False |  |  |
| min_minutes | query | False |  |  |
| max_minutes | query | False |  |  |
| difficulty | query | False |  |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |

## PATCH /api/v1/org-admin/curriculum-sets/{id}

**Summary**: Update Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `CurriculumSetUpdateRequest`

## GET /api/v1/org-admin/curriculum-sets/{id}

**Summary**: Get Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/org-admin/curriculum-sets/{id}

**Summary**: Delete Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/curriculum-sets/management/stats

**Summary**: Get Curriculum Management Stats

Get curriculum set management statistics.

Returns statistics about curriculum sets including counts, growth rates,
and completion metrics for the current organization.

## PATCH /api/v1/org-admin/curriculum-sets/{id}/submit

**Summary**: Submit Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/curriculum-sets/{id}/approve

**Summary**: Approve Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/curriculum-sets/{id}/reject

**Summary**: Reject Curriculum Set

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/curriculum-sets/{id}/progress

**Summary**: Get Curriculum Set Progress

Get progress for a curriculum set.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/curriculum-sets/{id}/resume

**Summary**: Get Curriculum Set Resume Position

Get resume position for a curriculum set.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/curriculum-sets/{id}/progress/recalculate

**Summary**: Recalculate Curriculum Set Progress

Recalculate progress for a curriculum set.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/curriculum-sets/{id}/learning-users

**Summary**: Get Learning Users

Get learning users for a curriculum set.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| name | query | False |  | Filter by user name |

## POST /api/v1/org-admin/curriculums

**Summary**: Create Curriculum

Create a curriculum with multiple documents.

### Request Body
- `application/json`: Reference `CurriculumCreateRequest`

## GET /api/v1/org-admin/curriculums/

**Summary**: List Curriculums

List documents that have a curriculum (one per doc).

Returns a normalized envelope: { data: [...], meta: { total, limit, offset } }

Supports filtering by:
- difficulty_level: beginner, intermediate, advanced
- min_duration/max_duration: duration range in minutes
- search: search term in name or description
- status: draft, pending, approved, rejected
- is_active: true/false
- resource_type_id: filter by resource type

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| difficulty_level | query | False |  |  |
| min_duration | query | False |  |  |
| max_duration | query | False |  |  |
| search | query | False |  |  |
| status | query | False |  |  |
| is_active | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |

## GET /api/v1/org-admin/curriculums/by-curriculum

**Summary**: Get Curriculum By Id Missing Param

Handle requests to by-curriculum without parameter.

## GET /api/v1/org-admin/curriculums/{id}

**Summary**: Get Curriculum

Get curriculum metadata by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/curriculums/by-curriculum/{curriculum_id}

**Summary**: Get Curriculum By Id

Get curriculum metadata by curriculum ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org-admin/curriculums/{curriculum_id}/outlines/latest

**Summary**: Get Latest Outline

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org-admin/curriculums/{curriculum_id}/ppts/latest

**Summary**: Get Latest Ppt

Get the latest PPT content and metadata for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org-admin/curriculums/{curriculum_id}/rendered_ppts/latest

**Summary**: Get Latest Rendered Ppt

Get the latest rendered PPT content and metadata for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org-admin/curriculums/{curriculum_id}/transcripts/latest

**Summary**: Get Latest Transcripts

Get the latest transcript content and metadata for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## POST /api/v1/org-admin/curriculums/{curriculum_id}/qa/

**Summary**: Curriculum Qa

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

### Request Body
- `application/json`: Reference `QARequest`

## PUT /api/v1/org-admin/curriculums/{curriculum_id}

**Summary**: Update Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

### Request Body
- `application/json`: Reference `CurriculumUpdateRequest`

## POST /api/v1/org-admin/curriculums/{curriculum_id}/practice-questions

**Summary**: Add Practice Questions

Add existing questions to curriculum as practice questions.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AddPracticeQuestionsRequest`

## GET /api/v1/org-admin/curriculums/{curriculum_id}/practice-questions

**Summary**: Get Practice Questions

Get practice questions for a curriculum with pagination.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## PATCH /api/v1/org-admin/curriculums/{curriculum_id}/submit

**Summary**: Submit Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## PATCH /api/v1/org-admin/curriculums/{curriculum_id}/approve

**Summary**: Approve Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## PATCH /api/v1/org-admin/curriculums/{curriculum_id}/reject

**Summary**: Reject Curriculum

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## PATCH /api/v1/org-admin/curriculums/{curriculum_id}/practice-questions/{question_id}

**Summary**: Update Practice Question

Update a practice question in a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| question_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UpdatePracticeQuestionRequest`

## POST /api/v1/org-admin/questions/

**Summary**: Create Question

### Request Body
- `application/json`: Reference `QuestionCreateRequest`

## GET /api/v1/org-admin/questions/

**Summary**: List Questions

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| resource_type_id | query | False |  |  |
| curriculum_id | query | False |  |  |
| full_text | query | False |  |  |
| category_code | query | False |  |  |
| difficulty_level | query | False |  |  |
| is_active | query | False |  |  |
| status | query | False |  |  |
| purposes | query | False |  |  |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## POST /api/v1/org-admin/questions/with-practice

**Summary**: Create Question With Practice

Create a new question with practice question association.

### Request Body
- `application/json`: Reference `PracticeQuestionCreateRequest`

## POST /api/v1/org-admin/questions/{id}/resubmit

**Summary**: Resubmit Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/questions/{id}/approve

**Summary**: Approve Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/questions/{id}/reject

**Summary**: Reject Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/questions/{id}/toggle-activation

**Summary**: Toggle Activation

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/questions/public

**Summary**: List Public Questions

List public questions for question selection.

Returns only active and approved questions from all curriculums.
This endpoint is used by:
- Curriculum practice questions (requires curriculums:write)
- Exam paper builder (requires exam_papers:write)

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| resource_type_id | query | False |  | Filter by resource type ID |
| curriculum_id | query | False |  | Filter by curriculum ID |
| full_text | query | False |  | Search in question content |
| category_code | query | False |  | Filter by question category |
| difficulty_level | query | False |  | Filter by difficulty level |
| purposes | query | False |  | Filter by question purposes |
| limit | query | False | integer | Number of questions to return |
| offset | query | False | integer | Offset for pagination |

## GET /api/v1/org-admin/questions/{id}

**Summary**: Get Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/org-admin/questions/{id}

**Summary**: Update Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `QuestionUpdateRequest`

## DELETE /api/v1/org-admin/questions/{id}

**Summary**: Delete Question

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/questions/import

**Summary**: Import Questions

Import questions from Excel or CSV file.

File format:
- Excel (.xlsx) or CSV (.csv)
- Columns: 序号, 题目名称, 题干, 难度等级, 题目类型, 用途,
           选项A, 选项B, 选项C, 选项D, 选项E, 选项F,
           答案, 解析, 课件名称

### Request Body
- `multipart/form-data`: Reference `Body_import_questions_api_v1_org_admin_questions_import_post`

## POST /api/v1/org-admin/questions/batch-submit

**Summary**: Batch Submit For Review

Batch submit questions for review.

### Request Body
- `application/json`: Reference `BatchActionRequest`

## POST /api/v1/org-admin/questions/batch-publish

**Summary**: Batch Publish

Batch publish questions.

### Request Body
- `application/json`: Reference `BatchActionRequest`

## POST /api/v1/org-admin/questions/batch-delete

**Summary**: Batch Delete

Batch delete questions.

### Request Body
- `application/json`: Reference `BatchActionRequest`

## POST /api/v1/org-admin/exam-papers/

**Summary**: Create Exam Paper

### Request Body
- `application/json`: Reference `ExamPaperCreateRequest`

## GET /api/v1/org-admin/exam-papers/

**Summary**: List Exam Papers

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| title_like | query | False |  |  |
| purpose | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| status | query | False |  | Filter by status |
| is_active | query | False |  | Filter by publish status |

## PATCH /api/v1/org-admin/exam-papers/{id}

**Summary**: Update Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `ExamPaperUpdateRequest`

## GET /api/v1/org-admin/exam-papers/{id}

**Summary**: Get Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/org-admin/exam-papers/{id}

**Summary**: Delete Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/exam-papers/{id}/preview

**Summary**: Preview Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-papers/{id}/approve

**Summary**: Approve Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-papers/{id}/reject

**Summary**: Reject Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-papers/{id}/resubmit

**Summary**: Resubmit Exam Paper

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-papers/{id}/toggle-activation

**Summary**: Toggle Exam Paper Activation

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/documents/{document_id}/state

**Summary**: Get Document State

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

## POST /api/v1/org-admin/documents/{document_id}/run-all

**Summary**: Run All Steps

Run all remaining pipeline steps from current step using the service's state-aware runner.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ProcessingRequest`

## GET /api/v1/org-admin/documents/{document_id}/clean

**Summary**: Get Clean Content

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

## PUT /api/v1/org-admin/documents/{document_id}/clean

**Summary**: Update Clean Content

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

### Request Body
- `application/x-www-form-urlencoded`: Reference `Body_update_clean_content_api_v1_org_admin_documents__document_id__clean_put`

## POST /api/v1/org-admin/documents/

**Summary**: Create Document

Create a document by uploading a file and immediately schedule processing.

Returns a ProcessingResponse containing the document_id for frontend polling.

### Request Body
- `multipart/form-data`: Reference `Body_create_document_api_v1_org_admin_documents__post`

## GET /api/v1/org-admin/documents/

**Summary**: List Documents

List documents using database-only metadata.

File system is not consulted for listings.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| filter_type | query | False | string | Filter type: 'all' or 'recent' |
| limit | query | False | integer | Number of documents to return |
| offset | query | False | integer | Number of documents to skip |

## DELETE /api/v1/org-admin/documents/{document_id}

**Summary**: Delete Document

Delete a document by metadata first, then cleanup binary files.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

## PATCH /api/v1/org-admin/documents/{document_id}/move

**Summary**: Move Document

Move a document to a folder.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| document_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DocumentMoveRequest`

## POST /api/v1/org-admin/folders/

**Summary**: Create Folder

Create a new folder.

### Request Body
- `application/json`: Reference `FolderCreateRequest`

## PATCH /api/v1/org-admin/folders/{folder_id}

**Summary**: Update Folder

Update a folder (rename or move).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| folder_id | path | True | string |  |

### Request Body
- `application/json`: Reference `FolderUpdateRequest`

## DELETE /api/v1/org-admin/folders/{folder_id}

**Summary**: Delete Folder

Delete a folder. Must be empty.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| folder_id | path | True | string |  |

## GET /api/v1/org-admin/folders/tree

**Summary**: Get Folder Tree

Get the full folder and document tree structure.

## POST /api/v1/org-admin/outlines/generate

**Summary**: Generate Outline Async

Generate a curriculum outline asynchronously.

Creates an initial outline record and triggers a background task.
Returns the created outline immediately.

### Request Body
- `application/json`: Reference `OutlineGeneration`

## POST /api/v1/org-admin/outlines/api/v1/curriculums/{curriculum_id}/outlines/create_with_tree

**Summary**: Create Outline With Tree

Create an empty outline with associated tree structure.

This endpoint is used when the user wants to build an outline tree from scratch.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org-admin/outlines/{outline_id}

**Summary**: Get Outline

Get a specific generated outline.

Args:
    outline_id: Outline ID

Returns:
    dict: The outline content and metadata

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## PUT /api/v1/org-admin/outlines/{outline_id}

**Summary**: Update Outline

Update a specific outline.

Args:
    outline_id: Outline ID
    request: Update request containing new content/title

Returns:
    dict: The updated outline content and metadata

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineUpdate`

## POST /api/v1/org-admin/outlines/{outline_id}/generate_ppt_async

**Summary**: Generate Ppt Content Async

Generate PPT content for a specific outline.

Args:
    outline_id: Outline ID to generate PPT for
    request: PPT generation request parameters

Returns:
    GeneratePPTAsyncResponse: Status and IDs for tracking generation

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

### Request Body
- `application/json`: Reference `GeneratePPTAsyncRequest`

## GET /api/v1/org-admin/outlines/{outline_id}/ppt/status

**Summary**: Get Ppt Status

Return latest PPT status with saved slide count for an outline.

Used by frontend polling to decide when to fetch full PPT data.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## GET /api/v1/org-admin/outline-trees/api/v1/outlines/{outline_id}/tree

**Summary**: Get Outline Tree

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## POST /api/v1/org-admin/outline-trees/api/v1/outlines/{outline_id}/tree/nodes

**Summary**: Create Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeCreateRequest`

## POST /api/v1/org-admin/outline-trees/api/v1/outlines/tree/nodes/{node_id}/move

**Summary**: Move Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeMoveRequest`

## PATCH /api/v1/org-admin/outline-trees/api/v1/outlines/tree/nodes/{node_id}

**Summary**: Update Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeUpdateRequest`

## DELETE /api/v1/org-admin/outline-trees/api/v1/outlines/tree/nodes/{node_id}

**Summary**: Delete Outline Node

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

## PUT /api/v1/org-admin/outline-trees/api/v1/outlines/tree/nodes/{node_id}/text-content

**Summary**: Update Outline Node Text Content

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| node_id | path | True | string |  |

### Request Body
- `application/json`: Reference `OutlineNodeTextUpdateRequest`

## POST /api/v1/org-admin/outline-node-attachments/upload

**Summary**: Upload Attachment

Upload an attachment for an outline node.

### Request Body
- `multipart/form-data`: Reference `Body_upload_attachment_api_v1_org_admin_outline_node_attachments_upload_post`

## PUT /api/v1/org-admin/outline-node-attachments/{attachment_id}

**Summary**: Replace Attachment

Replace an existing attachment.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_replace_attachment_api_v1_org_admin_outline_node_attachments__attachment_id__put`

## DELETE /api/v1/org-admin/outline-node-attachments/{attachment_id}

**Summary**: Delete Attachment

Delete an attachment.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## POST /api/v1/org-admin/exam-schedules/

**Summary**: Create Exam Schedule

### Request Body
- `application/json`: Reference `ExamScheduleCreateRequest`

## GET /api/v1/org-admin/exam-schedules/

**Summary**: List Exam Schedules

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| purpose | query | False |  |  |
| q | query | False |  |  |
| status | query | False |  |  |
| scope_type | query | False |  |  |
| is_active | query | False |  |  |
| bucket | query | False |  |  |
| time_from | query | False |  |  |
| time_to | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |

## GET /api/v1/org-admin/exam-schedules/stats

**Summary**: Get Exam Schedule Stats

## PATCH /api/v1/org-admin/exam-schedules/{id}

**Summary**: Update Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `ExamScheduleUpdateRequest`

## GET /api/v1/org-admin/exam-schedules/{id}

**Summary**: Get Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/org-admin/exam-schedules/{id}

**Summary**: Delete Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/exam-schedules/registered

**Summary**: List Registered Exam Schedules

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |

## PATCH /api/v1/org-admin/exam-schedules/{id}/submit-audit

**Summary**: Submit Audit Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-schedules/{id}/publish

**Summary**: Publish Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-schedules/{id}/unpublish

**Summary**: Unpublish Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-schedules/{id}/approve

**Summary**: Approve Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-schedules/{id}/reject

**Summary**: Reject Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-schedules/{id}/resubmit

**Summary**: Resubmit Exam Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/exam-schedules/{id}/attempts/stats

**Summary**: Get Exam Attempt Stats

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/exam-schedules/{id}/attempts

**Summary**: List Exam Attempts

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| q | query | False |  |  |
| status | query | False |  |  |
| is_cheating | query | False |  |  |

## GET /api/v1/org-admin/exam-schedules/{id}/attempts/{attempt_id}/timeline

**Summary**: Get Exam Attempt Timeline

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| attempt_id | path | True | string |  |
| sort | query | False | string |  |

## DELETE /api/v1/org-admin/exam-schedule-registrations/exam-schedules/{id}/registrations/{user_id}

**Summary**: Cancel User Registration

Cancel a user's exam registration (admin only).

Accessible to users with EXAM_SCHEDULES_WRITE or EXAM_SCHEDULES_ALL permission.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |
| user_id | path | True | string |  |

## GET /api/v1/org-admin/exam-marking/attempts

**Summary**: List Attempts For Marking

List exam attempts for marking with filters.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | query | False |  | Filter by exam schedule |
| marking_status | query | False |  | Filter by marking status |
| student_id | query | False |  | Filter by student |
| student_search | query | False |  | Search by student name or email |
| date_from | query | False |  | Filter by submitted date (from) |
| date_to | query | False |  | Filter by submitted date (to) |
| page | query | False | integer | Page number |
| limit | query | False | integer | Items per page |

## GET /api/v1/org-admin/exam-marking/attempts/{attempt_id}

**Summary**: Get Marking Detail

Get complete marking detail for an attempt including questions and answers.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/org-admin/exam-marking/attempts/{attempt_id}/progress

**Summary**: Get Marking Progress

Calculate marking progress for an attempt.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/org-admin/exam-marking/attempts/{attempt_id}/ai-grading-progress

**Summary**: Get Ai Grading Progress

Get AI grading progress for an attempt.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-marking/answers/{answer_id}/score

**Summary**: Update Answer Score

Update manual score for an answer.

- manual_score: The score to set (null to clear)
- grader_comments: Optional comments for this answer

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| answer_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UpdateAnswerScoreRequest`

## PATCH /api/v1/org-admin/exam-marking/attempts/{attempt_id}/publish

**Summary**: Publish Attempt

Publish an attempt's results to make them visible to the student.

Only allowed when all questions have been graded.
Requires EXAM_MARKING_ALL permission as this is a dangerous operation.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-marking/attempts/{attempt_id}/unpublish

**Summary**: Unpublish Attempt

Unpublish an attempt's results to hide them from the student.

Requires EXAM_MARKING_ALL permission as this is a dangerous operation.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/org-admin/exam-marking/attempts/{attempt_id}/comments

**Summary**: Update Grader Comments

Update overall grader comments for an attempt.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `UpdateGraderCommentsRequest`

## POST /api/v1/org-admin/exam-marking/schedules/{schedule_id}/bulk-publish

**Summary**: Bulk Publish Schedule

Publish all fully graded attempts for a schedule.

Requires EXAM_MARKING_ALL permission as this is a dangerous operation.
Only attempts with marking_status=FULLY_MARKED will be published.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## POST /api/v1/org-admin/exam-marking/schedules/{schedule_id}/bulk-unpublish

**Summary**: Bulk Unpublish Schedule

Unpublish all published attempts for a schedule.

Requires EXAM_MARKING_ALL permission as this is a dangerous operation.
Only attempts with marking_status=PUBLISHED will be unpublished.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## POST /api/v1/org-admin/exam-marking/attempts/{attempt_id}/lock

**Summary**: Acquire Grading Lock

Acquire grading lock for an attempt to prevent concurrent grading.

Returns lock_acquired=False if another user is already grading this attempt.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## DELETE /api/v1/org-admin/exam-marking/attempts/{attempt_id}/lock

**Summary**: Release Grading Lock

Release grading lock for an attempt.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## POST /api/v1/org-admin/exam-marking/answers/{answer_id}/ai-grade

**Summary**: Request Ai Grading

Request AI grading for an answer.

Creates an AI grading task and queues it for background processing.
Only works for fill-in-blank and open-text questions.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| answer_id | path | True | string |  |

### Request Body
- `application/json`: Reference `RequestAIGradingRequest`

## GET /api/v1/org-admin/exam-marking/tasks/{task_id}

**Summary**: Get Ai Task Status

Get the status and results of an AI grading task.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## GET /api/v1/org-admin/exam-marking/attempts/{attempt_id}/audit-log

**Summary**: Get Attempt Audit Log

Get audit log for an attempt.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |
| limit | query | False | integer | Maximum number of logs to return |

## GET /api/v1/org-admin/exam-marking/answers/{answer_id}/audit-log

**Summary**: Get Answer Audit Log

Get audit log for a specific answer.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| answer_id | path | True | string |  |
| limit | query | False | integer | Maximum number of logs to return |

## POST /api/v1/org-admin/exam-marking/attempts/{attempt_id}/bulk-ai-grade

**Summary**: Bulk Ai Grade Attempt

Bulk AI grade all subjective questions in an attempt.

Creates AI grading tasks for all fill-in-blank and open-text questions that:
- Haven't been manually graded yet
- Are of supported question types

Each question will be graded as a separate background task.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `BulkAIGradingRequest`

## POST /api/v1/org-admin/exam-marking/schedules/{schedule_id}/bulk-ai-grade

**Summary**: Bulk Ai Grade Schedule

Bulk AI grade all subjective questions across all attempts in a schedule.

Creates AI grading tasks for all fill-in-blank and open-text questions that:
- Haven't been manually graded yet
- Are of supported question types
- Belong to any attempt in the schedule

Each question will be graded as a separate background task.
This can create a large number of tasks for schedules with many attempts.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

### Request Body
- `application/json`: Reference `BulkAIGradingRequest`

## GET /api/v1/org-admin/audios/{audio_id}/file

**Summary**: Serve Audio File

Serve an audio file by its ID.

- Retrieves audio metadata from database
- Uses the stored file_path directly from the database
- Serves the audio file with proper content-type headers
- Includes security checks and error handling

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| audio_id | path | True | string |  |

## POST /api/v1/org-admin/audios/generate_all_async

**Summary**: Generate All Audios Async

### Request Body
- `application/json`: Reference `GenerateAudiosRequest`

## POST /api/v1/org-admin/audios/generate

**Summary**: Generate Slide Audio

Generate or update audio for a single selected rendered slide.

- Finds the transcript by rendered slide ID
- Synthesizes audio via VoxCPM
- Stores audio using the new Audio model

### Request Body
- `application/json`: Reference `GenerateSlideAudioRequest`

## POST /api/v1/org-admin/videos/upload

**Summary**: Upload Video

Upload a video file for a manual curriculum outline node.

Args:
    file: The video file to upload
    outline_node_id: ID of the outline node this video belongs to
    video_service: Injected video service
    current_user: Authenticated user
    session: Database session

Returns:
    VideoUploadResponse with video metadata

### Request Body
- `multipart/form-data`: Reference `Body_upload_video_api_v1_org_admin_videos_upload_post`

## GET /api/v1/org-admin/videos/{video_id}/file

**Summary**: Serve Video File

Serve a video file by its ID using JWT token authentication.

- Authenticates user via JWT token (from header or query parameter)
- Retrieves video metadata from database
- Uses the stored file_path directly from the database
- Serves the video file with proper content-type headers
- Includes security checks and error handling

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| video_id | path | True | string |  |

## POST /api/v1/org-admin/videos/generate

**Summary**: Generate Slide Video

Generate or update video for a single selected slide.

- Finds the slide and its corresponding audio file from the latest transcript for the curriculum.
- Generates video via HeyGem using the audio file.
- Registers video as a `video` artifact and updates the transcript.
- Requires that audio has been generated for the slide first.

### Request Body
- `application/json`: Reference `GenerateSlideVideoRequest`

## POST /api/v1/org-admin/videos/generate_all_async

**Summary**: Generate All Videos Async

### Request Body
- `application/json`: Reference `GenerateVideosRequest`

## POST /api/v1/org-admin/transcripts/generate_async

**Summary**: Generate Transcripts Async

### Request Body
- `application/json`: Reference `GenerateTranscriptRequest`

## GET /api/v1/org-admin/transcripts/{rendered_ppt_id}

**Summary**: Get Transcript

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

## PUT /api/v1/org-admin/transcripts/{rendered_ppt_id}

**Summary**: Update Transcript

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `TranscriptUpdateRequest`

## POST /api/v1/org-admin/transcripts/slide

**Summary**: Generate Slide Transcript

Generate transcript for a single rendered slide.

### Request Body
- `application/json`: Reference `GenerateSlideTranscriptRequest`

## POST /api/v1/org-admin/rendered-ppts/

**Summary**: Create Rendered Ppt

Create a new rendered PPT artifact for a PPT.

The slides payload is expected to be template-rendered slides
(each slide containing concrete elements), which differs from the
AI-generated 'ppt' blocks structure.
Saves the artifact as type 'rendered_ppt'.

### Request Body
- `application/json`: Reference `RenderedPPTCreateRequest`

## PUT /api/v1/org-admin/rendered-ppts/{rendered_ppt_id}

**Summary**: Update Rendered Ppt

Update the content of a specific rendered PPT artifact (slides as JSON list) for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `RenderedPPTRequest`

## GET /api/v1/org-admin/rendered-ppts/{rendered_ppt_id}

**Summary**: Get Rendered Ppt

Retrieve the content of a specific rendered PPT artifact (slides as JSON list) for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

## GET /api/v1/org-admin/rendered-ppts/{rendered_ppt_id}/audios/status

**Summary**: Get Audio Status For Rendered Ppt

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

## GET /api/v1/org-admin/rendered-ppts/{rendered_ppt_id}/videos/status

**Summary**: Get Video Status For Rendered Ppt

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

## GET /api/v1/org-admin/rendered-ppts/{rendered_ppt_id}/transcripts/status

**Summary**: Get Transcript Status For Rendered Ppt

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| rendered_ppt_id | path | True | string |  |

## GET /api/v1/org-admin/ppt-templates/

**Summary**: Get Templates

Get all PPT templates.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| q | query | False | string | Search query for template name |
| page | query | False | integer | Page number |
| page_size | query | False | integer | Items per page |

## POST /api/v1/org-admin/ppt-templates/

**Summary**: Create Template

Create a new PPT template.

Requires ppt_templates:all permission.

### Request Body
- `application/json`: Reference `PPTTemplateCreateRequest`

## GET /api/v1/org-admin/ppt-templates/public

**Summary**: Get Public Templates

Get all approved and active PPT templates.

Requires user to have at least one permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| q | query | False | string | Search query for template name |
| page | query | False | integer | Page number |
| page_size | query | False | integer | Items per page |

## GET /api/v1/org-admin/ppt-templates/{template_id}

**Summary**: Get Template

Get a specific PPT template by ID.

Requires authentication. Returns templates that are either:
- Created by the current user
- Approved and active (public templates)

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## PUT /api/v1/org-admin/ppt-templates/{template_id}

**Summary**: Update Template

Update an existing PPT template.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

### Request Body
- `application/json`: Reference `PPTTemplateUpdateRequest`

## DELETE /api/v1/org-admin/ppt-templates/{template_id}

**Summary**: Delete Template

Delete a PPT template.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/org-admin/ppt-templates/from-pptx

**Summary**: Create Template From Pptx

Create a template from a PPTX file.

Requires ppt_templates:all permission.

## POST /api/v1/org-admin/ppt-templates/{template_id}/submit

**Summary**: Submit Template

Submit a PPT template for approval.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/org-admin/ppt-templates/{template_id}/approve

**Summary**: Approve Template

Approve a submitted PPT template.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/org-admin/ppt-templates/{template_id}/reject

**Summary**: Reject Template

Reject a submitted PPT template.

Requires ppt_templates:all permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| template_id | path | True | string |  |

## POST /api/v1/org-admin/attachments/test

**Summary**: Test Upload

Test upload endpoint without authentication or file requirements.

## POST /api/v1/org-admin/attachments/

**Summary**: Upload Attachment

Upload an attachment file.

### Request Body
- `multipart/form-data`: Reference `Body_upload_attachment_api_v1_org_admin_attachments__post`

## GET /api/v1/org-admin/attachments/

**Summary**: List Attachments

List attachments for the current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer | Number of attachments to return |
| offset | query | False | integer | Number of attachments to skip |
| search | query | False |  | Search by filename |
| only_images | query | False | boolean | Filter only image files |

## GET /api/v1/org-admin/attachments/{attachment_id}

**Summary**: Get Attachment

Get attachment information by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## DELETE /api/v1/org-admin/attachments/{attachment_id}

**Summary**: Delete Attachment

Delete an attachment.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## GET /api/v1/org-admin/attachments/{attachment_id}/download

**Summary**: Download Attachment

Download an attachment file.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## POST /api/v1/org-admin/question-generation/tasks

**Summary**: Create Generation Task

### Request Body
- `application/json`: Reference `QuestionGenerationCreateRequest`

## GET /api/v1/org-admin/question-generation/tasks

**Summary**: List Generation Tasks

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| resource_type_id | query | False |  |  |
| curriculum_id | query | False |  |  |
| status | query | False |  |  |

## GET /api/v1/org-admin/question-generation/tasks/{task_id}

**Summary**: Get Generation Task

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## GET /api/v1/org-admin/question-generation/tasks/{task_id}/status

**Summary**: Get Generation Task Status

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## PUT /api/v1/org-admin/question-generation/tasks/{task_id}/resubmit

**Summary**: Resubmit Generation Task

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| task_id | path | True | string |  |

## POST /api/v1/org-admin/question-assets/upload

**Summary**: Upload Question Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_type | query | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_upload_question_asset_api_v1_org_admin_question_assets_upload_post`

## PUT /api/v1/org-admin/question-assets/{asset_id}/attach

**Summary**: Attach Question Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

### Request Body
- `application/json`: Reference `QuestionAssetAttachRequest`

## GET /api/v1/org-admin/question-assets/{asset_id}/file

**Summary**: Get Question Asset File

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## DELETE /api/v1/org-admin/question-assets/{asset_id}

**Summary**: Delete Question Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## POST /api/v1/org-admin/question-option-assets/upload

**Summary**: Upload Option Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_type | query | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_upload_option_asset_api_v1_org_admin_question_option_assets_upload_post`

## PUT /api/v1/org-admin/question-option-assets/{asset_id}/attach

**Summary**: Attach Option Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

### Request Body
- `application/json`: Reference `QuestionOptionAssetAttachRequest`

## GET /api/v1/org-admin/question-option-assets/{asset_id}/file

**Summary**: Get Option Asset File

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## DELETE /api/v1/org-admin/question-option-assets/{asset_id}

**Summary**: Delete Option Asset

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| asset_id | path | True | string |  |

## GET /api/v1/org-admin/digital-teachers

**Summary**: List Teachers

Admin view: List all digital teachers in the system.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| name | query | False |  |  |
| audit_status | query | False |  |  |
| is_shared | query | False |  | Filter by shared status (true/false) |
| copyright_owner_name | query | False |  |  |

## POST /api/v1/org-admin/digital-teachers

**Summary**: Create Teacher

### Request Body
- `multipart/form-data`: Reference `Body_create_teacher_api_v1_org_admin_digital_teachers_post`

## GET /api/v1/org-admin/digital-teachers/my

**Summary**: List My Teachers

User view: List digital teachers available to the current user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| name | query | False |  |  |

## GET /api/v1/org-admin/digital-teachers/{id}

**Summary**: Get Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/digital-teachers/{id}/audio-file

**Summary**: Serve Teacher Audio

Serve the audio file for a digital teacher.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org-admin/digital-teachers/{id}/video-file

**Summary**: Serve Teacher Video

Serve the video file for a digital teacher.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/org-admin/digital-teachers/{teacher_id}

**Summary**: Update Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

### Request Body
- `multipart/form-data`: Reference `Body_update_teacher_api_v1_org_admin_digital_teachers__teacher_id__put`

## DELETE /api/v1/org-admin/digital-teachers/{teacher_id}

**Summary**: Delete Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## POST /api/v1/org-admin/digital-teachers/{teacher_id}/submit

**Summary**: Submit Digital Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

## POST /api/v1/org-admin/digital-teachers/{id}/approve

**Summary**: Approve Digital Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org-admin/digital-teachers/{id}/reject

**Summary**: Reject Digital Teacher

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/org-admin/digital-teachers/{teacher_id}/status

**Summary**: Update Teacher Status

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| teacher_id | path | True | string |  |

### Request Body
- `application/json`: Reference `DigitalTeacherStatusUpdateRequest`

## POST /api/v1/org-admin/resource-types/

**Summary**: Create Resource Type

Create a new resource type.

### Request Body
- `application/json`: Reference `ResourceTypeCreateRequest`

## GET /api/v1/org-admin/resource-types/

**Summary**: List Resource Types

List all resource types (flat list with pagination).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org-admin/resource-types/tree

**Summary**: Get Resource Type Tree

Get all resource types as a tree structure.

## GET /api/v1/org-admin/resource-types/tree-with-counts

**Summary**: Get Resource Type Tree With Counts

Get all resource types as a tree structure with resource counts.

## GET /api/v1/org-admin/resource-types/{id}

**Summary**: Get Resource Type

Get a resource type by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## PUT /api/v1/org-admin/resource-types/{id}

**Summary**: Update Resource Type

Update a resource type.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

### Request Body
- `application/json`: Reference `ResourceTypeUpdateRequest`

## DELETE /api/v1/org-admin/resource-types/{id}

**Summary**: Delete Resource Type

Delete a resource type.

Prevents deletion if the resource type has children or associated generation tasks.
Other references (questions, curriculums, exam papers, etc.) will be set to NULL.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org/learning-progress/sessions/start

**Summary**: Start Learning Session

Start a new learning session or resume an existing one.

### Request Body
- `application/json`: Reference `SessionStartRequest`

## POST /api/v1/org/learning-progress/sessions/{session_id}/end

**Summary**: End Learning Session

End a learning session.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| session_id | path | True | string |  |

## POST /api/v1/org/learning-progress/slides/track

**Summary**: Track Slide Progress

Track slide view progress.

### Request Body
- `application/json`: Reference `TrackSlideProgressRequest`

## POST /api/v1/org/learning-progress/media/track

**Summary**: Track Media Progress

Track media (audio/video) progress.

### Request Body
- `application/json`: Reference `TrackMediaProgressRequest`

## GET /api/v1/org/learning-progress/resume

**Summary**: Get Resume Position

Get resume position for a user in a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | query | True | string | Curriculum ID |
| outline_id | query | False |  | Optional outline ID |

## GET /api/v1/org/learning-progress/analytics

**Summary**: Get Learning Analytics

Get learning analytics for a user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | query | True | string | Curriculum ID |
| outline_id | query | True | string | Outline ID |

## GET /api/v1/org/learning-progress/curriculum/{curriculum_id}/progress

**Summary**: Get Curriculum Progress

Get curriculum progress for a user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| outline_id | query | False | string | Optional outline ID |

## GET /api/v1/org/learning-progress/curriculum/{curriculum_id}/outline-node-progress

**Summary**: Get Outline Node Progress

Get media progress aggregated by outline node for a curriculum.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |
| outline_id | query | False |  | Optional outline ID |

## POST /api/v1/org/learning-progress/batch/progress

**Summary**: Get Batch Curriculum Progress

Get curriculum progress for multiple curriculums in one batch call.

This endpoint is used by the curriculum set learning page to fetch
progress for all curriculums in a set efficiently, avoiding N+1 queries.

Args:
    curriculum_ids: List of curriculum IDs to fetch progress for

Returns:
    Dictionary mapping curriculum_id to progress data

### Request Body
- `application/json`: array

## GET /api/v1/org/exam-runtime/attempts/me

**Summary**: List My Attempts

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |

## POST /api/v1/org/exam-runtime/schedules/{schedule_id}/attempts

**Summary**: Start Attempt

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## GET /api/v1/org/exam-runtime/attempts/my

**Summary**: Get My Attempt For Schedule

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | query | True | string |  |

## GET /api/v1/org/exam-runtime/attempts/{attempt_id}

**Summary**: Get Attempt

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/org/exam-runtime/attempts/{attempt_id}/instance

**Summary**: Get Attempt Instance

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## POST /api/v1/org/exam-runtime/attempts/{attempt_id}/anti-cheat

**Summary**: Log Anti Cheat

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AntiCheatEventCreateRequest`

## GET /api/v1/org/exam-runtime/attempts/{attempt_id}/anti-cheat/count

**Summary**: Get Anti Cheat Count

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |
| event_type | query | True | string |  |

## POST /api/v1/org/exam-runtime/attempts/{attempt_id}/answers

**Summary**: Upsert Answer

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `AnswerUpsertRequest`

## POST /api/v1/org/exam-runtime/attempts/{attempt_id}/submit

**Summary**: Submit Attempt

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/org/exam-runtime/attempts/{attempt_id}/results/student

**Summary**: Get Student Results

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## GET /api/v1/org/exam-runtime/attempts/{attempt_id}/results/instructor

**Summary**: Get Instructor Results

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

## PATCH /api/v1/org/exam-runtime/heartbeat

**Summary**: Heartbeat

## POST /api/v1/org/exam-runtime/attempts/{attempt_id}/sessions

**Summary**: Create Session

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `ExamAttemptSessionCreateRequest`

## PATCH /api/v1/org/exam-runtime/sessions/{session_id}/end

**Summary**: End Session

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| session_id | path | True | string |  |

## PATCH /api/v1/org/exam-runtime/attempts/{attempt_id}/tab-blur-limit

**Summary**: Update Tab Blur Limit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attempt_id | path | True | string |  |

### Request Body
- `application/json`: Reference `TabBlurLimitUpdateRequest`

## GET /api/v1/org/exam-runtime/schedules/{schedule_id}/start-info

**Summary**: Get Start Info

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| schedule_id | path | True | string |  |

## POST /api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations

**Summary**: Register Exam

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## DELETE /api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations

**Summary**: Cancel Exam

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations/summary

**Summary**: Registration Summary

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/exam-schedule-registrations/exam-schedules/{id}/registrations/me

**Summary**: Get My Registration

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/curriculum-question-instances/next-question

**Summary**: Get next unanswered question

Get the next unanswered question for a progress record.

Returns the first question that hasn't been answered yet.
If all questions are answered, returns null.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## GET /api/v1/org/curriculum-question-instances/list-unanswered

**Summary**: List all unanswered questions

List all unanswered questions for a progress record.

Returns all questions that haven't been answered yet.
Useful for loading all questions at once for navigation and progress display.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## GET /api/v1/org/curriculum-question-instances/list-all

**Summary**: List all questions (answered and unanswered)

List all questions for a progress record.

Returns both answered and unanswered questions.
Allows users to review all questions and their answers.
Useful for navigation through completed practice and review mode.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## POST /api/v1/org/curriculum-question-instances/submit-answer

**Summary**: Submit answer and get feedback

Submit an answer and get immediate feedback.

Automatically updates progress after answer submission.

Request body:
- **progress_id**: Progress record ID
- **question_instance_id**: Question instance to answer
- **organization_id**: Organization ID
- **selected_option_ids**: Selected options (for choice questions)
- **answer_text**: Text answer (for fill-in-blank/open text)
- **time_spent_seconds**: Time taken to answer
- **answer_metadata**: Additional metadata
- **is_skipped**: Whether question was skipped

Response includes:
- **is_correct**: Whether answer was correct
- **correct_option_id/ids**: Correct answer(s)
- **explanation**: Question explanation
- **attempt_number**: Which attempt this is

### Request Body
- `application/json`: Reference `SubmitAnswerRequest`

## GET /api/v1/org/curriculum-question-instances/questions-with-incorrect-attempts

**Summary**: Get questions with incorrect attempts

Get questions that have at least one incorrect attempt.

Returns questions the user struggled with for final review.
Includes correct answers and explanations.

- **progress_id**: Progress record ID
- **outline_node_id**: Optional filter to get questions from a specific unit

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter |

## GET /api/v1/org/curriculum-question-instances/stats

**Summary**: Get question statistics

Get detailed question statistics for a progress record.

Returns aggregate statistics and per-unit completion details.

- **progress_id**: Progress record ID

Response includes:
- **question_units_total**: Total number of question units
- **question_units_completed**: Units with all questions answered
- **question_completion_percentage**: Question unit completion percentage
- **questions_correct_count**: First attempts that were correct
- **questions_incorrect_count**: First attempts that were wrong
- **overall_completion_percentage**: Overall progress (slides + media + questions)
- **unit_completion_details**: Per-unit breakdown

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |

## GET /api/v1/org/curriculum-question-instances/unit-progress

**Summary**: Get question unit progress

Get progress for a specific question unit.

Returns detailed completion information for a single unit.

- **progress_id**: Progress record ID
- **outline_node_id**: Unit ID (null to get comprehensive questions)

Response includes:
- **outline_node_id**: Unit ID
- **total_questions**: Total questions in unit
- **answered_count**: Questions with at least one attempt
- **first_attempt_correct_count**: First attempts that were correct
- **completion_percentage**: Unit completion percentage

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| progress_id | query | True | string | Progress record ID |
| outline_node_id | query | False |  | Optional unit filter (null = comprehensive questions) |

## GET /api/v1/org/departments

**Summary**: List active departments for public display

List active departments for public display.

Accessible to any authenticated user in the organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| search | query | False |  |  |

## GET /api/v1/org/products/free

**Summary**: List Free Products

List all free products (price = 0).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org/products/limited-time-free

**Summary**: List Limited Time Free Products

List paid products that are currently free via campaign.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org/products/paid

**Summary**: List Paid Products

List paid products (price > 0 or with paid campaigns).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org/curriculums

**Summary**: List Curriculums

List publicly available curriculums.

Only returns curriculums that are approved and active.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| difficulty_level | query | False |  |  |
| min_duration | query | False |  |  |
| max_duration | query | False |  |  |
| search | query | False |  |  |
| resource_type_id | query | False |  |  |

## GET /api/v1/org/curriculums/{curriculum_id}

**Summary**: Get Curriculum By Id

Get public curriculum metadata by curriculum ID.

Only returns approved and active curriculums.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org/curriculums/{curriculum_id}/outlines/latest

**Summary**: Get Latest Outline

Get the latest public outline for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).
Accessible to any authenticated user in the organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org/curriculums/{curriculum_id}/transcripts/latest

**Summary**: Get Latest Transcripts

Get the latest public transcript content and metadata for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).
Accessible to any authenticated user in the organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org/curriculums/{curriculum_id}/ppts/latest

**Summary**: Get Latest Ppt

Get the latest public PPT content and metadata for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).
Accessible to any authenticated user in the organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org/curriculums/{curriculum_id}/rendered_ppts/latest

**Summary**: Get Latest Rendered Ppt

Get the latest public rendered PPT content and metadata for a curriculum.

Only works for complete curriculums (have outline, PPT, and rendered PPT).
Accessible to any authenticated user in the organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| curriculum_id | path | True | string |  |

## GET /api/v1/org/curriculum-sets

**Summary**: List Curriculum Sets

List public curriculum sets.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| created_by_id | query | False |  |  |
| search | query | False |  |  |
| min_minutes | query | False |  |  |
| max_minutes | query | False |  |  |
| difficulty | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID (deprecated, use resource_type_ids) |
| resource_type_ids | query | False |  | Filter by multiple resource type IDs |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| name | query | False |  | Filter by curriculum name |
| created_by_name | query | False |  | Filter by person in charge name |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/org/curriculum-sets/my-purchased

**Summary**: List My Purchased Curriculum Sets

List curriculum sets purchased by the current user.

Returns curriculum sets that the user has valid access to through purchases.
Items are considered valid if:
- expire_time is None (permanent access)
- expire_time is in the future (still within valid period)

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org/curriculum-sets/my-tasks

**Summary**: List My Tasks

List curriculum sets that the current user has started but not finished.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org/curriculum-sets/{id}

**Summary**: Get Curriculum Set

Get public curriculum set by ID.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/curriculum-sets/{id}/progress

**Summary**: Get Curriculum Set Progress

Get progress for a curriculum set.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/curriculum-sets/{id}/resume

**Summary**: Get Curriculum Set Resume Position

Get resume position for a curriculum set.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org/curriculum-sets/{id}/progress/recalculate

**Summary**: Recalculate Curriculum Set Progress

Recalculate progress for a curriculum set.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## POST /api/v1/org/orders/orders

**Summary**: Create Order

Create a new order.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Request Body
- `application/json`: Reference `OrderCreateRequest`

## GET /api/v1/org/orders/orders

**Summary**: List My Orders

List orders for the current user.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org/orders/orders/{order_id}

**Summary**: Get Order Details

Get order details.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |

## POST /api/v1/org/orders/orders/{order_id}/pay

**Summary**: Initiate Payment

Initiate payment for an order.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |
| payment_channel | query | True | PaymentChannel |  |

## POST /api/v1/org/orders/orders/{order_id}/cancel

**Summary**: Cancel Order

Cancel an unpaid order.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| order_id | path | True | string |  |

## GET /api/v1/org/orders/orders/purchased/items

**Summary**: List Purchased Items

List items purchased by the user.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

## GET /api/v1/org/orders/orders/purchased/check

**Summary**: Check Purchased Item

Check if a specific product or item is purchased and valid.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| product_id | query | False |  |  |
| product_type | query | False |  |  |
| external_id | query | False |  |  |

## POST /api/v1/org/videos/upload

**Summary**: Upload Video

Upload a video file for a manual curriculum outline node.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

Args:
    file: The video file to upload
    outline_node_id: ID of the outline node this video belongs to
    video_service: Injected video service
    current_user: Authenticated user
    session: Database session

Returns:
    VideoUploadResponse with video metadata

### Request Body
- `multipart/form-data`: Reference `Body_upload_video_api_v1_org_videos_upload_post`

## GET /api/v1/org/videos/{video_id}/file

**Summary**: Serve Video File

Serve a video file by its ID using JWT token authentication.

- Authenticates user via JWT token (from header or query parameter)
- Retrieves video metadata from database
- Uses the stored file_path directly from the database
- Serves the video file with proper content-type headers
- Includes security checks and error handling

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| video_id | path | True | string |  |

## GET /api/v1/org/audios/{audio_id}/file

**Summary**: Serve Audio File

Serve an audio file by its ID.

RLS automatically filters to current organization.
Accessible to any authenticated user.

- Retrieves audio metadata from database
- Uses the stored file_path directly from the database
- Serves the audio file with proper content-type headers
- Includes security checks and error handling

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| audio_id | path | True | string |  |

## GET /api/v1/org/dictionaries/batch

**Summary**: Batch get dictionaries

Get multiple dictionaries by their type codes

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| codes | query | True | array |  |

## GET /api/v1/org/digital-teachers

**Summary**: List Teachers

List public digital teachers.

Returns approved digital teachers accessible to the current user.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| name | query | False |  |  |

## GET /api/v1/org/attachments/{attachment_id}/download

**Summary**: Download Attachment

Download an attachment file.

RLS automatically filters to current organization.
Accessible to any authenticated user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| attachment_id | path | True | string |  |

## GET /api/v1/org/outline-node-attachments/node/{outline_node_id}

**Summary**: List Attachments

List attachments for an outline node.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_node_id | path | True | string |  |

## GET /api/v1/org/banners

**Summary**: List Banners

Get list of banners for public display.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| platform | query | False |  | Filter by platform |

## GET /api/v1/org/banners/{banner_id}

**Summary**: Get Banner

Get a specific public banner by ID.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

## GET /api/v1/org/exam-schedules

**Summary**: List Exam Schedules

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| purpose | query | False |  |  |
| q | query | False |  |  |
| time_from | query | False |  |  |
| time_to | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/org/exam-schedules/{id}

**Summary**: Get Exam Schedule

Get a published and active exam schedule by ID.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/training-classes

**Summary**: List Training Classes

List training classes accessible to org members.

Returns only published, active, and approved training classes.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| q | query | False |  |  |
| is_free | query | False |  | Filter by free training classes |
| is_limited_free | query | False |  | Filter by limited-time free training classes |
| is_paid | query | False |  | Filter by paid training classes |
| start_date_from | query | False |  |  |
| start_date_to | query | False |  |  |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |
| resource_type_ids | query | False |  | Filter by multiple resource type IDs |

## GET /api/v1/org/training-classes/purchase-status/{id}

**Summary**: Get Training Class Purchase Status

Check if the current user has purchased the training class.

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/training-classes/my-purchased

**Summary**: List My Purchased Training Classes

List training classes purchased by the current user.

Returns training classes that the user has valid access to through purchases.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |

## GET /api/v1/org/training-classes/center

**Summary**: List Training Classes For Center

List training classes for center page with three categorized lists.

Returns three lists:
- Free classes: pricing_type == FREE and product.price == 0
- Limited free classes: pricing_type == PAID and active campaign makes it 0
- Paid classes: pricing_type == PAID and product.price > 0 with no active 0 campaign

Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| free_limit | query | False | integer | Limit for free training classes |
| limited_free_limit | query | False | integer | Limit for limited-time free training classes |
| paid_limit | query | False | integer | Limit for paid training classes |

## GET /api/v1/org/training-classes/{id}

**Summary**: Get Training Class

Get training class by ID.

Returns only published, active, and approved training classes.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/teacher-manages/public

**Summary**: List Teacher Manages Public

Get list of teacher manages for public display (only approved and active).

RLS automatically filters to current organization.
Accessible to any authenticated user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| q | query | False |  | Search by name or description |

## GET /api/v1/org/teacher-manages/public/{id}

**Summary**: Get Teacher Manage Public

Get teacher manage by ID for public display (only approved and active).

RLS automatically filters to current organization.
Accessible to any authenticated user.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/org/announcements

**Summary**: Get Announcements

Get list of active announcements for org members.

Returns only active announcements.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| search | query | False |  | Search by title or content |

## GET /api/v1/org/announcements/{announcement_id}

**Summary**: Get Announcement

Get announcement by ID.

Returns active announcements only.
Accessible to any authenticated user in the organization.
RLS automatically filters to current organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## GET /api/v1/org/users/me/learning-overview

**Summary**: Get My Learning Overview

Get the current user's learning progress overview.

RLS automatically filters to current organization.
Any authenticated user can access their own learning overview.

## GET /api/v1/org/user-certificates/my

**Summary**: List My Certificates

Get the current user's earned certificates.

RLS automatically filters to current organization.
Accessible to any authenticated user with USER_CERTIFICATES_READ permission.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |

## GET /api/v1/org/api/v1/outlines/{outline_id}/tree

**Summary**: Get Outline Tree

Get public outline tree for learning.

Only works for outlines belonging to approved and active curriculums.
Accessible to any authenticated user in the organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| outline_id | path | True | string |  |

## GET /api/v1/org/notifications

**Summary**: List Notifications

Get the current user's notifications.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| is_read | query | False |  | Filter by read status |
| category | query | False |  | Filter by category |
| priority | query | False |  | Filter by priority |
| limit | query | False | integer | Items per page |
| offset | query | False | integer | Items to skip |

## GET /api/v1/org/notifications/{notification_id}

**Summary**: Get Notification

Get notification details.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| notification_id | path | True | string |  |

## DELETE /api/v1/org/notifications/{notification_id}

**Summary**: Delete Notification

Delete a notification.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| notification_id | path | True | string |  |

## PATCH /api/v1/org/notifications/{notification_id}/read

**Summary**: Mark As Read

Mark a notification as read.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| notification_id | path | True | string |  |

## PATCH /api/v1/org/notifications/read-all

**Summary**: Mark All As Read

Mark all unread notifications for the current user as read.

## GET /api/v1/org/activity-logs

**Summary**: List Activity Logs

Get the activity logs for the organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| action_type | query | False |  | Filter by action type (CREATE, UPDATE, DELETE) |
| resource_type | query | False |  | Filter by resource type |
| limit | query | False | integer | Items per page |
| offset | query | False | integer | Items to skip |

## GET /api/v1/org/todo-items

**Summary**: List Todo Items

Get the current user's todo items.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| status | query | False |  | Filter by status (e.g. PENDING, IN_PROGRESS) |
| category | query | False |  | Filter by category |
| limit | query | False | integer | Items per page |
| offset | query | False | integer | Items to skip |

## POST /api/v1/org/todo-items/{todo_id}/execute

**Summary**: Execute Todo Item

Execute a todo item (mark it as COMPLETED and return the resource info).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| todo_id | path | True | string |  |

## POST /api/v1/org/todo-items/{todo_id}/close

**Summary**: Close Todo Item

Close a todo item (mark it as COMPLETED).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| todo_id | path | True | string |  |

## GET /api/v1/public/curriculum-sets

**Summary**: List Curriculum Sets

List public curriculum sets from primary organization.

No authentication required.
RLS automatically filters to primary organization and returns only
approved and active curriculum sets.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| limit | query | False | integer |  |
| offset | query | False | integer |  |
| created_by_id | query | False |  |  |
| search | query | False |  |  |
| min_minutes | query | False |  |  |
| max_minutes | query | False |  |  |
| difficulty | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| is_free | query | False |  | Filter by free courses |
| is_limited_free | query | False |  | Filter by limited-time free courses |
| is_paid | query | False |  | Filter by paid courses |
| name | query | False |  | Filter by curriculum name |
| created_by_name | query | False |  | Filter by person in charge name |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/public/curriculum-sets/{id}

**Summary**: Get Curriculum Set

Get public curriculum set by ID from primary organization.

No authentication required.
RLS automatically filters to primary organization and returns only
approved and active curriculum sets.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/public/exam-schedules

**Summary**: List Exam Schedules

List public exam schedules from primary organization.

No authentication required.
RLS automatically filters to primary organization and returns only
published and active exam schedules.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| page | query | False | integer |  |
| limit | query | False | integer |  |
| purpose | query | False |  |  |
| q | query | False |  |  |
| time_from | query | False |  |  |
| time_to | query | False |  |  |
| resource_type_id | query | False |  | Filter by resource type ID |
| is_free | query | False |  | Filter by free exams |
| is_limited_free | query | False |  | Filter by limited-time free exams |
| is_paid | query | False |  | Filter by paid exams |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/public/exam-schedules/{id}

**Summary**: Get Exam Schedule

Get public exam schedule by ID from primary organization.

No authentication required.
RLS automatically filters to primary organization and returns only
published and active exam schedules.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/public/training-classes

**Summary**: List Training Classes

List public training classes from primary organization.

No authentication required.
RLS automatically filters to primary organization and returns only
approved and active training classes.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| q | query | False |  |  |
| is_free | query | False |  | Filter by free training classes |
| is_limited_free | query | False |  | Filter by limited-time free training classes |
| is_paid | query | False |  | Filter by paid training classes |
| start_date_from | query | False |  |  |
| start_date_to | query | False |  |  |
| is_recommended | query | False |  | Filter by recommended items |
| is_pinned | query | False |  | Filter by pinned items |

## GET /api/v1/public/training-classes/center

**Summary**: List Training Classes For Center

List training classes categorized by pricing type for center page.

No authentication required.
Returns three lists:
- Free: pricing_type == FREE and product.price == 0
- Limited Free: pricing_type == PAID and active campaign makes it 0
- Paid: pricing_type == PAID and product.price > 0 and no active 0 campaign

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| free_limit | query | False | integer |  |
| limited_free_limit | query | False | integer |  |
| paid_limit | query | False | integer |  |

## GET /api/v1/public/training-classes/{id}

**Summary**: Get Training Class

Get public training class by ID from primary organization.

No authentication required.
RLS automatically filters to primary organization and returns only
approved and active training classes.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| id | path | True | string |  |

## GET /api/v1/public/announcements

**Summary**: Get Announcements

Get list of public active announcements from primary organization.

Returns only active announcements.
No authentication required.
RLS automatically filters to primary organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| search | query | False |  | Search by title or content |

## GET /api/v1/public/announcements/{announcement_id}

**Summary**: Get Announcement

Get public announcement by ID from primary organization.

Returns active announcements only.
No authentication required.
RLS automatically filters to primary organization.

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| announcement_id | path | True | string |  |

## GET /api/v1/public/banners

**Summary**: List Banners

Get list of banners for public display (unauthenticated).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| skip | query | False | integer |  |
| limit | query | False | integer |  |
| platform | query | False |  | Filter by platform |

## GET /api/v1/public/banners/{banner_id}

**Summary**: Get Banner

Get banner by ID for public display (unauthenticated).

### Parameters
| Name | In | Required | Type | Description |
| --- | --- | --- | --- | --- |
| banner_id | path | True | string |  |

## GET /api/v1/public/resource-types/tree

**Summary**: Get Resource Type Tree Public

Get all resource types as a tree structure for public display (unauthenticated).

## GET /api/v1/public/resource-types/tree-with-counts

**Summary**: Get Resource Type Tree With Counts Public

Get all resource types as a tree structure with counts for public display (unauthenticated).

