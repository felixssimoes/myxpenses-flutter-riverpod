---
name: Coder
description: Writes Flutter/Dart code following mandatory coding principles and project architecture.
model: GPT-5.1-Codex-Max (copilot)
tools: [vscode/extensions, vscode/getProjectSetupInfo, vscode/installExtension, vscode/memory, vscode/newWorkspace, vscode/openIntegratedBrowser, vscode/runCommand, vscode/askQuestions, vscode/vscodeAPI, execute/getTerminalOutput, execute/awaitTerminal, execute/killTerminal, execute/createAndRunTask, execute/runInTerminal, execute/runTests, execute/runNotebookCell, execute/testFailure, read/terminalSelection, read/terminalLastCommand, read/getNotebookSummary, read/problems, read/readFile, agent/runSubagent, edit/createDirectory, edit/createFile, edit/createJupyterNotebook, edit/editFiles, edit/editNotebook, edit/rename, search/changes, search/codebase, search/fileSearch, search/listDirectory, search/searchResults, search/textSearch, search/usages, web/fetch, web/githubRepo, dart-sdk-mcp-server/connect_dart_tooling_daemon, dart-sdk-mcp-server/create_project, dart-sdk-mcp-server/flutter_driver, dart-sdk-mcp-server/get_active_location, dart-sdk-mcp-server/get_app_logs, dart-sdk-mcp-server/get_runtime_errors, dart-sdk-mcp-server/get_selected_widget, dart-sdk-mcp-server/get_widget_tree, dart-sdk-mcp-server/hot_reload, dart-sdk-mcp-server/hot_restart, dart-sdk-mcp-server/hover, dart-sdk-mcp-server/launch_app, dart-sdk-mcp-server/list_devices, dart-sdk-mcp-server/list_running_apps, dart-sdk-mcp-server/pub, dart-sdk-mcp-server/pub_dev_search, dart-sdk-mcp-server/resolve_workspace_symbol, dart-sdk-mcp-server/set_widget_selection_mode, dart-sdk-mcp-server/signature_help, dart-sdk-mcp-server/stop_app, todo, dart-code.dart-code/get_dtd_uri, dart-code.dart-code/dart_format, dart-code.dart-code/dart_fix]
---

## Mandatory Coding Principles

These coding principles are mandatory for all Flutter/Dart development:

### 1. Project Structure & Architecture
- **Feature-based organization**: Group by feature (accounts/, expenses/, etc.) with domain/data/application/presentation layers per feature
- **Follow the established architecture**: Always consult `.github/copilot-instructions.md` for project-specific patterns
- **Shared utilities**: Keep cross-cutting concerns in `core/` (navigation, database, exceptions, utils)
- **Clear entry points**: Entry in `main.dart` → app setup → feature modules
- **Identify shared patterns**: Before creating duplicate files, check if common elements can be abstracted (layouts, base widgets, providers, shared components)

### 2. Flutter-Specific Patterns
- **Widget composition**: Prefer composing small, focused widgets over large monolithic widgets
- **Const constructors**: Use `const` wherever possible for better performance
- **BuildContext usage**: Never store BuildContext in fields; pass it as needed
- **Keys**: Use keys for widgets in lists or when preserving state is critical
- **Avoid deep nesting**: Extract complex widget subtrees into separate widgets
- **Stateless preferred**: Use StatelessWidget with Riverpod providers instead of StatefulWidget when possible

### 3. Dart Language Best Practices
- **Null safety**: Leverage Dart's null safety; avoid `!` operator unless absolutely certain
- **Immutability**: Prefer `final` for variables, use `@immutable` or Freezed for data classes
- **Named parameters**: Use named parameters for clarity, especially in widgets
- **Async/await**: Handle async operations properly with FutureBuilder, AsyncValue, or stream builders
- **Type inference**: Let Dart infer types when obvious, but be explicit when it aids clarity

### 4. Riverpod State Management (Project-Specific)
- **Code generation**: Always use `@riverpod` annotations with `part` directives
- **Auto-dispose by default**: Only use `@Riverpod(keepAlive: true)` for singletons (database, navigator)
- **Services for mutations**: Encapsulate create/update/delete in service classes that invalidate dependent providers
- **Targeted invalidation**: After mutations, invalidate only affected providers (see AccountsService/ExpensesService patterns)
- **View providers for aggregation**: Create separate view providers for computed/aggregated data (e.g., accountsViewProvider)

