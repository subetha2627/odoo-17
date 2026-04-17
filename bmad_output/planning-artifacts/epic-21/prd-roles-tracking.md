# PRD: Role Privileges, Tracking & Communication

**Constraint**: All custom logic and inheritance must reside in `adigielite_it_service`.

## Overview
Define granular role access, enhance task tracking within projects, and automate customer engagement through surveys and domain-based communication history.

## Requirements

### 1. Multi-Role Permissions
Define specific access levels for the following roles across key modules (Lead, SO, Invoice, Products, Tickets):
- **Admin**: Full access to configuration and data.
- **Sales**: Focus on Lead, Quote, and Opportunity management.
- **Account Manager**: Focus on Customer Registration, Approval, and Subscription management.
- **Technical Team**: Focus on Tickets, Task execution, and fulfillment.

### 2. Advanced Task Tracking
Enhance task management within the system (specifically for Technical/Service tasks):
- **Fields**:
  - `Status`
  - `Start Date` & `End Date`
  - `% Complete`
- **Hierarchical Tasks**: Support for **Sub-tasks** to break down complex fulfillment processes.

### 3. Customer Domain & Communication History
- **Unified Customer History**: Provide a 360-degree view of all communication (Quotes, Invoices, Tickets) at the Customer level.
- **Multi-User Email Support**: Allow multiple users to send emails linked to the same customer account.
- **Domain-Based Mapping**:
  - Automatically link incoming emails to the Customer record based on the sender's domain.
  - Track `Message ID` for precise threading and reference.

### 4. Tracking, SLA & Surveys
- **SLA Management**: Leverage **Softhealer SLA Policies** for tickets, with automated alerts for upcoming or breached deadlines.
- **Automated Feedback**:
  - Automatically trigger the **Softhealer Ticket Feedback Template** after ticket resolution.
  - Automatically send a **Feedback Form** after sales order completion or subscription activation (custom logic in `adigielite_it_service`).

## Development Note
All custom SLA alerts or feedback trigger overrides must be implemented via inheritance of Softhealer models within the `adigielite_it_service` module.
