# project-config

YAML pipeline configurations for embedded CI/CD subsystems. Used by **generic-cicd** shared library.

## Structure

```
project-config/
├── projects/                    # Active pipeline configs
│   ├── integration.yml          #   integration build (manifest, subsystems)
│   ├── custom-firmware.yml      #   CMake cross-compilation
│   ├── yocto-bsp.yml            #   Yocto BitBake RPi4 BSP
│   ├── aosp-platform.yml        #   AOSP raspberry-vanilla
│   ├── yocto-sdk-app.yml        #   Yocto SDK application
│   └── android-hal-module.yml   #   Android NDK HAL module
└── templates/                   # Config templates for new projects
    ├── integration.yml
    ├── component-yocto.yml
    ├── component-aosp.yml
    └── component-custom.yml
```

## Integration Build

`projects/integration.yml` defines a multi-subsystem build:

```yaml
mode: integration
workspace: /var/jenkins/workspace/integration
cleanWorkspace: true

manifest:
  url: <manifest-repo-url>
  branch: main
  reference: /mnt/workspace/mirrors/reference

stages: [checkout, build, notify]
failFast: true

subsystems:
  - custom-firmware
  - yocto-bsp
  - aosp-platform
```

Each subsystem name maps to a `projects/<name>.yml` file with its own build config, Docker image, cache settings, and build script reference.

## Subsystem Config

Each subsystem specifies its builder type, Docker image, build script, and cache/artifact settings:

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

cache:
  - type: sstate
    src: cache/yocto/sstate
  - type: downloads
    src: cache/yocto/downloads

publish:
  artifacts:
    - pattern: "yocto/build/tmp/deploy/images/**/*.wic.bz2"
      repo: firmware-builds

stages: [checkout, build, publish, notify]
```

## Path Resolution

Cache and mirror paths can be relative or absolute:
- **Relative paths** (e.g., `cache/yocto/sstate`) are resolved relative to the workspace root
- **Absolute paths** (e.g., `/mnt/workspace/cache/yocto/sstate`) are used as-is

## Templates

Use `templates/` as starting points for new subsystem configs. Copy to `projects/` and customize.

## Related Repos

- **generic-cicd** — Jenkins shared library that consumes these configs
- **build-scripts** — Build shell scripts referenced by `buildScript` fields

## License

Internal Use — see [LICENSE](LICENSE)
