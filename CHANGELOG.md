# 📜 CHANGELOG

All notable changes to this project will be documented in this file.

---

## [1.1.3] - 2025-07-08
### Changed
- Changed `VStack` alignment for output sections from `.leading` to `.center` to center-align the Copy buttons and confirmation messages.
- Improved visual balance for output actions.
- Returned divider padding back to a lower value because OCD!

## [1.1.2] - 2025-07-08
### Changed
- Refactored ContentView to use reusable `InputEditor` and `OutputEditor` components.
- Removed duplicated layout code for input/output sections.
- Improved maintainability and readability of the SwiftUI view.

## [1.1.1] - 2025-07-08
### Fixed
- Moved "Copy" buttons to sit directly under the decoded and encoded output sections instead of below the inputs.
- Corrected copy confirmation messages to display under the appropriate output boxes.
- Updated copy logic to ensure correct text is copied for each side.
- Minor layout tweaks for clearer separation between input, output, and actions.

## [1.1.0] - 2025-07-08
### Update
- Split input into two sections: Base64 input (decodes to plain text) and Plain Text input (encodes to Base64).
- Realtime two-way conversion.
- Separate decoded and encoded output areas.
- Copy buttons for both Base64 and encoded output.
- Clear buttons for both input sections.
- Placeholders in both input editors.
- Improved text spacing and layout.

## [1.0.1] - 2025-07-08
### Update
- "Copy Decoded Text" button with confirmation message.
- Text clipping fixed with proper padding.

## [1.0.0] - 2025-07-08
### Initial release
