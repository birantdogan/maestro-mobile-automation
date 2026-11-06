# Maestro Mobile Test Automation

[![Maestro Android CI](https://github.com/birantdogan/maestro-mobile-automation/actions/workflows/maestro-android.yml/badge.svg)](https://github.com/birantdogan/maestro-mobile-automation/actions/workflows/maestro-android.yml)

A mobile end-to-end (E2E) test automation portfolio project built with **Maestro**, using YAML-based test flows to validate Android application functionality.

The project focuses on mobile UI automation, navigation testing, functional validation, state verification, and Continuous Integration (CI).

The automated test suite targets the native Android Settings application (`com.android.settings`) and includes **10 independent test flows**.

## Tech Stack

| Technology | Purpose |
|---|---|
| Maestro | Mobile UI test automation framework |
| YAML | Test flow definitions |
| Android Emulator | Test execution environment |
| ADB | Android Debug Bridge |
| Java 17 | Runtime environment |
| WSL2 / Ubuntu | Local automation environment |
| PowerShell | Windows environment startup automation |
| GitHub Actions | Continuous Integration |
| Git & GitHub | Version control |

## Test Coverage

The project includes 10 automated test flows covering different Android Settings functionalities.

| Test Flow | Description |
|---|---|
| `settings-smoke.yaml` | Application launch and basic smoke validation |
| `settings-network-navigation.yaml` | Network settings navigation |
| `settings-wifi-validation.yaml` | Wi-Fi settings validation |
| `settings-dark-theme.yaml` | Dark theme functionality |
| `settings-battery-validation.yaml` | Battery settings validation |
| `settings-storage-validation.yaml` | Storage categories and UI validation |
| `settings-display-navigation.yaml` | Display settings navigation |
| `settings-sound-validation.yaml` | Sound settings validation |
| `settings-airplane-mode-toggle.yaml` | Airplane mode toggle behavior |
| `settings-security-validation.yaml` | Security settings validation |

### Testing Approach

- **Smoke Testing:** Verify basic application accessibility.
- **Navigation Testing:** Validate navigation between Android Settings screens.
- **Functional Testing:** Verify expected application behavior.
- **UI Validation:** Assert the visibility of expected interface elements.
- **State Verification:** Validate UI states and toggle behavior.
- **Independent Test Execution:** Execute individual scenarios or the complete suite.

All test flows are organized as separate YAML files under the `.maestro/` directory.

## Project Structure

```text
maestro-mobile-automation/
├── .github/
│   └── workflows/
│       └── maestro-android.yml
├── .maestro/
│   ├── settings-smoke.yaml
│   ├── settings-network-navigation.yaml
│   ├── settings-wifi-validation.yaml
│   ├── settings-dark-theme.yaml
│   ├── settings-battery-validation.yaml
│   ├── settings-storage-validation.yaml
│   ├── settings-display-navigation.yaml
│   ├── settings-sound-validation.yaml
│   ├── settings-airplane-mode-toggle.yaml
│   └── settings-security-validation.yaml
├── reports/
│   └── report.html
├── scripts/
│   └── start-android.ps1
├── .gitignore
└── README.md
```

## Prerequisites

The following tools are required for local test execution:

- Maestro CLI
- Android Studio and Android SDK
- Android Emulator or compatible Android device
- Android Debug Bridge (ADB)
- Java 17
- WSL2 with Ubuntu (for the documented Windows setup)

The project was developed using Windows 11, WSL2 Ubuntu, and an Android emulator running on Windows.

## Running Tests Locally

### 1. Start the Android Emulator

Launch an Android emulator using Android Studio Device Manager.

The local development environment uses Android API 37.0.

### 2. Verify ADB Connectivity

Check the connected Android devices:

```bash
adb devices -l
```

Expected output:

```text
List of devices attached
emulator-5554    device
```

### 3. Configure WSL2 Connectivity

When Maestro runs inside WSL2 and the Android emulator runs on Windows, WSL must communicate with the Windows ADB server.

The documented setup uses WSL2 mirrored networking.

Windows `.wslconfig`:

```ini
[wsl2]
networkingMode=mirrored
```

Restart WSL after changing this configuration:

```powershell
wsl --shutdown
```

Ensure that the Windows ADB server is running and the Android emulator is connected.

Verify connectivity from the WSL Ubuntu terminal:

```bash
ADB_SERVER_SOCKET=tcp:127.0.0.1:5037 adb devices -l
```

### 4. Run All Tests

Execute the complete test suite:

```bash
ADB_SERVER_SOCKET=tcp:127.0.0.1:5037 maestro --device emulator-5554 test .maestro/
```

### 5. Run an Individual Test

For example, execute the Storage validation flow:

```bash
ADB_SERVER_SOCKET=tcp:127.0.0.1:5037 maestro --device emulator-5554 test .maestro/settings-storage-validation.yaml
```

Replace the YAML filename to execute a different test flow.

**Note:** The `ADB_SERVER_SOCKET` configuration is specific to the documented Windows + WSL2 environment. Other environments may use standard Maestro commands.

## Continuous Integration (CI/CD)

The project uses **GitHub Actions** to automatically execute the Maestro test suite on an Android emulator.

The workflow is defined in `.github/workflows/maestro-android.yml`.

### CI Environment

| Configuration | Value |
|---|---|
| CI Platform | GitHub Actions |
| Runner | Ubuntu |
| Java | 17 |
| Android API | 37.0 |
| System Image | Google APIs Play Store |
| Architecture | x86_64 |
| Emulator Profile | Pixel 6 |
| Automation Framework | Maestro |

### CI Workflow

The workflow performs the following operations:

1. Checks out the repository.
2. Configures Java and the Android SDK.
3. Installs Maestro CLI.
4. Creates and starts an Android emulator.
5. Executes all Maestro test flows.
6. Generates a detailed HTML test report.
7. Uploads available test reports and debugging artifacts.

The workflow runs on pushes and pull requests targeting the `main` branch.

### CI Test Execution

```bash
maestro test --format HTML-DETAILED --output report.html .maestro/
```

## Test Results & Reporting

### Successful Test Execution

The complete suite of **10 automated test flows** successfully passed in GitHub Actions.

**[View HTML Test Report](reports/report.html)**

**[View GitHub Actions Test Runs](https://github.com/birantdogan/maestro-mobile-automation/actions)**

The HTML report provides detailed execution results for the automated test scenarios.

GitHub displays HTML files as repository content rather than running them as interactive web pages. To view the full report, download `report.html` and open it in a browser.

### Failure Analysis

When test execution fails, available Maestro debugging artifacts can be uploaded through GitHub Actions.

These artifacts support investigation of:

- Failed assertions
- Unexpected UI behavior
- Element visibility issues
- Emulator and ADB connectivity problems
- Differences between local and CI environments

## Key Features

- 10 independent Android UI automation flows
- YAML-based test automation with Maestro
- Native Android Settings application testing
- Functional, navigation, and UI state validation
- Android emulator execution
- Windows and WSL2 development environment
- Automated CI execution with GitHub Actions
- Detailed HTML test reporting
- Failure debugging and artifact collection
- Git-based feature development and pull request workflow

## Future Improvements

- Expand functional and negative test coverage
- Introduce additional Android device configurations
- Improve automated reporting and failure analysis
- Explore iOS test execution
- Evaluate cross-platform test coverage
- Extend automation to additional mobile applications

## About

This project demonstrates practical experience with **mobile test automation, Android UI testing, test scenario design, CI/CD integration, and automation environment configuration**.

It focuses on building a maintainable test suite while addressing real-world challenges such as Android emulator configuration, ADB connectivity, and CI execution reliability.

The repository serves as a practical mobile automation portfolio project and a foundation for future improvements.