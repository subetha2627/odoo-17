# Technical Architecture: Epic 21 (IT Services Enhancements)

## 1. Overview
This document defines the technical architecture for Epic 21, extending the `adigielite_it_service` Odoo 17 module. A critical constraint is that **all custom development, inheritance, and business logic must reside within the `adigielite_it_service` module.** 

This architecture integrates the **Softhealer All-In-One Helpdesk** modules as core dependencies for ticketing, SLA, and portal support.

## 2. Data Model Extensions

### 2.1. Partner Management (`res.partner`)
- **Document Validation Fields**:
  - `vat_number`: `Char`
  - `license_number`: `Char`
  - `vat_attachment`: `Binary`
  - `license_attachment`: `Binary`
  - `vat_expiry_date`: `Date`
  - `license_expiry_date`: `Date`
- **Helpdesk Integration**:
  - `approval_ticket_id`: `Many2one('sh.helpdesk.ticket')` (Linked to Softhealer ticket model)
- **Security**:
  - `block_login_on_expiry`: Override Odoo's auth check or use a record rule/base override to prevent login if `is_document_expired` is True.

### 2.2. Sale Order & Lines (`sale.order` & `sale.order.line`)
- **SO Level**:
  - `quotation_customer_name`: `Char` (For quotes without formal partner)
  - `quotation_customer_email`: `Char`
  - `quotation_customer_address`: `Text`
- **SO Line Level**:
  - `cost_price`: `Float` (Manually adjustable or from Vendor info)
  - `vendor_id`: `Many2one('res.partner')` (Vendor for this line)
  - `gross_profit`: `Float` (Computed: `(price_subtotal - (cost_price * quantity))`)
  - `gross_profit_pct`: `Float` (Computed percentage)
  - `subscription_package_id`: `Many2one('subscription.package')`
  - `contract_start_date`: `Date`
  - `contract_end_date`: `Date`

## 3. Automation & Messaging

### 3.1. Document Expiry Monitoring
- **Cron Job (`ir.cron`)**:
  - Logic: Daily check for expiry (T-30 days).
  - Action: Trigger `mail.template` and create an internal `sh.helpdesk.ticket`.

## 4. Helpdesk & Ticketing Architecture
- **Base Models**: `sh.helpdesk.ticket`, `sh.helpdesk.team`, `helpdesk.stages`.
- **Inheritance**: All custom logic for registration approvals and fulfillment tracking must be implemented via inheritance of `sh.helpdesk.ticket` within `adigielite_it_service`.
- **Workflow Stages**: Explicitly configured for Customer Registration (Draft -> Pending Approval -> Clarification -> AM Review -> Approved/Rejected).

## 5. Business Logic (Workflows)

### 5.1. Multi-Vendor PO Split
- **Method**: `action_create_purchase_order` on `sale.order`.
- **Logic**: Group SO lines by vendor and generate separate POs.

### 5.2. Fulfillment Tracking
- **Action**: Create `sh.helpdesk.ticket` when PO or Subscription is generated.

## 5. User Roles & Security
- **Groups (`res.groups`)**:
  - `group_adigielite_sales`: Access to CRM, SO, Leads.
  - `group_adigielite_am`: Access to Partner Approval, Subscriptions.
  - `group_adigielite_tech`: Access to Tickets and Tasks.
- **Record Rules**:
  - Separate visibility of "Fulfillment Tickets" vs "Support Tickets" based on role.

## 6. UI/UX Implementation (Placements)
*As per existing UI/UX specifications:*
- **Partner Form**: Add a new page "Documentation & Licensing" for VAT/License fields.
- **Sale Order Line**: Add `Cost`, `Vendor`, and `Margin` columns (toggleable or always visible for Sales/Admin).
- **Portal Account**: Add "My Support Team" widget to the portal sidebar or dashboard.
