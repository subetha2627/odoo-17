# Story: AD-REG-03 - Expiry Monitoring & Restricted Access

**Status**: `ready-for-dev`
**Role**: `res.partner`, `ir.cron`, `sh.helpdesk.ticket`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Security Officer,
**I want** the system to proactively monitor document expiration and restrict access for non-compliant customers,
**so that** we mitigate legal and operational risks.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Proactive Expiry Alerts (Cron)
**GIVEN** a Partner has documents (VAT/License) expiring in 30 days,
**WHEN** the daily cron job runs,
**THEN** an alert email must be sent to the customer, and a notification must be logged on the Partner record.

### AC-02: Expiry Enforcement (Portal Block)
**GIVEN** a Partner's document has expired today (T-0),
**WHEN** the portal user attempts to access the system,
**THEN** they must be redirected or restricted to a specific "Document Update" page, with all other portal menus (Orders, Tickets, etc.) hidden.

### AC-03: Expiry Tracking (Ticketing)
**GIVEN** a document expires,
**WHEN** the system detects the expiration,
**THEN** a new `sh.helpdesk.ticket` (Status: Review) must be created for the admin team to track the audit/renewal process.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service`
- **Cron Job**: Create `ir.cron` in `data/ir_cron_data.xml` calling `_cron_check_document_expiry`.
- **Access Rule**:
    - Override `_compute_is_portal_user_active` or implement a custom check in the portal controller.
    - The restriction logic must allow the user to **log in** but see a restricted UI.
- **Ticketing Integration**:
    - Reuse the `Verification Team` logic from AD-REG-02.
    - Name: `Expiry Audit: [Partner Name]`.

---

## 🔬 Developer Context & Insights

- **Self-Correction Path**: It is critical that the "restricted portal" actually allows the user to see the "Documentation" fields we added in **AD-REG-01** so they can upload the new files.
- **Notification Spam**: Ensure the 30-day alert only fires once.
- **Portal Templates**: You may need to override `portal.portal_layout` to selectively hide the sidebar/sidebar items if the account is `restricted`.

---

## 🧪 Testing Requirements
- [ ] Set a partner's VAT expiry date to tomorrow and run the cron.
- [ ] Set a partner's VAT expiry date to yesterday.
- [ ] Login as a portal user for that partner and verify standard menus are hidden.
- [ ] Verify an "Expiry Audit" ticket is created.
