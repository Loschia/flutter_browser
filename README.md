# flutter_browser

A Flutter package for creating a powerful, sandboxed browser environment directly within your Flutter applications.

## Why flutter_browser?

* **Beyond WebViews:**  Replace standard WebViews with a more flexible and controllable browser solution.
* **DOM Manipulation:**  Gain direct access to the DOM for advanced interactions, such as modifying HttpOnly cookies or web scraping.
* **Lightweight Web Builds:**  Web versions leverage the client's browser resources, keeping your application and package lean.
* **Future-Proofing:**  Designed with cross-platform compatibility in mind.

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