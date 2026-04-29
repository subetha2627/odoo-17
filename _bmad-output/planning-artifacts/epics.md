---
stepsCompleted: ['Step 1: Validate Prerequisites and Extract Requirements', 'Step 2: Design Epic List', 'Step 3: Generate Epics and Stories', 'Step 4: Final Validation']
inputDocuments: [
  'e:/odoo/odoo-17/_bmad-output/planning-artifacts/prd.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/architecture.md'
]
---

# AdigiElite IT Service Improvements - Epic Breakdown

## Overview

This document provides the complete epic and story breakdown for AdigiElite IT Service Improvements, decomposing the requirements from the PRD and Architecture requirements into implementable stories.

## Requirements Inventory

### Functional Requirements

*   **FR1**: System can designate a partner as an "AMC Customer" via a dedicated checkbox.
*   **FR2**: System can automatically append specific products to sales quote lines when an AMC Customer is selected.
*   **FR3**: System can manage a "Push to Zoho" flag to control individual partner data synchronization.
*   **FR4**: System can hide internal integration fields (e.g., "Is created in Zoho") from non-admin users.
*   **FR5**: Sales Managers can view a unified history of Sales Orders and Subscriptions directly within the CRM Lead list view.
*   **FR6**: Portal users can submit updates to their Tax Registration Number (TRN).
*   **FR7**: System must hold portal TRN changes in a "pending approval" state, preventing immediate database updates.
*   **FR8**: Administrators can review, approve, or reject pending TRN change requests from the backend.
*   **FR9**: System controls the visibility of the "Subscription" portal button based on the product’s "Allow Upgrade" configuration.
*   **FR10**: System can enforce a 7-day waiting period before allowing portal-based subscription upgrades.
*   **FR11**: Portal users can view the real-time approval status of their submitted TRN changes.
*   **FR12**: System allows the addition of vendor references and operational remarks to subscription package records.
*   **FR13**: System can calculate prorated credits for subscription downgrades using a daily calculation method.
*   **FR14**: System can automatically generate and post credit notes for the unused portion of a subscription period.
*   **FR15**: System captures and displays "Start Date" and "End Date" for all subscription transaction lines.
*   **FR16**: System can generate Purchase Orders directly from Confirmed Sales Orders.
*   **FR17**: System performs an integrity check before PO generation to prevent "Error while creating PO" failures.
*   **FR18**: Purchase Order lines must include and display "Start Date" and "End Date" after the unit of measure.
*   **FR19**: Sales Order records must maintain and display a unique version number for audit and tracking purposes.
*   **FR20**: System ensures billing date consistency (Start/End) across Sales Orders, Purchase Orders, and Invoices.
*   **FR23**: System must prevent and error out if a user attempts to create a Purchase Order from a Sales Quote (Draft state).
*   **FR21**: System can display "Start Date" and "End Date" on all customer Invoice lines.
*   **FR22**: System maintains a persistent audit trail for all automatically generated financial corrections.

### NonFunctional Requirements

*   **NFR1**: All portal page transitions (specifically the Subscription management and TRN status views) must complete within 1.5 seconds.
*   **NFR2**: Background financial processing, such as prorated credit note generation, must complete within 3 seconds without blocking other user actions.
*   **NFR3**: All portal data transmissions must be secured via HTTPS/TLS 1.2+.
*   **NFR4**: Access to sensitive administrative actions (approving TRN changes, toggling Zoho sync) must be restricted to authorized Administrator roles via Odoo's RBAC system.
*   **NFR5**: Every TRN modification and AMC status change must be captured in a persistent, non-deletable audit log (Odoo Chatter/Mail Tracking).
*   **NFR6**: The Zoho synchronization must include a retry mechanism and error notification system to handle external API downtime gracefully.
*   **NFR7**: The Sales-to-Purchase PO generation must maintain transactional integrity—if the process fails at any point (e.g., due to a validation error), the database must roll back to prevent partial or "ghost" records.
*   **NFR8**: Automated prorating calculations must maintain a precision of two decimal places for all currency values to ensure audit compliance.

### Additional Requirements

*   **Brownfield Integration**: Must inherit from the existing `adigielite_it_service` and `subscription_package` modules.
*   **Odoo 17 Context**: Requirements are tailored for Odoo 17 framework and existing Epic 21 foundation.

### UX Design Requirements

*   *None explicitly documented in a separate file.*

### FR Coverage Map

