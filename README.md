# Maestro Mobile Test Automation

A mobile end-to-end (E2E) test automation portfolio project built with **Maestro**, using YAML-based test flows to validate Android application behavior.

The project focuses on mobile UI automation, navigation testing, functional validation, state verification, and Continuous Integration (CI).

## Tech Stack

- **Maestro** — Mobile UI test automation framework
- **YAML** — Test flow definitions
- **Android Emulator** — Test execution environment
- **ADB** — Android Debug Bridge
- **GitHub Actions** — Continuous Integration
- **Git & GitHub** — Version control

## Test Coverage

The automated test suite covers different aspects of Android application functionality, including:

- Smoke testing
- UI navigation and interaction
- Functional validation
- Network and connectivity settings
- UI state and toggle verification

Test scenarios are organized as independent YAML flows under the `.maestro/` directory, allowing new tests to be added without changing the overall project structure.

## Project Structure

```text
maestro-mobile-automation/
├── .github/
│   └── workflows/
├── .maestro/
│   └── *.yaml
├── scripts/
├── .gitignore
└── README.md
```

## Prerequisites

- Maestro CLI
- Android SDK and ADB
- Android emulator or compatible Android device
- Java 17

## Running Tests Locally

Start an Android emulator and verify that it is connected:

```bash
adb devices
```

Run all test flows:

```bash
maestro test .maestro/
```

Run an individual test flow:

```bash
maestro test .maestro/<flow-name>.yaml
```

When using WSL with an Android emulator running on Windows, additional ADB connectivity configuration may be required.

## Continuous Integration

GitHub Actions automatically executes the Maestro test suite on an Android emulator.

The CI workflow handles:

1. Repository checkout
2. Android emulator configuration and KVM acceleration
3. Java and Maestro CLI setup
4. Automated test execution
5. Debug artifact collection on failure

The workflow runs on pushes and pull requests targeting the `main` branch.

## Test Results & Reporting

Test execution results are available through GitHub Actions.

**[View GitHub Actions Test Runs](https://github.com/birantdogan/maestro-mobile-automation/actions)**

Debug artifacts are automatically uploaded when a CI test execution fails, supporting troubleshooting and failure analysis.

## Future Improvements

- Expand mobile test coverage
- Improve automated test reporting
- Explore cross-platform test execution

## About

This project demonstrates practical experience with mobile test automation, maintainable YAML-based test flows, Android emulator testing, and CI integration.

The project is designed to evolve as new scenarios and automation capabilities are introduced.