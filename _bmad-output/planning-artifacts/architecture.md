---
stepsCompleted: [1, 2, 3, 4, 5, 6, 7, 8]
inputDocuments: [
  'e:/odoo/odoo-17/_bmad-output/planning-artifacts/prd.md',
  'e:/odoo/odoo-17/_bmad-output/planning-artifacts/epics.md',
  'e:/odoo/odoo-17/bmad_output/planning-artifacts/epic-21/architecture.md'
]
workflowType: 'architecture'
lastStep: 8
status: 'complete'
project_name: 'odoo-17'
user_name: 'Subetha'
date: '2026-04-29'
completedAt: '2026-04-29'
---

# Architecture Decision Document

_This document builds collaboratively through step-by-step discovery. Sections are appended as we work through each architectural decision together._

## Project Context Analysis

### Requirements Overview

**Functional Requirements:**
The architecture must support a dual-layer approach: 1) Enhancing core Odoo models (`res.partner`, `sale.order`, `account.move`) with new business logic like AMC status and versioning, and 2) Extending the Customer Portal with conditional UI logic and approval-status feedback loops.

**Non-Functional Requirements:**
*   **Financial Accuracy**: Prorating must use `float_round` with 2-decimal precision (NFR8).
*   **Stability**: The PO generation action must use a "Dry Run" or validation pattern before execution (NFR7).
*   **Security**: TRN approvals must be restricted to specific Odoo groups (Admin) (NFR4).
*   **Auditability**: All TRN and AMC changes must trigger Odoo Chatter logs (NFR5).

**Scale & Complexity:**
*   Primary domain: Odoo 17 Backend/Portal
*   Complexity level: Medium-High
*   Estimated architectural components: ~6 (Models, Portal Controllers, Wizards for TRN approval, Automated Actions for Prorating, View Overrides, and Integration Hooks)

### Technical Constraints & Dependencies

- **Brownfield Inheritance**: Must inherit from the existing `adigielite_it_service` and `subscription_package` modules.
- **Odoo 17 Logic**: Must adhere to Odoo 17's ORM and Portal controller patterns.

### Cross-Cutting Concerns Identified

- **Audit Trail**: Unified tracking across partner and financial changes.
- **Date Consistency**: Synchronization of Start/End dates across SO, PO, and Invoices.

## Starter Template Evaluation

### Primary Technology Domain

ERP (Odoo 17 Enterprise) based on project requirements and existing infrastructure.

### Starter Options Considered

1.  **Fresh Module (Greenfield)**: Creating a new module for "Corrections-1".
2.  **Existing Module Extension (Brownfield)**: Extending `adigielite_it_service` and `subscription_package`.

### Selected Starter: Brownfield Extension

**Rationale for Selection:**
The requirements are direct improvements to existing features (Zoho sync, portal TRN, subscription logic). Extending the current codebase ensures data continuity and reduces deployment complexity.

**Initialization Command:**
N/A (Using existing Odoo 17 project structure).

**Architectural Decisions Provided by Starter:**

**Language & Runtime:**
Python 3.10+ and Odoo 17 ORM.

**Styling Solution:**
Odoo's native QWeb templates and standard SCSS/CSS.

**Build Tooling:**
Odoo's standard asset management system.

**Testing Framework:**
Odoo's native `unittest` and `HttpCase` for portal testing.

**Code Organization:**
Standard Odoo 17 module structure:
- `models/`: Backend logic and data models.
- `views/`: Backend XML views.
- `controllers/`: Portal and web request handlers.
- `data/`: XML data files (groups, cron jobs).
- `static/`: JS and CSS assets.

**Development Experience:**
Native Odoo development workflow with Docker-based environment.

## Core Architectural Decisions

### Decision Priority Analysis

**Critical Decisions (Block Implementation):**
- **TRN Approval Model**: Using a dedicated `partner.update.request` model (Option B).
- **Prorating Logic**: Using a `subscription.prorated.credit` model for auditability (Option B).
- **Zoho Gate**: Implementing the "Push to Zoho" check at the connector level (Option B).

**Important Decisions (Shape Architecture):**
- **PO Protection**: Multi-layer protection (UI hiding + Server-side validation).
- **Date Consistency**: Inheriting Start/End dates across the transaction chain.

**Deferred Decisions (Post-MVP):**
- **Bulk TRN Approval**: Deferred until volume justifies it.

### Data Architecture

- **Prorating Engine**: Implement a daily rate calculation using Odoo's `float_round`.
  - **Version**: PostgreSQL 14+ (JSONB for historical parameters if needed).
  - **Rationale**: Ensures financial precision (NFR8) and transparent audit trails (FR22).
  - **Provided by Starter**: No (Custom Logic).

- **Subscription Metadata**: Add `vendor_reference` and `operation_remarks` to `subscription.package`.
  - **Rationale**: Meets FR12 operational requirements.

### Authentication & Security

