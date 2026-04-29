# Story 28.1: Confirmed Sales to Purchase Blocking

## User Story
**As a** Procurement Officer,
**I want** to ensure that I only create Purchase Orders for Sales Orders that are officially confirmed,
**So that** we don't accidentally buy stock for uncommitted sales.

## Status
Status: ready-for-dev

## Acceptance Criteria
1. **Given** a Sales Order in 'Draft' or 'Sent' state
2. **When** a user attempts to create a Purchase Order from a line item or in bulk
3. **Then** the system should block the action with a user-friendly error message.

## Technical Requirements
- **Location**: `sale_order_line.py` (`action_create_po_line`) and `sale_order.py` (`action_create_purchase_orders_by_vendor`).
- **Implementation**: Add a state check `if order.state not in ('sale', 'done'): raise UserError(...)`.

## Developer Context
- Check existing `invisible` attributes in XML as a first-line UI guard, but enforce in Python for data integrity.

## Implementation Plan
1. Update `action_create_po_line` in `sale_order_line.py`.
2. Update `action_create_purchase_orders_by_vendor` in `sale_order.py`.
