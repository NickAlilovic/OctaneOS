---
phase: active
priority: high
category: hardware
progress: 82
focus: WiFi working — SSH accessible, audio next
next_milestone: Audio + RetroAchievements
milestone_distance: weeks
community_pressure: high
excitement: very high
strategic: true
momentum: accelerating
audience: diy-retro-gaming-builders
uniqueness: first-mover
viral_potential: high
mvp_distance: weeks
---

## Why this exists
A $150 weekend build that anyone can make, own completely, and runs every retro game — open source from silicon to firmware.

## Strategic picture
OctaneOS is the foundation everything else in GameOctane sits on. GPU hardware acceleration just shipped. EmulationStation is running smooth. First ROM (Doom) confirmed playing with a controller. The platform is real. Next: RetroAchievements out of the box, three mode system, and OTA updates.

## Next up
- [ ] Audio — not yet tested, need to verify ALSA codec init on A733
- [ ] RetroAchievements configured out of the box
- [ ] Three mode system (handheld / docked / wireless streaming)
- [ ] OTA update system from GameOctane.com
- [ ] GameOctane companion app integration
- [ ] 8BitDo controller disconnect fix (intermittent, ~130s interval — likely controller sleep timer)
- [ ] Suppress spurious DP-1 hotplug events from sunxi-drm BSP
- [ ] Shutdown — device stays powered on when ES shuts down

## What just shipped (v0.5.1-alpha)
WiFi 6 working. aic8800 USB driver was built against kernel 5.15.147 but board runs 6.6.98 — vermagic mismatch silently prevented the module from loading. Rebuilt against 6.6 kernel headers. WiFi connects, SSIDs visible.

Also: SSH key auth baked into fsoverlay (`root/.ssh/authorized_keys`), debug env vars removed from labwc-launch.

## Resume here
WiFi works. SSH accessible at device IP via key auth (next flash). Audio not yet investigated — `aplay -l` via SSH will tell us immediately if the kernel sees a sound card. Controller disconnect is intermittent (~130s intervals, likely 8BitDo's own sleep timer). Focus: audio, then RetroAchievements now that network is live.

## Last session
2026-07-04: WiFi fixed (boot 88). aic8800 rebuilt against 6.6.98. SSH key auth added to fsoverlay. GPU debug env vars cleaned up. Released v0.5.1-alpha.
