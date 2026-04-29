# Story 28.2: Stable Sales to Purchase PO Generation

## User Story
**As a** Procurement Officer,
**I want** the system to group identical products into a single line when generating bulk Purchase Orders,
**So that** our POs are concise and easier for vendors to process.

## Status
Status: ready-for-dev

## Acceptance Criteria
1. **Given** a Sales Order with multiple lines of the same product (same price/dates)
2. **When** I click "Create Purchase Orders"
3. **Then** the resulting PO should have a single line for that product with the summed quantity.
4. **And** the unit price should be the average or based on the first line (per policy).
5. **And** dates (start/end) must match for grouping.

## Technical Requirements
- **Location**: `sale_order.py` (`action_create_purchase_orders_by_vendor`).
- **Logic**: Group `vlines` by `(product_id, price_unit, start_date, end_date)` before creating `po_line_cmds`.

## Developer Context
- Be careful with `name` (description). If descriptions differ, should they still group?
- Requirement says "identical products". I'll group by Product + Price + Dates.

## Implementation Plan
1. Refactor the loop in `action_create_purchase_orders_by_vendor` to use a grouping dictionary.
