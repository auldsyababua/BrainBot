# Project Structure Update - Handoff Document

## Summary

The Markdown Brain Bot project has been reorganized into a more maintainable structure with clear separation of concerns. All import statements have been updated to use absolute imports from the `src` package.

## Changes Made

### 1. Directory Structure Reorganization

The project has been reorganized from a flat structure to a hierarchical one:

**Old Structure:**
```
markdown-brain-bot/
   main_polling.py
   main_webhook.py
   llm.py
   tools.py
   config.py
   vector_store.py
   redis_store.py
   storage_service.py
   media_storage.py
   migrate_to_vector.py
   diagnose_vector.py
   tests/
```

**New Structure:**
```
markdown-brain-bot/
   main.py                     # Main entry point
   src/                        # Source code
      bot/                    # Bot-specific code
         main_polling.py
         main_webhook.py
         set_webhook.py
      storage/                # Storage services
         storage_service.py
         media_storage.py
         redis_store.py
         vector_store.py
      core/                   # Core functionality
         config.py
         tools.py
         llm.py
         chunking.py
         version.py
      migrations/             # Data migration scripts
          migrate_to_vector.py
          add_to_vector.py
   scripts/                    # Utility scripts
      diagnostics/
      deployment/
      database/
   tests/                      # All tests
      integration/
      unit/
      scratch/
   docs/                       # Documentation
```

### 2. Import Updates

All imports have been updated to use absolute imports from the `src` package:

**Examples:**
- `from config import TELEGRAM_BOT_TOKEN` � `from src.core.config import TELEGRAM_BOT_TOKEN`
- `from llm import process_message` � `from src.core.llm import process_message`
- `from vector_store import vector_store` � `from src.storage.vector_store import vector_store`

### 3. Files Updated

The following files had their imports updated:

**Bot Module:**
- `src/bot/main_polling.py`
- `src/bot/main_webhook.py`
- `src/bot/set_webhook.py`

**Core Module:**
- `src/core/llm.py`
- `src/core/tools.py`

**Storage Module:**
- `src/storage/media_storage.py`

**Migration Scripts:**
- `src/migrations/migrate_to_vector.py`
- `src/migrations/add_to_vector.py`

**Test Files:**
- All test files in `tests/integration/`
- All test files in `tests/unit/`
- All test files in `tests/scratch/`

### 4. Entry Point

The `main.py` file at the root serves as the entry point and runs the polling bot by default. It properly sets up the Python path and executes the bot from the new structure.

## Benefits

1. **Clear Separation of Concerns**: Each module has a specific purpose
2. **Easier Navigation**: Related code is grouped together
3. **Better Testing**: Tests are organized by type (unit, integration, scratch)
4. **Cleaner Imports**: Absolute imports make dependencies clear
5. **Scalability**: Easy to add new modules without cluttering the root
6. **Documentation**: Dedicated docs folder for all documentation

## Running the Bot

After these changes, the bot can be run using:

```bash
# From the root directory
python main.py

# Or directly
python src/bot/main_polling.py
```

## Next Steps

1. Update any deployment scripts to use the new paths
2. Ensure all team members pull the latest changes
3. Update any CI/CD pipelines if needed
4. Consider adding `__init__.py` files with proper exports for cleaner imports

## Notes

- The `notes/` and `logs/` directories remain unchanged
- All functionality remains the same; only the structure has changed
- No changes to environment variables or configuration needed