# Story: AD-CRM-02 - Opportunity Forecast Alerts

**Status**: `ready-for-dev`
**Role**: `crm.lead`, `mail.activity`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Sales Manager,
**I want** to be automatically notified when high-value opportunities remain stale for more than a week,
**so that** I can intervene and ensure the sales team is following up on critical pipeline items.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Monitoring Criteria
**GIVEN** a daily background scan,
**WHEN** an Opportunity meets the following conditions:
- **Value**: `expected_revenue >= 50,000`.
- **Status**: Not "Won" or "Lost" (`probability` between 1 and 99).
- **Inactivity**: No updates to the record (`write_date`) for **7 calendar days**.
**THEN** it must be flagged as "Stale".

### AC-02: Alert Execution
**GIVEN** a Stale Opportunity is identified,
**WHEN** the cron task runs,
**THEN** the system must:
- Create a **Mail Activity** (Type: `Exception`, Summary: `Stale High-Value Opportunity`).
- Assign the activity to the **Sales Manager** (or the user in `group_sale_manager`).
- Post a **Chatter message** explicitly tagging the salesperson to remind them to update the forecast.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service` 
- **Method**: Add `_cron_stale_opportunity_alerts()` to `crm.lead`.
- **Assignment**: If no specific manager is linked, assign to the lead's owner but notify the manager group.

---

## 🧪 Testing Requirements
- [ ] Create an Opportunity with 100k revenue. Set `write_date` (via SQL) to 8 days ago. Run cron -> Verify activity created.
- [ ] Create an Opportunity with 10k revenue. Set `write_date` to 8 days ago. Run cron -> Verify NO activity created.
- [ ] Verify that Won/Lost opportunities are ignored even if stale.
