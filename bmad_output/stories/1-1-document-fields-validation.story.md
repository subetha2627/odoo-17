# Story: AD-REG-01 - Document Fields & Validation

**Status**: `ready-for-dev`
**Role**: `res.partner`
**Last Updated**: 2026-04-13

---

## 📖 User Story
**As a** Verification Specialist,
**I want** to capture and validate a customer's VAT and Trading License details,
**so that** I can ensure legal compliance and track document expiry.

---

## ✅ Acceptance Criteria (BDD)

### AC-01: Data Model Enrichment
**GIVEN** a Partner record,
**WHEN** the system is initialized,
**THEN** the following fields must be available on `res.partner`:
- `vat_number` (Char)
- `license_number` (Char)
- `vat_attachment` (Binary)
- `license_attachment` (Binary)
- `vat_expiry_date` (Date)
- `license_expiry_date` (Date)

### AC-02: Backend View Integration
**GIVEN** an Account Manager viewing a Partner form,
**WHEN** they look at the Notebook,
**THEN** they see a new "Documentation" tab containing the new fields.

### AC-03: Format Validation
**GIVEN** a new VAT or License number is entered,
**WHEN** the record is saved,
**THEN** the system must validate basic formatting (non-empty, alphanumeric).

### AC-04: Portal Signup Wizard Enhancements
**GIVEN** a public user attempting to register,
**WHEN** they navigate the 3-step signup wizard,
**THEN** they must provide:
- **Step 1**: Password & Confirm Password (mandatory). Includes visibility toggle icon.
- **Step 2**: VAT Registration Document (mandatory if VAT registered).
- **Step 2**: Account Currency (selected from active Odoo currencies).

---

## 🏗️ Technical Guardrails

- **Module**: `adigielite_it_service`
- **Model Inheritance**:
    ```python
    class ResPartner(models.Model):
        _inherit = 'res.partner'
    ```
- **Constraint Logic**: Use `@api.constrains('vat_number', 'license_number')` for validation.
- **View ID**: Inherit `base.view_partner_form` and use `xpath` to insert the new page.

---

## 🔬 Developer Context & Insights

- **Wheel Reinvention Alert**: Odoo has a native `vat` field for Tax ID, but we are implementing a specific "VAT Number" for documentation tracking. Ensure these don't conflict.
- **Attachment Strategy**: For `Binary` fields, remember to use `filename` if you want to allow downloading with the correct name (e.g., `vat_attachment_name`).
- **Dependency**: This story is the base for **AD-REG-03** (Restricted Portal).

---

## 📋 Tasks & Subtasks
 
### 1. Data Model Enhancement
- [x] Inherit `res.partner` in `models/res_partner.py`.
- [x] Add fields: `vat_number`, `license_number`, `vat_attachment`, `license_attachment`, `vat_expiry_date`, `license_expiry_date`.
- [x] Add format validation logic for `vat_number` and `license_number`.
 
### 2. Backend View Integration
- [x] Inherit `base.view_partner_form` in `views/res_partner_views.xml`.
- [x] Use `xpath` to add a new `page` titled "Documentation" in the `notebook`.
- [x] Arrange new fields within the Documentation tab.
 
### 3. Portal Wizard Enhancements
- [x] Add Password fields to `portal_signup_wizard_shell`.
- [x] Add VAT document upload to Step 2.
- [x] Convert Currency field to a search-based dropdown for active currencies.

### 4. Testing & Validation
- [x] Create Odoo test file `tests/test_partner_documentation.py`.
- [x] Implement test cases for field persistence.
- [x] Implement test case for format validation failure.
- [x] Verify portal submission end-to-end.
 
---
 
## 🧪 Acceptance Criteria Validation
- [x] AC-01: Data Model Enrichment
- [x] AC-02: Backend View Integration
- [x] AC-03: Format Validation
 
---
 
## 🛠️ Status & Record
- **Status**: `done`
- **Assigned Agent**: Antigravity
- **Debug Log**:
  - [2026-04-13] Story enhanced with implementation tasks.
  - [2026-04-13] Implemented fields, view, and tests.
  - [2026-04-13] Enhanced Portal Wizard with Password, VAT upload, and Currency dropdown.
