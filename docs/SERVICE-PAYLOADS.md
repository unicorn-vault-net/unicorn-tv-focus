# Service-managed payloads

The release JNI fetches two protected payloads at runtime through the Unicorn
agent. They are delivered sealed and are not installed as local files.

## engine-cert (certified focus engine)

- operation: `get-data`
- resource_family_id: `tvfocus`
- logical_data_id: `engine-cert`
- current generation: `tvfocus-ec-g5`
- payload_file: `payloads/libfocusx_full-tvfocus-ec-g5.so`
- size: 698632 bytes
- sha256: `4edd5fdcc603bc111dab0c4b2f8313e9262adbe56f34ee32d9a9335640a62c19`

## policy-pack (rule pack)

- operation: `get-data`
- resource_family_id: `tvfocus`
- logical_data_id: `policy-pack`
- current generation: `tvfocus-pp-g4`
- size: 307 bytes
- sha256 prefix: `b8955bdf13e6c476`

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
