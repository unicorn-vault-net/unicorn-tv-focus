# Service-managed payloads

The release JNI fetches two protected payloads at runtime through the Unicorn
agent. They are delivered sealed and are not installed as local files.

## engine-cert (certified focus engine)

- operation: `get-data`
- resource_family_id: `tvfocus`
- logical_data_id: `engine-cert`
- current generation: `tvfocus-ec-g8`
- payload_file: `payloads/libfocusx_full-tvfocus-ec-g8.so`
- size: 770996 bytes
- sha256: `e881675c4eb8f36542e403e422ce0a1f88053195032993f40b99476c16ffb000`
- engine ABI: 4 — the release JNI rejects ABI 3 engines; do not promote
  an older generation without checking the JNI's accepted ABI

## policy-pack (rule pack)

- operation: `get-data`
- resource_family_id: `tvfocus`
- logical_data_id: `policy-pack`
- current generation: `tvfocus-pp-g4`
- size: 307 bytes
- sha256 prefix: `b8955bdf13e6c476`

## obf-key-v1 (engine external keyring)

- operation: `get-data`
- resource_family_id: `tvfocus`
- logical_data_id: `obf-key-v1`
- current generation: `tvfocus-ok-g1`
- size: 256 bytes
- sha256 prefix: `e3ac72f9db81ab5e`

The 256-byte keyring is delivered like any other protected payload;
the engine installs it in memory at runtime and it is never stored
as a local file. It is bound to the engine build it was generated
for — a future engine generation that changes its sealed constants
requires a new `logical_data_id` generation of this entry.

## Prefetch

`config/prefetch.list` contains the same two tuples so the agent can warm the
envelope cache at startup instead of fetching on first app launch. Install it
to the agent's configured directory (`/system/etc/unicorn/prefetch.list` on
this product).

## Prerequisites

Delivery requires the Unicorn agent deployed by the platform integrator:

- the agent binary and its init service;
- the device service-CA and enrollment/authorization files;
- the resource-family policy and catalog generations registered on the
  service side; and
- the calling packages authorized on the device package allowlist.

These items are owned by the agent/service delivery package and are not part
of this repository.