### 5. Database & Persistence (Drift)
- **Repository pattern**: Abstract database access behind repository interfaces
- **Migrations**: Bump schema version and add migration functions for structural changes
- **Transactions**: Wrap multi-statement operations in transactions
- **Error handling**: Convert SqliteException to domain exceptions with user-friendly messages
- **Batch operations**: Use batch queries (loadAllAccountTotals) to prevent N+1 problems

### 6. Functions and Control Flow
- **Keep functions small**: Each function should do one thing well
- **Linear control flow**: Avoid deeply nested conditionals; use early returns
- **Pass state explicitly**: No global mutable state; pass dependencies through providers
- **Guard clauses**: Use early returns to handle edge cases first

### 7. Naming and Comments
- **Descriptive names**: Use clear, intention-revealing names (accountsViewProvider, not avp)
- **Dart conventions**: lowerCamelCase for variables/functions, UpperCamelCase for classes
- **Minimal comments**: Code should be self-documenting; comment only for non-obvious invariants or business rules
- **Provider naming**: Follow pattern `<entity>Provider`, `<entity>sProvider`, `<entity>ViewProvider`, `<entity>Service`

### 8. Error Handling & Logging
- **Domain exceptions**: Define specific exception types in `core/exceptions/` with code and message
- **AsyncValue**: Leverage Riverpod's AsyncValue for loading/error states in UI
- **Structured logging**: Use `debugLog` and `debugLogError` from `core/utils/log.util.dart`
- **User-facing errors**: Always provide actionable error messages for users

### 9. Testing
- **Robot pattern**: Use test robots (test/robot.dart) for widget tests
- **Mock dependencies**: Mock repositories and services using Mockito
- **Provider overrides**: Override providers in tests for controlled test environments
- **Test behavior**: Focus on testing observable behavior, not implementation details

### 10. Code Quality & Maintainability
- **Regenerability**: Write code so any file can be rewritten without breaking the system
- **Follow existing patterns**: When extending features, mirror the structure of similar features
- **Prefer full-file edits**: When refactoring, prefer rewriting entire files for consistency
- **Deterministic behavior**: Avoid side effects; make functions pure when possible
- **Type safety**: Leverage Dart's type system; avoid `dynamic` unless necessary

### 11. Navigation & Routing
- **Centralized routing**: Use `appRouterProvider` methods, not direct GoRouter.of(context) calls
- **Route definitions**: Define routes in `core/presentation/navigation/app_router.dart`
- **Type-safe navigation**: Pass parameters through strongly-typed route constructors

### 12. Performance Considerations
- **Lazy loading**: Use ListView.builder for long lists, not ListView
- **Rebuild optimization**: Use const constructors, select(), and watch() selectively
- **Avoid rebuilds**: Don't watch providers unnecessarily; read when you only need one-time values
- **Image optimization**: Use appropriate image formats and caching strategies

### 13. Platform Integration
- **Platform-aware UI**: Use Platform.is... checks when necessary for platform-specific behavior
- **Native conventions**: Follow Material Design on Android, Cupertino on iOS (when appropriate)
- **Configuration**: Use flutter build runner for code generation: `flutter pub run build_runner watch --delete-conflicting-outputs`

### 14. Git Practices
- **Meaningful commits**: Start with a clear summary, add details in subsequent lines if needed
- **Atomic commits**: Each commit should represent a single logical change

## When You're Unsure
1. **Check copilot-instructions.md** for project-specific patterns
2. **Mirror existing features**: Look at accounts/ or expenses/ for reference implementations
3. **Search the codebase**: Find similar providers or services before creating new patterns
4. **Consult documentation**: Use web fetch for pub.dev, docs.flutter.dev, or riverpod.dev

## Red Flags to Avoid
- ❌ Computing totals in loops instead of using batch queries
- ❌ Direct navigation with GoRouter.of(context) in business logic
- ❌ Using `keepAlive: true` without justification
- ❌ Not handling null dateIntervalProvider in dependent providers
- ❌ Broad `ref.invalidateAll()` instead of targeted invalidation
- ❌ StatefulWidget when Riverpod providers suffice
- ❌ Storing BuildContext in fields or global variables