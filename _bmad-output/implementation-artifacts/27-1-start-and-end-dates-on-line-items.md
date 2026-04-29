# Story 27.1: Start and End Dates on Line Items

## User Story
**As an** Internal User (Sales, Admin, Tech, or Accountant),
**I want to** see Start and End dates for every product line on my transactions,
**So that** I can clearly audit service periods without manual calculations.

## Status
Status: ready-for-dev

## Acceptance Criteria
1. **Given** I am viewing a Sales Order, Purchase Order, or Invoice
2. **When** I look at the product line items
3. **Then** I should see "Start Date" and "End Date" fields after the Unit of Measure.
4. **And** these dates should persist and carry through from the Sales Order to the generated Invoice.

## Technical Requirements
- **Models**: `sale.order.line`, `purchase.order.line`, `account.move.line`.
- **Fields**: `start_date` (Date), `end_date` (Date).
- **Views**: Inherit SO, PO, and Invoice form views to add these fields in the `order_line` / `invoice_line_ids` trees.
- **Data Flow**:
  - `sale.order.line` -> `account.move.line` (Invoice generation).
  - `sale.order.line` -> `purchase.order.line` (PO generation).

## Developer Context
- Look at `adigielite_it_service/models/sale_order.py` for existing SO line date logic.
- Look at `adigielite_it_service/models/account_move.py` for invoicing logic.

## Implementation Plan
1. Add `start_date` and `end_date` to `sale.order.line`, `purchase.order.line`, and `account.move.line` if not already present.
2. Update form views for SO, PO, and Invoices.
3. Ensure `_prepare_invoice_line` in `sale.order.line` copies the dates.
4. Ensure PO generation logic copies the dates from SO lines.
