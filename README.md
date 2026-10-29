# Unicorn TV Focus - Device-Side Release (AOSP 10)

Binary release bundle for a 32-bit ARMv7 Android TV device running AOSP 10.
This repository is an integration handoff, not a flashable ROM image: apply the
framework patches, copy the prebuilt files into the product tree, and rebuild
the ROM.

Use of the contents of this repository is governed by the terms in `LICENSE`.

## Contents

| Path | Description |
|---|---|
| `patches/android-10/` | Framework patch series for the AOSP 10 tree; apply in numeric order. |
| `jar/tvfocus-policy.jar` | Obfuscated DEX policy jar, loaded per-process via `PathClassLoader`. |
| `so/armeabi-v7a/` | `libfocusjni.so` (JNI bridge), `libfocusx_free.so` (fallback engine), `libc++_shared.so`. |
| `system/bin/uinputd` | Input-injection daemon for native activation and scrolling. |
| `system/lib/libc++_shared.so` | Shared C++ runtime required by `uinputd`. |
| `system/usr/idc/unicorn-focus-touch.idc` | Input-device configuration for the virtual touchscreen. |
| `config/tvfocus-packages.txt` | Package filter; controls which apps the policy attaches to. |
| `config/tvfocus-overrides.json` | Per-app override rules consumed by the policy. |
| `config/tvfocus.properties.example` | Reference system properties for this port. |
| `config/prefetch.list` | Agent prefetch tuples for the engine-cert and policy-pack payloads. |
| `rc/` | Init fragments to merge into the product's existing init files. |
| `docs/PRODUCT_COPY_FILES.fragment.mk` | Illustrative `PRODUCT_COPY_FILES` entries. |
| `docs/SERVICE-PAYLOADS.md` | Service-managed payload metadata (engine-cert, policy-pack). |
| `SHA256SUMS.txt` | SHA-256 checksums for every file in this release. |

## Framework integration

Apply `patches/android-10/0000` through `0003` to the AOSP 10
`frameworks/base` tree, in numeric order, then rebuild the ROM:

```bash
cd $AOSP/frameworks/base
for p in 0000 0001 0002 0003; do
    git apply --check $TVFOCUS/patches/android-10/${p}-*.patch && \
    git apply $TVFOCUS/patches/android-10/${p}-*.patch
done
```

The patch series adds the `android.view.focus` interfaces, the `ViewRootImpl`
policy hooks (policy loading, D-pad interception, focus-rect drawing, layout
dirty tracking), the accessibility-enumeration hook required for Compose
content, and the zone-tip string resource.

## Install map

This port loads the policy jar per-process with `PathClassLoader`; do not add
it to `PRODUCT_BOOT_JARS`.

| Bundle path | Target path |
|---|---|
| `jar/tvfocus-policy.jar` | `/system/framework/tvfocus-policy.jar` |
| `so/armeabi-v7a/libfocusjni.so` | `/system/lib/libfocusjni.so` |
| `so/armeabi-v7a/libfocusx_free.so` | `/system/lib/libfocusx_free.so` |
| `so/armeabi-v7a/libc++_shared.so` | `/system/lib/libc++_shared.so` |
| `system/bin/uinputd` | `/system/bin/uinputd` |
| `system/usr/idc/unicorn-focus-touch.idc` | `/system/usr/idc/` |
| `config/tvfocus-packages.txt` | `/system/etc/tvfocus-packages.txt` |
| `config/tvfocus-overrides.json` | `/system/etc/tvfocus-overrides.json` |
| `config/prefetch.list` | `/system/etc/unicorn/prefetch.list` |

Merge `rc/tvfocus-properties.rc` and `rc/uinputd.service.fragment.rc`
into the product's existing init files. These are fragments; do not replace an
entire device init file with them.

`docs/PRODUCT_COPY_FILES.fragment.mk` shows equivalent `PRODUCT_COPY_FILES`
entries; adapt `TVFOCUS_RELEASE_ROOT` to where this repository is staged in the
device tree.

## Runtime configuration

Reference properties (`config/tvfocus.properties.example`):

```
persist.sys.dpad_focus.policy=com.unicorn.focus.FocusPolicy
persist.sys.dpad_focus.enabled=1
persist.sys.dpad_focus.a11y=1
persist.sys.dpad_focus.jar=/system/framework/tvfocus-policy.jar
persist.sys.dpad_focus.lib=/system/lib
persist.sys.dpad_focus.scene=0
persist.sys.dpad_focus.debug=0
```

`enabled` is a runtime master switch; `a11y` enables the accessibility
enumeration path for packages listed in `tvfocus-packages.txt`.

## Service-managed payloads

The certified full engine (`engine-cert`) and the policy pack (`policy-pack`)
are delivered at runtime by the Unicorn agent over the protected-data
service - they are not installed as local files. See
`docs/SERVICE-PAYLOADS.md` for the tuple and generation metadata. The Unicorn
agent itself, the client library it exposes, the device CA/enrollment files,
and the service-side catalog are provided separately by the platform
integrator.

## Verification

`SHA256SUMS.txt` covers every file in this release:

```bash
sha256sum -c SHA256SUMS.txt
```
