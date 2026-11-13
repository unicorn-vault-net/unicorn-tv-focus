# Service-managed payloads

The release JNI fetches two protected payloads at runtime through the Unicorn
agent. They are delivered sealed and are not installed as local files.

## engine-cert (certified focus engine)

- operation: `get-data`
- resource_family_id: `tvfocus`
- logical_data_id: `engine-cert`
- current generation: `tvfocus-ec-g10`
- payload_file: `payloads/libfocusx_full-tvfocus-ec-g10.so`
- size: 772373 bytes
- sha256: `d26821da7aedd54e61921da8cceab7835da4b53c379077704dbc0ca699e80576`
- engine ABI: 5 — full-gate hardened build (OLLVM pinned-seed + OBF +
  ext-key + BLA), complete vtable; the release JNI rejects ABI 3 engines
- earlier generations `tvfocus-ec-g9` (`7fe27a76…`) and `tvfocus-ec-g8`
  (`e881675c…`, ABI 4 — the `E200` cause) were REMOVED from the catalog:
  a stale engine must never resolve as a fallback. Generation ids are
  never pinned, so the swap is a live replace; `catalog.json.bak-ec-g10`
  covers instant rollback
- device success signals: `I100` certified-active + `I102` pack installed
  + `I103` keyring — not `E200`/`I101`

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
