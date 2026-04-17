# Story: AD-SALE-01 - Quotation Margin & GP Analysis

**Status**: `ready-for-dev`
**Role**: `sale.order`, `sale.order.line`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Sales Manager,
**I want** to see real-time profitability data on quotations,
**so that** I can ensure all deals meet our minimum gross profit requirements and enforce a multi-level approval hierarchy.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Line-Level Margin Analysis
**GIVEN** a Sale Order is being drafted,
**WHEN** products are added,
**THEN** each line must show:
- **Cost Price**: (Drawn from product record or manual override).
- **Margin Amt**: `(Unit Price - Cost Price) * Qty`.
- **Margin %**: `(Margin Amt / Subtotal) * 100`.

### AC-02: Order-Level GP Analysis
**GIVEN** a quotation has multiple lines,
**WHEN** viewed by a manager,
**THEN** the total order must summarize:
- **Total Margin Amt**: Sum of all line margins.
- **Total GP %**: `(Total Margin Amt / Total Amount) * 100`.

### AC-03: Multi-Level Margin Approval
**GIVEN** a Salesperson attempts to confirm an order,
**WHEN** the **Total GP %** is calculated:
- **IF < 10%**: Require **Sales Manager** approval.
- **IF < 5%**: Require **Country Manager** approval.
- **THEN** block confirmation and create a `margin.approval.request` (or similar notification) for the respective tier.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service`
- **Fields**: 
    - `sale.order.line`: `purchase_price` (to match `sale_margin` module pattern), `margin`, `margin_percent`.
    - `sale.order`: `margin`, `margin_percent`.
- **Logic**: 
    - If `sale_margin` module is installed, reuse its fields. If not, implement standard calculations.
    - **Trigger**: Re-calculate on change of `price_unit` or `purchase_price`.

---

## 🔬 Developer Context & Insights

- **Cost Logic**: Use `product_id.standard_price` as the default for `purchase_price`.
- **Approval Check**: Move the trigger logic from `action_confirm` to a check that happens before moving to `sent_to_customer` state as well, but definitely keep it at `action_confirm` for enforcement.
- **Groups**: Use `adigielite_it_service.group_sales_manager` and `adigielite_it_service.group_country_manager` if they exist, or use standard Sales groups.

---

## 🧪 Testing Requirements
- [ ] Create SO with 15% margin. Confirm -> Success.
- [ ] Create SO with 8% margin. Confirm -> Blocked (Req Sales Manager).
- [ ] Create SO with 3% margin. Confirm -> Blocked (Req Country Manager).
- [ ] Verify totals correctly ignore lines with 0 cost (e.g. service fees if applicable).
