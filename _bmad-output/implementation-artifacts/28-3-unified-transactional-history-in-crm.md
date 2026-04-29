# Story 28.3: Unified Transactional History in CRM

## User Story
**As an** Account Manager,
**I want** to see all sales, purchases, and invoices related to a deal directly on the Opportunity,
**So that** I have a 360-degree view of the transaction status without switching modules.

## Status
Status: ready-for-dev

## Acceptance Criteria
1. **Given** a CRM Opportunity
2. **When** viewing the form
3. **Then** I should see stat buttons or tabs for:
   - Quotations/Orders (standard Odoo has this, but ensure it shows all linked ones).
   - Purchase Orders.
   - Invoices.

## Technical Requirements
- **Model**: `crm.lead`.
- **Fields**: 
  - `adigielite_purchase_order_ids` (M2M or computed).
  - `adigielite_invoice_ids` (M2M or computed).
- **Views**: Inherit `crm.lead` form to add stat buttons.

## Developer Context
- Standard Odoo already has "Quotations".
- We need to add "Purchases" and "Invoices".
- Logic:
  - Purchases: SOs linked to Lead -> POs linked to SOs.
  - Invoices: SOs linked to Lead -> Invoices linked to SOs.

## Implementation Plan
1. Add computed fields and action methods to `crm.lead.py`.
2. Update `crm_lead_views.xml`.
