# Story: AD-SLA-01 - SLA Automated Feedback

**Status**: `ready-for-dev`
**Role**: `ticket.helpdesk`, `portal`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Customer Success Manager,
**I want** to automatically collect customer feedback after a support ticket is resolved,
**so that** we can measure our service level (SLA) and identify areas for process improvement.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Delay-Based Trigger
**GIVEN** a support ticket is marked as "Closed" (`fold=True`),
**WHEN** 24 hours have passed without the customer providing a rating,
**THEN** the system must automatically send a feedback request email.

### AC-02: Rating Email
**GIVEN** the automated feedback trigger,
**WHEN** the email is sent,
**THEN** it must:
- Be personal and professional.
- Contain a **secure, direct link** to the portal feedback page for that specific ticket.

### AC-03: Portal Feedback Form
**GIVEN** a customer clicks the feedback link,
**WHEN** they arrive on the portal page,
**THEN** they must see:
- A **Star Rating** (1 to 5).
- A **Comment** text area.
- A "Submit Feedback" button that updates the ticket and posts a chatter confirmation.

### AC-04: Prevention
**GIVEN** a ticket that already has a rating or has had a prompt sent,
**WHEN** the cron runs,
**THEN** no further emails should be sent to avoid spamming the customer.

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service`
- **Fields**: 
    - `x_customer_rating` (Integer/Selection)
    - `x_customer_comment` (Text)
    - `x_feedback_requested` (Boolean)
- **Email Link**: Use secure identifier if possible, or standard portal authentication.

---

## 🧪 Testing Requirements
- [ ] Close a ticket. Wait 1 min (mocking 24h). Run cron -> Verify email sent.
- [ ] Open the portal feedback link. Submit a 5-star rating -> Verify ticket fields are updated in backend.
- [ ] Verify that submitting feedback once prevents the cron from ever emailing for that ticket again.
