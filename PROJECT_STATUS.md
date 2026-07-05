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
- [ ] Shutdown — device stays powered on when ES shuts down

## What just shipped (v0.5.2-alpha)
BSP audio drivers enabled for USB-C DisplayPort audio output.

Audio path: RetroArch/ES → ALSA → I2S3 DMA (sunxi-snd-plat-i2s) → eDP0 DAI (already in DRM) → Cadence SERDES → USB-C DP → TV.

New kernel modules: snd_soc_sunxi_i2s, snd_soc_sunxi_codec_hdmi, snd_soc_sunxi_common, snd_soc_sunxi_machine, snd_soc_sunxi_pcm.

BSP Makefile bug fixed: platform/ not in ccflags → adapter/*.c couldn't find snd_sunxi_log.h. Patch at board/batocera/allwinner/a733/patches/linux/.

## Resume here
Audio in — needs boot test to confirm `aplay -l` shows a sound card. SSH key auth baked in (flash new image → `ssh root@<ip>` works). Controller disconnect intermittent (~130s, likely 8BitDo sleep timer). Community tester (AR glasses) seeing no display + no ethernet — suspect AR glasses hanging HUSB311/DWC3 during boot negotiation.

## Last session
2026-07-05: Audio drivers enabled (v0.5.2-alpha). Community tester on Discord reports no display with AR glasses — investigating whether glasses cause boot hang.
