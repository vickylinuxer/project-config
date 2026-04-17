# project-config

YAML pipeline configurations for embedded CI/CD subsystems. Used by **generic-cicd** shared library.

## Structure

```
project-config/
├── projects/                           # Active pipeline configs
│   ├── integration.yml                 #   CI integration build
│   ├── integration-nightly.yml         #   Nightly integration build
│   ├── integration-release.yml         #   Release integration build
│   ├── custom-firmware.yml             #   CMake cross-compilation (ci)
│   ├── custom-firmware-nightly.yml     #   CMake cross-compilation (nightly)
│   ├── custom-firmware-release.yml     #   CMake cross-compilation (release)
│   ├── yocto-bsp.yml                   #   Yocto BitBake RPi4 BSP (ci)
│   ├── yocto-bsp-nightly.yml           #   Yocto BitBake RPi4 BSP (nightly)
│   ├── yocto-bsp-release.yml           #   Yocto BitBake RPi4 BSP (release)
│   ├── aosp-platform.yml               #   AOSP raspberry-vanilla (ci)
│   ├── aosp-platform-nightly.yml       #   AOSP raspberry-vanilla (nightly)
│   ├── aosp-platform-release.yml       #   AOSP raspberry-vanilla (release)
│   ├── yocto-sdk-app.yml              #   Yocto SDK application (component)
│   └── android-hal-module.yml         #   Android NDK HAL module (component)
└── templates/                          # Config templates for new projects
    ├── integration.yml
    ├── component-yocto.yml
    ├── component-aosp.yml
    └── component-custom.yml
```

## Build Types

Each subsystem has configs per build type:

| Build Type | Trigger | Retention | Publish | Notify |
|------------|---------|-----------|---------|--------|
| `ci` | Webhook | 20 builds | No | Failure only |
| `nightly` | Cron (2 AM) | 14 builds | Yes | Failure + fixed |
| `release` | Manual | All | Yes | Always |
| `integration` | Cron (Sat 4 AM) | 10 builds | Yes | Failure + fixed |

## Integration Build

`projects/integration.yml` defines a multi-subsystem build:

```yaml
mode: integration

project:
  name: integration-build
  type: custom
  buildType: integration

workspace: /var/jenkins/workspace/integration

manifest:
  url: <manifest-repo-url>
  branch: main
  reference: /mnt/workspace/mirrors/reference

stages: [checkout, build, publish, notify]

subsystems:
  - custom-firmware
  - yocto-bsp
  - aosp-platform
```

Nightly and release variants (`integration-nightly.yml`, `integration-release.yml`) reference their own subsystem configs (e.g., `custom-firmware-nightly`, `yocto-bsp-release`).

## Subsystem Config

Each subsystem specifies its builder type, Docker image, build script, and artifact settings:

```yaml
project:
  name: yocto-bsp
  type: yocto
  buildType: ci

environment:
  agent: "audioi-linux"
  timeout: 300
  docker:
    image: registry.example.com/yocto-builder:latest
    credentialId: artifactory-creds

yocto:
  buildScript: build-scripts/integration/yocto-build.sh

publish:
  artifacts:
    - pattern: "yocto/build/tmp/deploy/images/**/*.wic.bz2"
      repo: firmware-builds

stages: [checkout, build, publish, notify]
```

## Templates

Use `templates/` as starting points for new subsystem configs. Copy to `projects/` and customize.

## Related Repos

- **generic-cicd** — Jenkins shared library that consumes these configs
- **build-scripts** — Build shell scripts referenced by `buildScript` fields

## License

Internal Use — see [LICENSE](LICENSE)
