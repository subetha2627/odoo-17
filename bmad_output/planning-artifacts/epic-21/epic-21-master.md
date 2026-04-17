# Epic 21: IT Services Module Enhancements (Master)

This document provides an overview of Epic 21 for the `adigielite_it_service` Odoo 17 module. The requirements are distributed across several functional area PRDs for clarity and modular development.

## Functional Area Documents

1. [Registration & Account Management](prd-registration-account.md)
   - Focus: Signup flow, VAT/License validation, Approval/Rejection processes.
2. [CRM & Lead Management](prd-crm-leads.md)
   - Focus: Lead sources, ticket creation from leads, opportunity conversion.
3. [Customer Portal](prd-portal.md)
   - Focus: Sales Order/Subscription views, quantity management, contact info.
4. [Sales & Quotation](prd-sales-orders.md)
   - Focus: Multi-currency, GP calculation, PO/Subscription creation buttons.
5. [Opportunity & Forecasting](prd-opportunity-forecast.md)
   - Focus: Alerts for start dates, forecast status management.
6. [Purchase Order Management](prd-purchase-orders.md)
   - Focus: Multi-vendor handling and automated PO creation.
7. [Helpdesk & Ticketing](prd-helpdesk-ticketing.md)
   - Focus: Email integration, service dashboard, portal support.
8. [Roles & Tracking](prd-roles-tracking.md)
   - Focus: Role privileges, SLA, tracking, surveys.

## General Project Context
- **Module Name**: `adigielite_it_service` (Primary Module)
- **Base Platform**: Odoo 17
- **Key Dependencies**:
  - `crm`, `sale`, `purchase`, `account`, `portal`, `website`
  - `sh_all_in_one_helpdesk` (Softhealer Core)
  - `sh_all_in_one_website_helpdesk` (Softhealer Website)
  - `subscription_package`

## Development Constraints
- **Single Module Policy**: All custom development, including inheriting models from Softhealer Helpdesk or standard Odoo apps, must reside exclusively within the `adigielite_it_service` module.
- **Dependency Alignment**: All references to Helpdesk within PRDs refer to the `sh.helpdesk.ticket` model.
