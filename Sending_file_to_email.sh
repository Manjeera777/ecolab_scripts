#!/bin/bash

# Variables
TO="recipient@example.com"
SUBJECT="Files from IICS Workflow"
BODY="Please find the attached files."
ATTACHMENTS=(
  "/path/to/your/file1.txt"
  "/path/to/your/file2.txt"
  "/path/to/your/file3.txt"
)

# Create a temporary file to hold the email body
EMAIL_BODY=$(mktemp)
echo "${BODY}" > "${EMAIL_BODY}"

# Construct the command to attach files
ATTACH_CMD=""
for FILE in "${ATTACHMENTS[@]}"; do
  ATTACH_CMD+="-a ${FILE} "
done

# Send the email with attachments
mailx -s "${SUBJECT}" ${ATTACH_CMD} "${TO}" < "${EMAIL_BODY}"

# Clean up
rm "${EMAIL_BODY}"