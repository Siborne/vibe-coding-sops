# Code Change Log Rule

**Rule:** After every code change via Edit or Write, you MUST create a structured change log in `docs/变更记录/`.

## File Naming

`<brief-description>_<YYYY-MM-DD>.md`, e.g. `fix-pjax-loading-spinner_2026-05-11.md`

## Required Sections

### Basic Info
- **Timestamp**
- **Files modified**: list all file paths touched

### Root Cause Analysis
- What was the symptom?
- Why did it happen (technical root cause)?

### Change Details
For each changed location:
- File path + line range
- **BEFORE** and **AFTER** code comparison
- What this change fixes and why

### Solution
- Summary of the fix approach

## Code Diff Format

    ### File: layouts/partials/footer/custom.html (L10-L15)

    **BEFORE:**
    ```js
    // old code
    ```

    **AFTER:**
    ```js
    // new code
    ```

    > Why this change was made and what it accomplishes

## Scope

All code modifications via Edit or Write tools.
