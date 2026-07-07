---
phase: active
priority: high
category: hardware
progress: 85
focus: Audio drivers in — testing via USB-C DP to TV
next_milestone: Audio confirmed + RetroAchievements
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
- [ ] Audio — aplay -l returns no soundcards; machine driver failing (simple_dai_link_of errors)

## What just shipped (v0.5.4-alpha)
Three fixes based on community tester feedback:

**Bash shell**: Root shell was /bin/dash; Batocera profile scripts use bash syntax → "Bad substitution" on every login. S13octane-init now patches /etc/passwd to use /bin/bash at boot.

**US keyboard layout**: S26system fell back to first 2 chars of system.language ("en" from en_US) when system.kblayout unset. "en" is not a valid loadkeys layout; "us" is. S13octane-init now writes kblayout=us to batocera.conf if not already set.

**Clean shutdown**: AXP8191 PMIC poweroff wrote to register 0x32 (LDO4 voltage) instead of 0x55 (poweroff trigger). Kernel patch adds AXP8191_ID branch in axp20x_power_off() to use the correct register.

Also includes everything from v0.5.3-alpha (SSH, audio drivers).

## Resume here
v0.5.4-alpha: bash + xkb + shutdown fixes. Audio: `aplay -l` shows no soundcards — machine driver not registering. Need `dmesg | grep -iE 'snd|audio|dai'` from Amish to find the failing DAI link.

## Last session
2026-07-06: v0.5.4-alpha built. Audio confirmed broken (no soundcards). Need dmesg to debug simple_dai_link_of failures.
