#!/bin/bash
# knowledge-status.sh - Check all documents in the knowledge base

set -e

# Load access token if set
if [ -z "$CURRICULUM_ACCESS_TOKEN" ]; then
  echo "❌ Error: CURRICULUM_ACCESS_TOKEN not set"
  echo "Please export CURRICULUM_ACCESS_TOKEN first."
  exit 1
fi

BASE_URL="https://edu-staging.njyaoduo.com/api/v1"

echo "📚 Curriculum Knowledge Base Status"
echo "=================================="

# Get doc list
DOCS_RESPONSE=$(curl -s -X GET "${BASE_URL}/documents/" \
  -H "Authorization: Bearer $CURRICULUM_ACCESS_TOKEN")

# Check if response was valid JSON and had data
if ! echo "$DOCS_RESPONSE" | jq -e '.data' > /dev/null; then
  echo "❌ Failed to fetch documents. Response: $(echo "$DOCS_RESPONSE" | jq -r '.error // "Unknown error"')"
  exit 1
fi

DOC_COUNT=$(echo "$DOCS_RESPONSE" | jq -r '.data | length')
echo "Found $DOC_COUNT documents."

echo "$DOCS_RESPONSE" | jq -r '.data[] | "📍 ID: \(.document_id)\n   Name: \(.original_name)\n   Size: \(.file_size) bytes\n   Uploaded: \(.upload_time)\n"'

echo ""
echo "=================================="
echo "📁 Total Total Knowledge Items: $DOC_COUNT"
