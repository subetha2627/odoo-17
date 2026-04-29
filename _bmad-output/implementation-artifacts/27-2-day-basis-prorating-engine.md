# Story 27.2: Day-basis Prorating Engine

## User Story
**As a** Finance Manager,
**I want** the system to calculate prorated costs based on the exact number of days,
**So that** billing is accurate to the day and we avoid over/under-charging during mid-term changes.

## Status
Status: ready-for-dev

## Acceptance Criteria
1. **Given** a subscription upgrade or quantity change mid-period
2. **When** the system calculates the prorated cost for the remaining term
3. **Then** it must use the formula: `(Unit Price / Total Days in Period) * Remaining Days`.
4. **And** this logic must apply to both Increases (in portal) and Invoicing (Backend).

## Technical Requirements
- **Method**: Update `_adigielite_portal_prorated_increase_line_cost` in `subscription_package.py`.
- **Logic**:
  - Determine `total_days` of the term (e.g. from `start_date` to `end_date`).
  - Determine `active_days` (from `change_date` to `end_date`).
  - `prorated_price = (unit_price / total_days) * active_days`.
- **Scope**: Ensure this is used by the portal proration and any backend prorating logic.

## Developer Context
- Check `subscription_package.py` lines 417+ for existing proration logic.
- Ensure leap years are handled by using `total_days` of the specific period rather than a hardcoded 365.

## Implementation Plan
1. Refactor `_adigielite_portal_prorated_increase_line_cost` to use the day-basis formula.
2. Verify if any other methods in `subscription_package.py` or `sale_order_line.py` need adjustment.
