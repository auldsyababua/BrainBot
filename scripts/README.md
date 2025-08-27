# BrainBot Scripts Directory

This directory contains **production-ready** scripts that are actively used in the BrainBot project workflow.

## Directory Structure

```
scripts/
├── database/          # Database management and migration scripts
├── deployment/        # Production deployment and monitoring scripts  
├── development/       # Development tools and utilities
├── diagnostics/       # System diagnostics and debugging tools
├── maintenance/       # Regular maintenance scripts
└── ARCHIVE - DEPRACATED - DO NOT OPEN OR REFERENCE/  # Archived/deprecated scripts
```

## Active Scripts

### Production Scripts
- `start-production.sh` - Main production startup script
- `validate_config.py` - Configuration validation utility
- `load_test_small_team.py` - Performance testing script

### Database Scripts (`database/`)
- Database setup and management utilities
- Schema migration tools
- Query optimization scripts

### Deployment Scripts (`deployment/`)
- CI/CD pipeline scripts
- Webhook configuration
- Service monitoring tools

### Development Scripts (`development/`)  
- Local development utilities
- Testing helpers
- Code analysis tools

### Diagnostic Scripts (`diagnostics/`)
- System health checks
- Debug utilities
- Performance profiling

## Archived Scripts

One-off migration scripts and temporary fixes have been moved to:
`ARCHIVE - DEPRACATED - DO NOT OPEN OR REFERENCE/`

**DO NOT** use or reference scripts in the archive directory. They are kept only for historical reference.

## Script Usage Guidelines

1. All scripts in this directory (except archive) should be:
   - Reusable
   - Well-documented
   - Part of regular workflows

2. Temporary/one-off scripts should be:
   - Created in project root or `/tmp` during development
   - Moved to archive after use
   - Never committed to main scripts directory

3. New scripts must include:
   - Clear purpose documentation
   - Usage examples
   - Dependencies/requirements