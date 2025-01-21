#!/bin/bash

# Validate inputs
if [ "$#" -lt 2 ]; then
    echo "Usage: ./run_semgrep.sh <file_path> <language>"
    exit 1
fi

FILE_PATH=$1
LANGUAGE=$2
OUTPUT_FILE="semgrep_results.csv"

# Supported languages
SUPPORTED_LANGUAGES=("c" "csharp" "go" "java" "javascript" "python")

# Check if the provided language is supported
if [[ ! " ${SUPPORTED_LANGUAGES[@]} " =~ " ${LANGUAGE} " ]]; then
    echo "Error: Unsupported language. Supported languages are: ${SUPPORTED_LANGUAGES[*]}"
    exit 1
fi

# Run Semgrep with custom rules
semgrep --config=/app/rules --lang="$LANGUAGE" --output="$OUTPUT_FILE" --json "$FILE_PATH"

# Notify the user
echo "Scan complete. Results saved in $OUTPUT_FILE"
