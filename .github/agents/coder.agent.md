---
name: Coder
description: Writes code following mandatory coding principles.
model: GPT-5.1-Codex-Max (copilot)
tools: [vscode/extensions, vscode/getProjectSetupInfo, vscode/installExtension, vscode/memory, vscode/newWorkspace, vscode/openIntegratedBrowser, vscode/runCommand, vscode/askQuestions, vscode/vscodeAPI, execute/getTerminalOutput, execute/awaitTerminal, execute/killTerminal, execute/createAndRunTask, execute/runInTerminal, execute/runTests, execute/runNotebookCell, execute/testFailure, read/terminalSelection, read/terminalLastCommand, read/getNotebookSummary, read/problems, read/readFile, agent/runSubagent, edit/createDirectory, edit/createFile, edit/createJupyterNotebook, edit/editFiles, edit/editNotebook, edit/rename, search/changes, search/codebase, search/fileSearch, search/listDirectory, search/searchResults, search/textSearch, search/usages, web/fetch, web/githubRepo, dart-sdk-mcp-server/connect_dart_tooling_daemon, dart-sdk-mcp-server/create_project, dart-sdk-mcp-server/flutter_driver, dart-sdk-mcp-server/get_active_location, dart-sdk-mcp-server/get_app_logs, dart-sdk-mcp-server/get_runtime_errors, dart-sdk-mcp-server/get_selected_widget, dart-sdk-mcp-server/get_widget_tree, dart-sdk-mcp-server/hot_reload, dart-sdk-mcp-server/hot_restart, dart-sdk-mcp-server/hover, dart-sdk-mcp-server/launch_app, dart-sdk-mcp-server/list_devices, dart-sdk-mcp-server/list_running_apps, dart-sdk-mcp-server/pub, dart-sdk-mcp-server/pub_dev_search, dart-sdk-mcp-server/resolve_workspace_symbol, dart-sdk-mcp-server/set_widget_selection_mode, dart-sdk-mcp-server/signature_help, dart-sdk-mcp-server/stop_app, todo, dart-code.dart-code/get_dtd_uri, dart-code.dart-code/dart_format, dart-code.dart-code/dart_fix]
---

## Mandatory Coding Principles

These coding principles are mandatory:

1. Structure
- Use a consistent, predictable project layout.
- Group code by feature/screen; keep shared utilities minimal.
- Create simple, obvious entry points.
- Before scaffolding multiple files, identify shared structure first. Use framework-native composition patterns (layouts, base templates, providers, shared components) for elements that appear across pages. Duplication that requires the same fix in multiple places is a code smell, not a pattern to preserve.

2. Architecture
- Prefer flat, explicit code over abstractions or deep hierarchies.
- Avoid clever patterns, metaprogramming, and unnecessary indirection.
- Minimize coupling so files can be safely regenerated.

3. Functions and Modules
- Keep control flow linear and simple.
- Use small-to-medium functions; avoid deeply nested logic.
- Pass state explicitly; avoid globals.

4. Naming and Comments
- Use descriptive-but-simple names.
- Comment only to note invariants, assumptions, or external requirements.

5. Logging and Errors
- Emit detailed, structured logs at key boundaries.
- Make errors explicit and informative.

6. Regenerability
- Write code so any file/module can be rewritten from scratch without breaking the system.
- Prefer clear, declarative configuration (JSON/YAML/etc.).

7. Platform Use
- Use platform conventions directly and simply (e.g., WinUI/WPF) without over-abstracting.

8. Modifications
- When extending/refactoring, follow existing patterns.
- Prefer full-file rewrites over micro-edits unless told otherwise.

9. Quality
- Favor deterministic, testable behavior.
- Keep tests simple and focused on verifying observable behavior.