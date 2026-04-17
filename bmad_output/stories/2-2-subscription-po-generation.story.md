# Story: AD-SALE-02 - Subscription PO Generation

**Status**: `ready-for-dev`
**Role**: `sale.order`, `purchase.order`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Procurement Officer,
**I want** Purchase Orders to be automatically generated for subscription software upon sales confirmation,
**so that** I can fulfill customer orders quickly without manual entry and track procurement history.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Automated Vendor Grouping
**GIVEN** a confirmed Sale Order with multiple software products from different vendors,
**WHEN** the order is confirmed,
**THEN** the system must create one draft Purchase Order per vendor.

### AC-02: Software Product Filtering
**GIVEN** a Sale Order with both Hardware and Software lines,
**WHEN** confirmed,
**THEN** only lines marked as `Software` (subscriptions) should be included in the generated Purchase Orders.

### AC-03: Cost Alignment
**GIVEN** a Sale Order line with a manual cost override in `purchase_price`,
**WHEN** the PO is generated,
**THEN** the `price_unit` on the PO line must match the `purchase_price` from the SO line.

### AC-04: Document Linking
**GIVEN** an automated PO is created,
**WHEN** viewing the PO,
**THEN** the `Source Document` (origin) must be the Sale Order name, and the SO must show the linked POs in the statutory "Purchase Orders" button/smart tab.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service` 
- **Method**: Extend `SaleOrder.action_confirm`.
- **Logic**: 
    - Use `product_id.seller_ids` to find the primary vendor.
    - If no vendor is found, log a note in the SO chatter and skip that line (don't block confirmation).
    - Handle multi-company environments using `company_id`.

---

## 🔬 Developer Context & Insights

- **Cost Logic**: Use the `purchase_price` field added in AD-SALE-01.
- **Smart Button**: Standard `sale_purchase` smart button `action_view_purchase_orders` should automatically pick up POs with matching `origin` even if not explicitly linked via many2many (though explicit linking is preferred if possible).

---

## 🧪 Testing Requirements
- [ ] Confirm SO with 2 software lines (Vendor A, Vendor B). Verify 2 draft POs created.
- [ ] Confirm SO with 1 software line (Vendor A) and 1 hardware line. Verify 1 PO created for software only.
- [ ] Change `purchase_price` on SO line before confirmation. Verify PO line reflects this price.
