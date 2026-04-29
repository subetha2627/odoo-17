---
stepsCompleted: ['Step 1: Workflow Initialization', 'Step 2: Project Discovery', 'Step 2b: Product Vision Discovery', 'Step 2c: Executive Summary Generation', 'Step 3: Success Criteria Definition', 'Step 4: User Journey Mapping', 'Step 5: Domain-Specific Requirements', 'Step 6: Innovation Discovery (Skipped)', 'Step 7: Project-Type Deep Dive', 'Step 8: Scoping Exercise - MVP & Future Features', 'Step 9: Functional Requirements Synthesis', 'Step 10: Non-Functional Requirements', 'Step 11: Document Polish']
inputDocuments: [
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/architecture.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/epic-21-master.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/prd.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-01.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-02.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-03.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-04.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-05.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-06.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-07.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-08.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-09.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/story-21-10.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/walkthrough.md'
]
projectType: web_app
domain: fintech_accounting
complexityLevel: medium
projectContext: brownfield
outputFile: e:/odoo/odoo-17/_bmad-output/planning-artifacts/prd.md
---

# Product Requirements Document - AdigiElite IT Service Improvements

**Author**: Subetha  
**Date**: 2026-04-29

## Executive Summary
AdigiElite IT Service Improvements (Corrections-1) is a targeted upgrade to the existing Odoo 17 ERP ecosystem designed to bridge the gap between sales automation, financial precision, and operational visibility. The project empowers internal sales and administrative teams by streamlining the subscription lifecycle and enforcing rigorous data integrity, while simultaneously enhancing the self-service security experience for portal customers.

### What Makes This Special
This project implements **"Operational Integrity"** as a core system feature. By automating complex accounting tasks—such as prorated credit note generation—and enforcing regulatory compliance through TRN approval workflows, AdigiElite provides a level of financial transparency that distinguishes its service offering.

## Project Classification
*   **Project Type**: Web App (Odoo ERP Customization)
*   **Domain**: Fintech / Accounting
*   **Complexity**: Medium
*   **Project Context**: Brownfield (Building on the Epic 21 foundation)

## Success Criteria & Measurable Outcomes
*   **Transparency**: 100% clarity on billing periods via Start/End dates on all transactional documents.
*   **Self-Service Efficiency**: Customers successfully upgrade subscriptions in the portal within a 7-day eligibility window.
*   **Admin Confidence**: 0% unauthorized TRN changes; all modifications trapped for explicit approval.
*   **Manual Effort Reduction**: 90% reduction in manual billing corrections for subscription downgrades via automated prorating.
*   **Sales Productivity**: 50% reduction in time spent by sales managers looking for customer history via unified CRM Lead views.

## Product Scope & Phased Development

### Phase 1 (MVP - Current)
*   **Partner Extensions**: AMC logic and "Push to Zoho" governance.
*   **Financial Automation**: Precise day-basis prorated credit note generation.
*   **Portal Security**: TRN change approval workflow and 7-day upgrade logic.
*   **Transactional Stability**: Resolution of the Sales-to-Purchase PO generation error and Quote-to-PO blocking.
*   **Audit Visibility**: Start/End dates on all lines and CRM Lead history integration.

### Phase 2 & 3 (Future)
*   Automated email alerts for TRN approvals.
*   Subscription revenue and churn dashboarding.
*   AI-driven renewal forecasting based on historical CRM data.

## User Journeys

### Journey 1: The "Self-Service & Security" Path (Customer)
*   **Situation**: A customer logs into the portal, upgrades their subscription (checked against the 7-day rule), and updates their TRN.
*   **Climax**: The customer sees a "Pending Approval" status, feeling confident in the system's security.
*   **Resolution**: Tax compliance is maintained without manual friction.

### Journey 2: The "360-Degree Context" Path (Sales Manager)
*   **Situation**: A Sales Manager opens a CRM Lead and views the full history of Sales Orders and Subscriptions in one view.
*   **Climax**: The Manager is fully briefed on the customer's value and recent changes before making a call.
*   **Resolution**: Increased sales effectiveness through immediate data accessibility.

### Journey 3: The "Stable Operations" Path (System Admin)
*   **Situation**: An Admin approves a TRN change and generates a PO from a confirmed Sales Order.
*   **Climax**: The PO is created instantly without errors, carrying over all line dates from the SO.
*   **Resolution**: Seamless back-office workflow from sales to procurement.

## Functional Requirements

### Partner & Lead Management
*   **FR1**: System can designate a partner as an "AMC Customer" to trigger automated product additions on quotes.
*   **FR2**: System can manage a "Push to Zoho" flag to control individual partner data synchronization.
*   **FR3**: System hides internal integration fields (e.g., "Is created in Zoho") from standard users.
*   **FR4**: Sales Managers can view a unified history of Sales Orders and Subscriptions directly within the CRM Lead list view.

### Portal & Compliance
*   **FR5**: Portal users can submit updates to their TRN, which are held in a "pending approval" state.
*   **FR6**: Administrators can review, approve, or reject pending TRN change requests from the backend.
*   **FR7**: System controls portal "Subscription" button visibility based on product configuration and a 7-day waiting period.

### Subscription & Financial Operations
*   **FR8**: System allows adding vendor references and operational remarks to subscription packages.
*   **FR9**: System automatically calculates day-basis prorated credits and generates credit notes for subscription downgrades.
*   **FR10**: System captures and displays "Start Date" and "End Date" for all subscription and purchase transaction lines.

### Sales & Purchase Integration
*   **FR11**: System can generate Purchase Orders directly from **Confirmed Sales Orders**.
*   **FR12**: System performs an integrity check before PO generation to prevent failure.
*   **FR13**: System must **prevent and error out** if a user attempts to create a PO from a **Sales Quote** (Draft).
*   **FR14**: Sales Order records must maintain and display a unique version number for audit tracking.

## Non-Functional Requirements
*   **Performance**: Portal page transitions must complete within **1.5 seconds**.
*   **Security**: All administrative actions must be restricted via Odoo RBAC and captured in a non-deletable audit log.
*   **Reliability**: Zoho synchronization must include a retry mechanism for API downtime.
*   **Precision**: All financial calculations must maintain a precision of **two decimal places**.

## Technical Specifications (Odoo 17)
*   **Architecture**: Multi-module Odoo 17 customization (MVC) using Python 3.x and PostgreSQL.
*   **Inheritance**: Use standard Odoo `_inherit` for `res.partner`, `sale.order`, and `purchase.order`.
*   **Portal**: QWeb template overrides for conditional visibility and status messaging.
