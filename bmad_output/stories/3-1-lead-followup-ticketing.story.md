# Story: AD-CRM-01 - Lead Follow-up Ticketing

**Status**: `ready-for-dev`
**Role**: `crm.lead`, `sh.helpdesk.ticket`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Sales Representative,
**I want** a technical support ticket to be automatically generated when I move a lead to 'Requirement Discovery',
**so that** our pre-sales engineers are notified and assigned to assist with technical qualification.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Automation Trigger
**GIVEN** an active CRM Lead,
**WHEN** the stage is changed to **'Requirement Discovery'**,
**THEN** the system must create a new Helpdesk ticket.

### AC-02: Ticket Data Population
**GIVEN** an automated ticket is being created,
**WHEN** the process runs,
**THEN** the ticket must:
- **Subject**: `Lead Follow-up: [Lead Name]`.
- **Customer**: The `partner_id` from the Lead (if set).
- **Description**: Include a link to the CRM Lead backend view.
- **Team**: Assigned to **'Sales Support'**.

### AC-03: Team Auto-Creation
**GIVEN** the automation runs for the first time,
**WHEN** the system looks for the **'Sales Support'** team,
**THEN** it must create the team automatically if it is missing, ensuring the workflow never fails.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service` 
- **Method**: Inherit `crm.lead` and override `write`.
- **Logic**: 
    - Case-insensitive matching for the stage name.
    - Prevent duplicate tickets if the lead is moved in/out of the stage multiple times (use a boolean flag `helpdesk_ticket_created`).

---

## 🧪 Testing Requirements
- [ ] Create a Lead. Move it to a new stage named 'Requirement Discovery'. Verify ticket created.
- [ ] Verify the ticket links back to the lead correctly.
- [ ] Verify moving the lead back and forth does not create multiple tickets for the same "Discovery" phase.
