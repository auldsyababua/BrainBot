# Test Documents - Do Not Modify

This directory contains documents that are specifically required by the test suite. These documents should not be modified as they are used to verify that the retrieval and search functionality works correctly.

## Test Documents

- **about-10netzero-test.md** - Basic company overview document for testing search functionality
- **eagle-lake-todo-list.md** - Site-specific todo list for testing site-related queries
- **project-deadline-code-review.md** - Project documentation for testing deadline and review queries

## Purpose

These documents are loaded into the t=0 state of both the Vector store and Supabase database by the `reset_databases.py` script. They ensure that tests have consistent, known documents to query against.

## Important Notes

- **DO NOT MODIFY** these documents without updating corresponding tests
- These are separate from the production knowledge base documents
- Changes to these files may cause test failures
- If you need to add new test documents, coordinate with the test suite