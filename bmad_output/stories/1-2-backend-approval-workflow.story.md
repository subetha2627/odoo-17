# Story: AD-REG-02 - Backend Approval Workflow

**Status**: `ready-for-dev`
**Role**: `res.partner`, `sh.helpdesk.ticket`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Registration Specialist,
**I want** the system to automatically generate a Helpdesk ticket when a customer submits their registration for review,
**so that** our Verification Team can manage the approval process through a structured ticketing system.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Automated Ticket Generation
**GIVEN** a Partner record is in "Draft" registration state,
**WHEN** the state is changed to "Pending Approval" (submission for review),
**THEN** a new `sh.helpdesk.ticket` must be automatically created.

### AC-02: Ticket Metadata & Assignment
**GIVEN** an approval ticket is being created,
**WHEN** the creation logic runs,
**THEN** the ticket must have:
- **Name**: `Registration Approval: [Partner Name]`
- **Partner**: Linked to the Partner record.
- **Team**: Assigned to the "Verification Team" (look up by name).
- **Description**: Brief detail about the approval requirement.

### AC-03: Registration Email Continuity
**GIVEN** the ticketing process is active,
**WHEN** the customer record is updated (Success/Approve/Reject),
**THEN** the automated emails must continue to be sent from the **Partner record** (not the ticket).

### AC-04: Testing & Notification Fallback
**GIVEN** a live demo or testing environment,
**WHEN** a registration is submitted,
**THEN** the system must send an internal alert to `divya.bsc6@gmail.com` to ensure visibility during testing. Background failures in ticketing or email must not crash the registration flow.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service`
- **Hook Strategy**: Use an override of the `write` method on `res.partner` to detect the state change from `draft` to `pending_approval`.
- **Softhealer Integration**:
    - Model: `sh.helpdesk.ticket`.
    - Team Lookup: Search for `sh.helpdesk.team` where `name == 'Verification Team'`.
- **Constraint**: Do not duplicate tickets if the state is toggled multiple times (check for existing registration tickets).

---

## 🔬 Developer Context & Insights

- **Softhealer Model**: Ensure `partner_id` is set on the ticket to maintain the portal linkage.
- **Workflow Sync**: In this story, we are only automating the **creation**. Future stories will handle stage synchronization.
- **Email Logic**: Amelia should ensure she doesn't accidentally trigger Softhealer's default ticket-creation notifications if they aren't configured yet.

---

## 📋 Tasks & Subtasks
 
### 1. Ticket Automation Logic
- [x] Override `write` method in `models/res_partner.py`.
- [x] Implement logic to detect state change from `draft` to `pending_approval`.
- [x] Implement helper method `_create_registration_approval_ticket`.
- [x] Logic to find "Verification Team" and create `sh.helpdesk.ticket`.
- [x] Ensure non-duplication (check `ticket_ids` on partner).
 
### 2. Testing & Acknowledgment
- [x] Implement internal notification fallback to `divya.bsc6@gmail.com`.
- [x] Create and trigger professional welcome email (`mail_template_registration_submitted`).
- [x] Update `tests/test_partner_documentation.py` (or create new) to test ticket automation.
- [x] Verify ticket creation on portal submission.
 
---
 
## 🧪 Acceptance Criteria Validation
- [ ] AC-01: Automated Ticket Generation
- [ ] AC-02: Ticket Metadata & Assignment
- [ ] AC-03: Registration Email Continuity
 
---
 
## 🛠️ Status & Record
- **Status**: `done`
- **Assigned Agent**: Antigravity
- **Debug Log**:
  - [2026-04-13] Story enhanced with implementation tasks.
  - [2026-04-13] Implemented ticket automation and internal notifications.
  - [2026-04-13] Added acknowledgement email logic.
