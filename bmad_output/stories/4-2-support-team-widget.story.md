# Story: AD-PORTAL-02 - Support Team Widget

**Status**: `ready-for-dev`
**Role**: `portal.portal_my_home`, `sh.helpdesk.ticket`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Customer,
**I want** to see my Account Manager's contact details and a summary of my active support tickets on the portal dashboard,
**so that** I know exactly who to contact and can track the status of my recent requests without digging through menus.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Widget Display
**GIVEN** the portal dashboard (`/my`),
**WHEN** a customer logs in,
**THEN** a "Support Team" widget must be visible in the sidebar or as a prominent card.

### AC-02: Account Manager Details
**GIVEN** the Support Widget,
**WHEN** an Account Manager is assigned to the customer's partner record,
**THEN** the widget must display:
- **Name**
- **Email** (Clickable `mailto:` link)
- **Phone** (if available)

### AC-03: Active Tickets Summary
**GIVEN** the Support Widget,
**WHEN** the customer has active helpdesk tickets,
**THEN** the widget must list the **3 most recent open tickets** with:
- Ticket Name
- Current Status (Badge)
- Link to the ticket detail page.

### AC-04: Digital Handover
**GIVEN** the Support Widget,
**THEN** it must include a "Start Chat" or "New Ticket" button shortcut.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service`
- **Data Fetching**: Use `sudo()` for ticket retrieval since portal users have restricted access to raw ticket models.
- **Performance**: Limit ticket fetch to `count=3` and `order="create_date desc"`.

---

## 🧪 Testing Requirements
- [ ] Log in as a customer with an AM. Verify contact info.
- [ ] Create 5 tickets for the customer. Verify only the 3 most recent appear.
- [ ] Close 2 tickets. Verify they disappear from the "active" list in the widget.
