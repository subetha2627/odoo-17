# PRD: Customer Registration & Account Management

**Constraint**: All custom logic and inheritance must reside in `adigielite_it_service`.

## Overview
Enhance the customer registration and account management lifecycle, focusing on validation of critical documents (VAT, Trading License) and structured approval/rejection workflows.

## Requirements

### 1. Customer Registration Flow
- **Registration Success Page**: Upon successful submission, display a confirmation page stating: "Registration Successful. You will receive an email after approval."
- **Automated Notifications**:
  - Send email notifications to both the **Admin** and the **Customer** immediately after registration submission.
  - Send an **Approval Email** to the customer once their account is verified by the team.

### 2. Document Validation (VAT & Trading License)
- **New Fields**:
  - `VAT Number` and `Trading License Number`.
  - `VAT Attachment` and `Trading License Attachment`.
  - `VAT Expiry Date` and `Trading License Expiry Date`.
- **Validation Logic**:
  - Ensure the VAT and License numbers follow standard formats.
  - Expiry dates must be validated upon entry and periodically.
- **Expiry Consequences**:
  - If a document is expired, the customer **must be blocked from logging in**.
  - An **alert email** must be sent to the customer upon expiration.

### 3. Backend Approval/Rejection Workflow
- **Approval Ticketing**: Automatically create and assign an **Approval Ticket** (`sh.helpdesk.ticket`) to the Relevant Team upon registration.
- **Clarification Loop**:
  - If additional details are needed, move the ticket to the **Clarification Needed** stage and provide a secure link to the customer.
  - Once the customer updates their details, move the ticket to **Ready for AM Review** and notify the **Account Manager** via email.
- **Approval Action**:
  - Upon approval (moving ticket to **Approved**), trigger automated emails and update the Partner record.
- **Rejection Action**:
  - Admins can reject an account (move ticket to **Rejected**).
  - A **Rejection Reason** must be captured and sent to the customer via email.

### 4. Continuous Account Monitoring (VAT/License Renewal)
- **Portal Visibility**: Customers should see a list of "Near Expiry Items" (expiring in the next month only).
- **Proactive Alerts**:
  - Send a notification/alert to the customer **1 month before** document expiry.
  - Generate an **Expiration Audit Ticket** (`sh.helpdesk.ticket`) in the "Review" stage for admin tracking.
- **Renewal Blocking**:
  - If documents are not updated post-notification, the customer's login must be blocked.
  - Notify both the customer and admin regarding the lockout.

## User Roles
- **Customer**: Registers and updates documentation via portal.
- **Account Manager**: Responsible for reviewing and approving/rejecting registrations.
- **Admin**: General oversight and management of the approval ticketing system.

## Success Metrics
- 0% of customers with expired licenses can access the portal logic.
- Automated email triggers (Success, Approval, Rejection, Expiry Alert) function without manual intervention.
