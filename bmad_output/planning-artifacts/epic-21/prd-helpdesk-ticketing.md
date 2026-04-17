# PRD: Helpdesk & Ticketing Integration

## Overview
Fully integrate the ticketing system using the **Softhealer All-In-One Helpdesk** (`sh.helpdesk.ticket`) model. All customizations and technical overrides must reside within the `adigielite_it_service` module.

## Technical Foundation
- **Primary Model**: `sh.helpdesk.ticket`
- **Secondary Model**: `sh.helpdesk.team`
- **Dependency**: `sh_all_in_one_helpdesk`

## Requirements

### 1. Email Channel Integration
- **Helpdesk Integration**: Synchronize the Helpdesk system with incoming and outgoing support emails.
- **Unified Sending**: Enable internal users to send emails directly from the Ticket interface using their individual user accounts or the shared support alias.

### 2. Portal Support (Self-Service)
- **Portal Ticketing**: Allow customers to create and view tickets via the Customer Portal.
- **Ticketing Options**: Provide categories for specific support types (Technical, Billing, Subscriptions).

### 3. Service Dashboard & Queues
- **Dashboard**: Leverage Softhealer's native Helpdesk Dashboard for tracking.
- **Service Person View**:
  - `Active Tickets`
  - `Pending Tasks` (Linked to ticket task info)
  - `Priority Levels` (Native Softhealer priorities)
  - `Expected Resolution Date` (SLA based)

### 4. Approval Workflow Stages
To support the Customer Registration lifecycle, the following stages must be configured/inherited in `sh.helpdesk.ticket`:
- **Draft**: Initial entry for internal drafting.
- **Pending Approval**: Ticket submitted and awaiting first-level review.
- **Clarification Needed**: Ticket sent back to the customer/stakeholder for more info.
- **Ready for AM Review**: First level complete, awaiting final Account Manager sign-off.
- **Approved**: Finalized and success communicated.
- **Rejected**: Finalized and rejection reason communicated.

## Development Note
All Stage transitions and linked notification logic for these specific stages must be implemented in `adigielite_it_service` via inheritance of `sh.helpdesk.ticket`.
