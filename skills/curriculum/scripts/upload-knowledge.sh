#!/bin/bash
# upload-knowledge.sh - Upload a PDF file to the knowledge base

set -e

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 /path/to/document.pdf [title]"
    exit 1
fi

FILE_PATH=$1
TITLE=${2:-""}

# Load access token
if [ -z "$CURRICULUM_ACCESS_TOKEN" ]; then
  echo "❌ Error: CURRICULUM_ACCESS_TOKEN not set"
  exit 1
fi

BASE_URL="https://edu-staging.njyaoduo.com/api/v1"

echo "📤 Uploading document to knowledge base..."
echo "📍 File: $FILE_PATH"

# Send upload request
UPLOAD_RESPONSE=$(curl -s -X POST "${BASE_URL}/documents/" \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN" \
  -H "Content-Type: multipart/form-data" \
  -F "file=@$FILE_PATH" \
  -F "title=$TITLE")

# Extract info from response
STATUS=$(echo "$UPLOAD_RESPONSE" | jq -r '.status')
if [ "$STATUS" = "processing" ]; then
  DOC_ID=$(echo "$UPLOAD_RESPONSE" | jq -r '.document_id')
  echo "✅ Upload Successful! ID: $DOC_ID"
  echo "📄 Message: $(echo "$UPLOAD_RESPONSE" | jq -r '.message')"
  echo "💡 AI processing has been scheduled in the background."
  echo "🔍 Track state at: ${BASE_URL}/documents/${DOC_ID}/state"
else
  echo "❌ Upload Failed!"
  echo "Response: $UPLOAD_RESPONSE"
  exit 1
fi