*   **FR1-FR4**: Epic 25 - Partner & Zoho Control
*   **FR5**: Epic 28 - CRM History
*   **FR6-FR8**: Epic 26 - TRN Approval
*   **FR9-FR11**: Epic 26 - Portal Upgrades
*   **FR12**: Epic 28 - Subscription Remarks
*   **FR13-FR15**: Epic 27 - Prorating & Line Dates
*   **FR16-FR18**: Epic 28 - PO Stability & Dates
*   **FR19-FR20**: Epic 28 - Versioning & Consistency
*   **FR21-FR22**: Epic 27 - Invoice Dates & Audit
*   **FR23**: Epic 28 - Quote-to-PO Blocking

## Epic List

### Epic 25: Partner Intelligence & Sync Governance
Admins can precisely control which customers receive AMC perks and which records are synchronized with Zoho, reducing data noise.
**FRs covered:** FR1, FR2, FR3, FR4

### Epic 26: Secure Customer Portal & TRN Compliance
Customers can self-serve their tax information and upgrades with high confidence, while the system enforces a secure administrative approval cycle.
**FRs covered:** FR6, FR7, FR8, FR9, FR10, FR11

### Epic 27: Automated Financial Prorating & Auditability
Accountants eliminate manual billing corrections for downgrades, and customers gain 100% visibility into billing periods via Start/End dates on all documents.
**FRs covered:** FR13, FR14, FR15, FR21, FR22

### Epic 28: Operational Integrity & Sales-to-Purchase Stability
Sales teams can safely generate Purchase Orders from confirmed orders without system crashes and access a full transactional history directly within the CRM.
## Epic 25: Partner Intelligence & Sync Governance

Admins can precisely control which customers receive AMC perks and which records are synchronized with Zoho, reducing data noise.

### Story 25.1: AMC Customer Classification
As an Admin,
I want to mark specific customers as "AMC Customers",
So that the system knows to apply special quote logic to them.

**Acceptance Criteria:**
**Given** I am on a Customer record (res.partner)
**When** I view the form
**Then** I should see an "AMC Customer" checkbox (placed below relationship_type)
**And** toggling this checkbox should persist in the database.

### Story 25.2: Automatic AMC Product Addition to Quotes
As a Salesperson,
I want the system to automatically add AMC products to my quotes when I select an AMC customer,
So that I don't forget to include essential service items.

**Acceptance Criteria:**
**Given** a Partner is marked as "AMC Customer"
**When** I create a new Sales Quote (sale.order) and select that Partner
**Then** the pre-defined AMC product should be automatically appended to the order lines.

### Story 25.3: Zoho Synchronization Governance
As an Admin,
I want to control which partners are synced to Zoho using a manual toggle,
So that I can prevent test or irrelevant data from cluttering our Zoho environment.

**Acceptance Criteria:**
**Given** I am on a Partner record
**When** I view the integration settings
**Then** I should see a "Push to Zoho" checkbox
**And** the existing Zoho sync connector should only trigger if this checkbox is enabled.

### Story 25.4: Integration Field Visibility Cleanup
As a Sales User,
I want to hide internal Zoho status fields,
So that the interface remains clean and focused on my daily sales tasks.

**Acceptance Criteria:**
## Epic 26: Secure Customer Portal & TRN Compliance

Customers can self-serve their tax information and upgrades with high confidence, while the system enforces a secure administrative approval cycle.

### Story 26.1: Portal TRN Update Request
As a Customer,
I want to request an update to my Tax Registration Number (TRN) via the portal,
So that my invoices reflect my current tax status.

**Acceptance Criteria:**
**Given** I am logged into the Customer Portal
**When** I navigate to my Account details and change my TRN
**Then** the system should display a message stating the change is "Pending Approval"
**And** the actual Partner record in Odoo should NOT be updated until approved.

### Story 26.2: Admin TRN Approval Workflow
As an Admin,
I want to review and approve TRN changes requested by customers,
So that we ensure tax compliance before updating our master records.

**Acceptance Criteria:**
**Given** a customer has requested a TRN update
**When** I log into the Odoo backend
**Then** I should see a pending request for that Partner
**And** I should be able to "Approve" or "Reject" the change
**And** on Approval, the Partner's TRN field should be automatically updated.

### Story 26.3: Portal TRN Approval Status Visibility
As a Customer,
I want to see the status of my TRN update request,
So that I know when it has been officially processed.

**Acceptance Criteria:**
**Given** I have a pending TRN update
**When** I view my Account page in the portal
**Then** I should see the current status (e.g., "Pending Approval").

### Story 26.4: Conditional Subscription Portal Visibility
As a Customer,
I want to see a "Subscription" button in my portal only for eligible products,
So that I only attempt upgrades on supported plans.

**Acceptance Criteria:**
**Given** a Product is configured with "Allow Upgrade" checked in its Subscription tab
**When** I view my portal dashboard
**Then** the "Subscription" button should be visible
**And** if "Allow Upgrade" is unchecked, the button should remain hidden.

