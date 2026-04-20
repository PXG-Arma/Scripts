# BigArmory Merge Masterplan: Modular Logic Integration

This document outlines the strategic refactoring required to integrate the advanced modular features of the `BigArmory` branch (Modular Weapons, Sight Selection, and Live Preview) into the modern Hashmap-based architecture.

## Goal
Transform the current "Fixed Loadout" system into a "Modular Loadout" system where users can customize their primary weapon and optics. This will be achieved by porting the modular logic of `BigArmory` into the high-performance `Modern` Hashmap architecture. The system will support **SlotGroups** (role-based permissions), **GunGroups** (weapon sets), and **Smart Attachment Resolution** (auto-dressing weapons).

## User Review Required

> [!IMPORTANT]
> **Schema Change**: The `Faction_Core.sqf` Hashmap structure will be expanded to include `SlotGroups` and `GunGroups` metadata. This simplifies mass-updates to gear permissions.

> [!IMPORTANT]
> **Dual Structure Support**: We will implement a "Discovery Layer" (`PXG_Get_Modular_Options.sqf`) that can extract modular options from both the old `Weapons.sqf` scripts and the new `Faction_Core.sqf` hashmaps.

## Proposed Phases

### Phase 1: Data Schema & Discovery Refactor
Establish the data contract for modularity and the centralized discovery utility.

- **[MODIFY]** `Faction_Core.sqf` Schema:
    - `SlotGroup`: Meta-category for the role (e.g., "Infantry", "Recon").
    - `primary_options`: List of **GunGroups** or specific classnames allowed.
    - `GunGroups`: Global mapping of group names to classname lists.
    - `Attachment_Standards`: Faction-specific default attachments per weapon/group.
- **[NEW]** `PXG_Get_Modular_Options.sqf`: 
    - The "Discovery Layer" for the UI.
    - Handles Hashmap lookups and falls back to legacy `Weapons.sqf` (Mode: `"GET_MODULAR"`).
- **[MODIFY]** `PXG_ApplyFactionData.sqf`:
    - Implement **Smart Attachment Resolution**: Auto-apply `Attachment_Standards` unless overridden.
    - Handle modular weapon/scope overrides from the UI.

---

### Phase 2: Python FBT Exporter Refactor
Update the FBT Governor to handle the new metadata fields.

- **[MODIFY]** `fbt_manager.py`:
    - Update `save_faction` to serialize `SlotGroups`, `GunGroups`, and `Attachment_Standards`.
    - Ensure the exporter remains backwards compatible for older FBT projects.

---

### Phase 3: UI Expansion (Dynamic Sidebar & Preview)
Implement the "growing" UI and visual feedback system.

- **[MODIFY]** `armoryDialog.hpp`:
    - Add `IDC_ARMORY_MODULAR_PANEL` sidebar.
    - Add Weapon, Scope, and Attachment listboxes (hidden by default).
    - Add `IDC_ARMORY_PREVIEW_PICTURE` for live weapon visuals.
- **[MODIFY]** `PXG_Refresh_Loadouts.sqf`:
    - Add logic to trigger the UI "Growth" (ctrlShow) when modular options are detected.
- **[NEW]** `PXG_Update_Preview.sqf`: 
    - Refactored from BigArmory. 
    - Dynamically renders the selected weapon combination in the UI.

## Verification Plan

### Automated Tests
- `npm run test:factions`: Verify that FBT-generated hashmaps correctly include the new metadata fields.
- `arma3:test`: Script-based verification of `PXG_Get_Modular_Options.sqf` returning correct arrays.

### Manual Verification
1. Open Armory with a "Modern" faction (Hashmap).
2. Select a role with `primary_options`.
3. **Expect**: UI sidebar appears to the right.
4. Select a weapon.
5. **Expect**: 3D Preview updates; Scope list populates with allowed optics.
6. Click "Request Loadout".
7. **Expect**: Unit is dressed with the specific weapon and scope selected.