- **TRN Approval Workflow**:
  - **Pattern**: Request-Review-Apply.
  - **Authorization**: Restricted to `base.group_system` or a custom "IT Manager" role.
  - **Rationale**: Ensures data integrity and compliance (NFR4).

- **Zoho Sync Toggle**:
  - **Pattern**: Gatekeeper pattern in the connector logic.
  - **Rationale**: Prevents accidental data leak to external systems.

### API & Communication Patterns

- **Sales-to-Purchase Bridge**:
  - **Pattern**: Pre-Validation Wizard.
  - **Rationale**: Performs integrity checks before record creation to ensure transactional integrity (NFR7).

### Frontend Architecture

- **Conditional Portal UI**:
  - **Approach**: QWeb Template overrides with server-side visibility flags.
  - **Rationale**: Provides a seamless UX while enforcing 7-day guardrails (FR10).

### Decision Impact Analysis

**Implementation Sequence:**
1. Data Model updates (Partner, SO, PO, Invoice fields).
2. Prorating Engine development.
3. Portal TRN Request controller.
4. Admin Approval workflow.
5. Zoho Sync integration.
6. PO Stability hardening.

**Cross-Component Dependencies:**
- TRN Portal view depends on the new `partner.update.request` model.
- Invoice generation depends on the Prorating Engine output.

## Implementation Patterns & Consistency Rules

### Pattern Categories Defined

**Critical Conflict Points Identified:**
4 areas where AI agents could make different choices (Naming, Logic Placement, Financial Math, and Portal Overrides).

### Naming Patterns

**Database & Model Naming:**
- **Models**: New models must use the `adigielite.` prefix. Example: `adigielite.partner.request`.
- **Fields**: Use `snake_case`. Booleans start with `is_` or `has_`. Example: `is_amc_customer`.
- **External IDs**: Use `view_[model_snake]_[type]`. Example: `view_res_partner_form_inherit_amc`.

### Structure Patterns

**Project Organization:**
- Follow standard Odoo 17 module structure within `adigielite_it_service` and `subscription_package`.
- Business logic MUST live in the Model layer (`models/`), not the Controller layer.

**File Structure Patterns:**
- XML views must be grouped by model. Example: `res_partner_views.xml`.

### Format Patterns

**Data Exchange Formats:**
- **Currency Math**: ALWAYS use `self.currency_id.round(value)` or `float_round(value, precision_digits=2)`.
- **Date Formatting**: Use Odoo's native Date/Datetime fields (ISO 8601 in DB).

### Communication Patterns

**Event System Patterns:**
- **Chatter**: Use `self.message_post()` for all status-related audit trails.

### Process Patterns

**Error Handling Patterns:**
- Use `odoo.exceptions.UserError` for business rule violations.
- Use `odoo.exceptions.ValidationError` for data integrity issues.

**Loading State Patterns:**
- Portal interactions should use standard Odoo portal "processing" or "loading" overlays.

### Enforcement Guidelines

**All AI Agents MUST:**
1. Check for existing field/model extensions before creating new ones.
2. Log all financial adjustments and TRN changes to the Chatter.
3. Inherit existing views using the most specific `xpath` possible to avoid UI conflicts.

### Pattern Examples

**Good Examples:**
- `self.message_post(body="TRN Update Approved")`
- `float_round(credit_amount, precision_digits=2)`

**Anti-Patterns:**
- `round(amount, 2)` (Standard Python round causes accounting errors).
- Putting prorating math inside a Portal Controller.

## Project Structure & Boundaries

### Complete Project Directory Structure

```text
e:\odoo\odoo-17\addons\
├── adigielite_it_service/
│   ├── models/
│   │   ├── res_partner.py              # AMC logic, Zoho toggles
│   │   ├── partner_update_request.py   # NEW: TRN Approval requests
│   │   ├── sale_order.py               # PO creation blocking & versioning
│   │   └── zoho_connector.py           # Zoho gatekeeper hooks
│   ├── controllers/
│   │   └── portal.py                   # TRN request handlers
│   ├── security/
│   │   ├── ir.model.access.csv         # Permissions for new request model
│   │   └── security.xml                # Admin group definitions
│   ├── views/
│   │   ├── res_partner_views.xml       # AMC/Zoho view extensions
│   │   ├── partner_request_views.xml   # NEW: Admin approval interface
│   │   ├── sale_order_views.xml        # Versioning field & PO buttons
│   │   ├── crm_lead_views.xml          # Unified history view
│   │   └── portal_templates.xml        # TRN request & status UI
│   └── data/
│       └── mail_template_data.xml      # TRN status notifications
└── subscription_package/
    ├── models/
    │   ├── subscription_package.py     # Remarks, Vendor Refs, Start/End dates
    │   ├── sale_order_line.py          # Line item date persistence
    │   ├── account_move_line.py        # Invoice line date persistence
    │   ├── prorated_credit.py          # NEW: Audit model for credits
    │   └── prorating_engine.py         # NEW: Pure logic for daily-math
    └── views/
        ├── subscription_views.xml      # Date columns & remarks
        └── report_invoice.xml          # Invoice PDF date display
```