### Story 26.5: Subscription Upgrade 7-Day Guardrail
As a Customer,
I want the system to enforce a 7-day minimum period before I can upgrade my subscription,
So that we prevent rapid billing cycling and administrative overhead.

**Acceptance Criteria:**
## Epic 27: Automated Financial Prorating & Auditability

Internal teams across Sales, Admin, Technical, and Accounting departments eliminate manual billing corrections and gain 100% visibility into billing periods via Start/End dates on all documents.

### Story 27.1: Start and End Dates on Line Items
As an Internal User (Sales, Admin, Tech, or Accountant),
I want to see Start and End dates for every product line on my transactions,
So that I can clearly audit service periods without manual calculations.

**Acceptance Criteria:**
**Given** I am viewing a Sales Order, Purchase Order, or Invoice
**When** I look at the product line items
**Then** I should see "Start Date" and "End Date" fields after the Unit of Measure.
**And** these dates should persist and carry through from the Sales Order to the generated Invoice.

### Story 27.2: Day-Basis Prorating Engine
As a System Administrator or Accountant,
I want the system to calculate the exact unused portion of a subscription when it is decreased,
So that we ensure absolute financial accuracy and never overcharge customers.

**Acceptance Criteria:**
**Given** a subscription quantity or plan is being decreased
**When** the system calculates the credit amount
**Then** it should calculate the daily rate (Total Price / Total Days in Billing Period)
**And** multiply by the remaining days in the current cycle
**And** the result must be accurate to 2 decimal places.

### Story 27.3: Automated Credit Note Generation
As a Customer,
I want to receive an automatic credit note when my subscription is decreased,
So that my account balance is updated immediately without manual intervention.

**Acceptance Criteria:**
**Given** a subscription decrease has been finalized
**When** the prorated amount is calculated by the engine
**Then** the system should automatically generate and post a Credit Note
**And** the Credit Note lines must explicitly list the "Start Date" and "End Date" for the credited period.

### Story 27.4: Financial Correction Audit Trail
As a Manager or Auditor (Sales, Admin, or Finance),
I want to trace exactly why a credit note was generated,
So that I can justify the adjustment during a financial audit.

**Acceptance Criteria:**
**Given** an automatically generated credit note
**When** I view the record chatter or logs
## Epic 28: Operational Integrity & Sales-to-Purchase Stability

Sales teams can safely generate Purchase Orders from confirmed orders without system crashes and access a full transactional history directly within the CRM.

### Story 28.1: Confirmed Sales-to-Purchase Blocking
As a Sales Admin,
I want the system to prevent Purchase Order generation from Sales Quotes,
So that we ensure procurement only starts after a customer has officially confirmed the order.

**Acceptance Criteria:**
**Given** a Sales record is in the "Draft" (Quote) state
**When** I attempt to trigger the Purchase Order generation action
**Then** the system should block the action and display an error message: "Purchase Orders can only be generated from Confirmed Sales Orders."

### Story 28.2: Stable Sales-to-Purchase PO Generation
As a Procurement Officer,
I want to generate a Purchase Order from a confirmed Sales Order without system errors,
So that our back-office procurement workflow is seamless and error-free.

**Acceptance Criteria:**
**Given** a confirmed Sales Order
**When** I trigger the "Create Purchase Order" action
**Then** the system must perform a pre-check for valid product/vendor configurations
**And** on success, create the linked Purchase Order
**And** on failure (e.g., missing vendor), display a specific user-friendly message identifying the issue rather than a generic system crash.

### Story 28.3: Unified Transactional History in CRM
As a Sales Manager,
I want to see a full history of related Sales Orders and Subscriptions directly within the CRM Lead view,
So that I have a complete 360-degree context of the customer relationship before a call.

**Acceptance Criteria:**
**Given** I am viewing a CRM Lead
**When** I check the transactional history section
**Then** I should see a combined list of all related Sales Orders and Subscription Packages
**And** the list should allow direct navigation to those records.

### Story 28.4: Sales Order Versioning
As a Salesperson,
I want the system to maintain a version number for my Sales Orders,
So that I can track revisions and audit the history of a deal.

**Acceptance Criteria:**
**Given** a Sales Order record
**When** I view the header section
**Then** I should see a "Version Number" field (placed above the Parent Partner field)
**And** the system should track increments to this version as the order evolves.

### Story 28.5: Subscription Package Operation Remarks
As an Operations Manager,
I want to add vendor references and remarks to subscription packages,
So that I can track fulfillment details and vendor-specific communications.

**Acceptance Criteria:**
**Given** I am viewing a Subscription Package
**When** I navigate to the "Operation Request" tab
**Then** I should see editable fields for "Vendor Reference" and "Remarks".
