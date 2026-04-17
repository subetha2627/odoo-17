# PRD: Customer Portal

**Constraint**: All custom logic and frontend overrides must reside in `adigielite_it_service`.

## Overview
Enhance the transparency and self-service capabilities of the customer portal, providing easy access to documents, product management, and contact support.

## Requirements

### 1. Document Visibility
- **Sales Orders**: Enable customers to view and download their Sales Orders (PDF format) directly from the portal.
- **Subscriptions**: Enable customers to view and download their Subscription details.

### 2. Interactive Product Management
- **Quantity Controls**: Add `+1` and `-1` adjustment buttons next to products/subscriptions in the portal view to allow customers to easily modify quantities for requests.

### 3. Support & Communication
- **Support Contacts**: Display the contact details for the customer's dedicated team:
  - **Account Manager**: Name, Mobile, Business Email.
  - **Sales Person**: Name, Mobile, Business Email.
- **Helpdesk Integration**: Leverage **Softhealer All-In-One Website Helpdesk** (`sh_all_in_one_website_helpdesk`) for customer-facing ticket creation and status tracking.

## User Experience
- Portal UI should be intuitive, with clear calls to action for downloading documents.
- Support contact info should be visible on the main account dashboard or a dedicated "Contact Us" section within the portal.
- All frontend customizations (CSS/SCSS or QWeb template overrides) for Softhealer widgets must be stored in `adigielite_it_service/static/`.
