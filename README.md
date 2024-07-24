# flutter_browser

A Flutter package for creating a powerful, sandboxed browser environment directly within your Flutter applications.

## Why flutter_browser?

* **Beyond WebViews:**  Replace standard WebViews with a more flexible and controllable browser solution.
* **DOM Manipulation:**  Gain direct access to the DOM for advanced interactions, such as modifying HttpOnly cookies or web scraping.
* **Lightweight Web Builds:**  Web versions leverage the client's browser resources, keeping your application and package lean.
* **Future-Proofing:**  Designed with cross-platform compatibility in mind.

## Project Structure

The `flutter_browser` package is organized into the following modules:

* **`browser`:**
  * **`browser.dart`:** The main browser widget responsible for rendering web pages and providing a user interface.
  * **`browser_controller.dart`:**  Handles communication between the `Browser` widget and other components of the browser.
  * **`components`:** Contains sub-components for the browser:
    * **`navigation.dart`:** Manages navigation actions (back, forward, reload).
    * **`tabs.dart`:**  Provides UI and logic for managing multiple tabs within a browser instance (optional).
  * **`renderer`:**
    * **`index.dart`:** Exports the renderer classes.
    * **`web_renderer.dart`:**  The core web rendering component (implementation to be determined, potentially CEF or WebAssembly + Blink).
  * **`storage`:**
    * **`index.dart`:** Exports the storage classes.
    * **`cookies.dart`:** Handles browser cookies.
    * **`local_storage.dart`:** Manages local storage data.
    * **`session_storage.dart`:** Handles session storage data.

* **`utils`:**
  * **`index.dart`:** Exports utility functions used throughout the package.

* **`main.dart`:** The entry point for the example application demonstrating the use of the `flutter_browser` package.

## Current Status

This package is in its early stages and currently focuses on establishing a robust web build foundation.

**Key Milestones:**

* **Web Builds:**
  * Chromium compatibility
  * Safari compatibility
  * Firefox compatibility
* **Desktop Builds:**
  * Windows (Chromium)
  * macOS (Chromium, Safari)
* **Mobile Builds:**
  * Android (Chromium)
  * iOS (Chromium, Safari)

## Getting Started

1. **Add Dependency:**
   ```yaml
   dependencies:
     flutter_browser: ^0.0.1  # Replace with the latest version
