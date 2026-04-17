# Epics and User Stories: Epic 21 (IT Services)

This document contains the granular backlog for the development of Epic 21. All custom code must be implemented within the `adigielite_it_service` module.

---

## Epic 1: Customer Registration & Document Lifecycle (AD-REG)
**Goal**: Implement a robust onboarding process with document validation and restrictive access for expired entities.

### AD-REG-01: Document Fields & Frontend Validation
- **Description**: Add VAT and Trading License fields to the `res.partner` model and registration form.
- **Acceptance Criteria**:
    - [x] Fields added: `vat_number`, `license_number`, `vat_attachment`, `license_attachment`, `vat_expiry_date`, `license_expiry_date`.
    - [x] Registration form includes these fields with mandatory validation.
    - [x] Basic format validation for VAT and License numbers.
- **Technical Note**: Inherit `res.partner` in `adigielite_it_service`.

### AD-REG-02: Backend Approval Workflow (Ticketing)
- **Description**: Automate the creation of a Softhealer Helpdesk ticket for each new registration.
- **Acceptance Criteria**:
    - [x] Upon registration submit, create `sh.helpdesk.ticket` assigned to the **Verification Team**.
    - [x] Ticket stages synced with Partner registration status (Pending -> Clarification -> AM Review -> Approved/Rejected).
    - [x] Automated emails triggered on stage changes (Success, Approval, Rejection).
- **Technical Note**: Use `create` override on `res.partner` or a post-registration hook.

### AD-REG-03: Expiry Monitoring & Restricted Portal Access
- **Description**: Implement a daily check for document expiry and restrict portal access for expired accounts.
- **Acceptance Criteria**:
    - [ ] Daily cron job checks for expiry at T-30 days (send alert) and T-0.
    - [ ] Upon document expiry, customer is allowed to login but **restricted** to a portal view that only shows the document update form.
    - [ ] Normal portal menus remain hidden until verification is complete.
- **Technical Note**: Override `_compute_is_portal_user_active` or use a record rule in `adigielite_it_service`. 

---

## Epic 2: Sales Workflow & Margin Analysis (AD-SALE)
**Goal**: Enhance quotations with financial depth and automated fulfillment triggers.

### AD-SALE-01: Quotation Margin & GP Analysis
- **Description**: Add cost and margin visibility to Sales Order lines.
- **Acceptance Criteria**:
    - [ ] `cost_price`, `vendor_id`, and `gross_profit` fields added to `sale.order.line`.
    - [ ] Margin approval threshold implemented: If Margin < X%, mark SO for "Margin Approval Required".
- **Technical Note**: Inherit `sale.order.line` and `sale.order`.

### AD-SALE-02: Subscription & PO Generation
- **Description**: Add buttons to create Subscriptions and POs directly from the SO.
- **Acceptance Criteria**:
    - [ ] "Create Purchase Order" button generates POs grouped by Vendor.
    - [ ] "Create Subscription" button creates records in `subscription_package`.
    - [ ] Automated fulfillment tracking ticket created in Softhealer upon generation.
- **Technical Note**: Use custom service methods in `adigielite_it_service`.

---

## Epic 3: CRM & Opportunity Forecasting (AD-CRM)
**Goal**: Improve lead follow-up and pipeline accuracy.

### AD-CRM-01: Lead Source & Support Follow-up
- **Description**: Track lead sources and enable direct ticketing for complex follow-ups.
- **Acceptance Criteria**:
    - [ ] "Create Ticket" button on Lead form creates a `sh.helpdesk.ticket`.
    - [ ] Lead source tracking preserved during conversion to Opportunity.
- **Technical Note**: Inherit `crm.lead`.

### AD-CRM-02: Opportunity Forecast Alerts
- **Description**: Implement alerts for upcoming opportunity start dates.
- **Acceptance Criteria**:
    - [ ] Automated alert sent to Salesperson 1 month before Opportunity start date.
    - [ ] Forecast status mapping (30%, In progress, etc).
- **Technical Note**: Daily cron check on `crm.lead` (Opportunities).

---

## Epic 4: Customer Portal & Support (AD-PORTAL)
**Goal**: Improve customer self-service and support visibility.

### AD-PORTAL-01: Product Catalog & Quantity Controls
- **Description**: Add interactive controls to product lists in the portal.
- **Acceptance Criteria**:
    - [ ] `+1` and `-1` quantity adjustment buttons on portal product lists.
    - [ ] Role-based visibility for Catalog items.
- **Technical Note**: QWeb template overrides in `adigielite_it_service/views/portal_templates.xml`.

### AD-PORTAL-02: "My Support Team" Widget
- **Description**: Show dedicated contact info on the portal dashboard.
- **Acceptance Criteria**:
    - [ ] Widget displays Account Manager and Sales Person (Name, Mobile, Email).
- **Technical Note**: New portal controller/template.

---

## Epic 5: Helpdesk & Tracking Optimization (AD-HELP)
**Goal**: Leverage Softhealer for structured service delivery.

### AD-HELP-01: SLA & Automated Feedback
- **Description**: Automate customer feedback after ticket or SO completion.
- **Acceptance Criteria**:
    - [ ] SLA alerts triggered 2 hours before deadline (Softhealer config + custom check).
    - [ ] Feedback form triggered automatically upon ticket resolution.
- **Technical Note**: Configuration logic and `message_post` hooks.