### Architectural Boundaries

**API Boundaries:**
- **Zoho Connector**: The sync gate is implemented within the connector method itself, ensuring no data leaves Odoo if the toggle is off.
- **Portal Controllers**: Custom routes for TRN updates use CSRF protection and session validation.

**Component Boundaries:**
- **Approval Engine**: Buffers data in the `partner.update.request` model. This isolates the main Partner table from unverified portal input.

**Data Boundaries:**
- **Prorating Logic**: Isolated in a dedicated utility class/model to allow for easy unit testing without dependency on complex `sale.order` states.

### Requirements to Structure Mapping

**Feature/Epic Mapping:**
- **Epic 25 (Partner & Zoho)**: `adigielite_it_service` (res_partner.py, zoho_connector.py)
- **Epic 26 (Portal & TRN)**: `adigielite_it_service` (portal.py, partner_update_request.py, portal_templates.xml)
- **Epic 27 (Finance)**: `subscription_package` (prorating_engine.py, prorated_credit.py, transaction lines)
- **Epic 28 (Operations)**: `adigielite_it_service` (sale_order.py, crm_lead_views.xml)

**Cross-Cutting Concerns:**
- **Audit Trails**: Implemented via `message_post` across all Model extensions.
- **Date Consistency**: Handled via field relatedness or `onchange` logic in SO/PO/Invoice line models.

### Integration Points

**Internal Communication:**
- **SO to PO**: Via overridden `action_create_po` with integrated integrity checks.
- **Downgrade to Credit Note**: Triggered by the subscription package state change, invoking the prorating engine.

**External Integrations:**
- **Zoho Sync**: Outbound only, governed by the `push_to_zoho` flag.

## Architecture Validation Results

### Coherence Validation ✅

**Decision Compatibility:**
All technology choices (Python 3.10, PostgreSQL 14, Odoo 17) are natively compatible. The "Request Model" pattern for TRN updates perfectly supports the multi-layer security required.

**Pattern Consistency:**
Naming and structure patterns are aligned with standard Odoo development best practices, ensuring that any Odoo-specific AI agent will immediately understand the context.

**Structure Alignment:**
The directory structure within `adigielite_it_service` and `subscription_package` correctly separates new logic (Requests, Credits) from inherited extensions (Partner, SO).

### Requirements Coverage Validation ✅

**Epic/Feature Coverage:**
All 4 epics (25-28) have dedicated file locations and model strategies defined in the Project Structure.

**Functional Requirements Coverage:**
All 23 Functional Requirements are architecturally supported, with high-risk areas like TRN approval and PO stability receiving multi-layer protection.

**Non-Functional Requirements Coverage:**
NFR7 (PO Integrity) and NFR8 (Prorating Precision) are directly addressed via logic overrides and the `float_round` pattern.

### Implementation Readiness Validation ✅

**Decision Completeness:**
All critical decisions regarding data models, security workflows, and integration gates are documented.

**Structure Completeness:**
The project tree is specific to the existing Odoo module layout, providing a clear map for file creation.

**Pattern Completeness:**
All potential conflict points (naming, math, audit trails) are addressed with concrete examples.

### Gap Analysis Results

**Important Gaps Addressed:**
- **Prorating Math**: Added a concrete example for agents: `(Total / Days) * Remaining_Days` using `float_round`.
- **Security Groups**: Deferred exact group IDs to the implementation of the `security.xml` story in Epic 26.

### Architecture Completeness Checklist

**✅ Requirements Analysis**
- [x] Project context thoroughly analyzed
- [x] Scale and complexity assessed
- [x] Technical constraints identified
- [x] Cross-cutting concerns mapped

**✅ Architectural Decisions**
- [x] Critical decisions documented with versions
- [x] Technology stack fully specified
- [x] Integration patterns defined
- [x] Performance considerations addressed

**✅ Implementation Patterns**
- [x] Naming conventions established
- [x] Structure patterns defined
- [x] Communication patterns specified
- [x] Process patterns documented

**✅ Project Structure**
- [x] Complete directory structure defined
- [x] Component boundaries established
- [x] Integration points mapped
- [x] Requirements to structure mapping complete

### Architecture Readiness Assessment

**Overall Status:** READY FOR IMPLEMENTATION

**Confidence Level:** HIGH

**Key Strengths:**
- Robust auditability via the Request Model.
- Strict financial precision through the Prorating Engine utility.
- Clear governance of external integrations (Zoho Sync).

### Implementation Handoff

**AI Agent Guidelines:**
- Follow all architectural decisions exactly as documented.
- Use implementation patterns consistently across all components (especially naming and math).
- Respect project structure and boundaries (Model logic vs Controller preparation).
- Refer to this document for all architectural questions.

**First Implementation Priority:**
Initialize Data Models and Prorating Engine utility in the `subscription_package` and `adigielite_it_service` modules.
