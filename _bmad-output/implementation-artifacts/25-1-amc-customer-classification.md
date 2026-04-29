# Story 25.1: AMC Customer Classification

Status: in-review

<!-- Note: Validation is optional. Run validate-create-story for quality check before dev-story. -->

## Story

As an Admin,
I want to mark specific customers as "AMC Customers",
so that the system knows to apply special quote logic to them.

## Acceptance Criteria

1. **Model Extension**: Add an `is_amc_customer` boolean field to the `res.partner` model.
2. **UI Integration**: Place the "AMC Customer" checkbox in the Partner form view, specifically positioned below the `relationship_type` field.
3. **Data Persistence**: Toggling the checkbox must persist correctly in the PostgreSQL database.
4. **Audit Trail**: Every change to the "AMC Customer" status must be captured in the Odoo Chatter (Mail Tracking) with the old and new values (NFR5).
5. **Access Control**: Ensure the field is visible and editable by users with Administrator roles (NFR4).

## Tasks / Subtasks

- [x] **Extend Model (AC: 1, 3, 4)**
  - [x] Modify `e:/odoo/odoo-17/addons/adigielite_it_service/models/res_partner.py`.
  - [x] Add `is_amc_customer = fields.Boolean(string="AMC Customer", tracking=True)`.
- [x] **Extend View (AC: 2, 5)**
  - [x] Modify `e:/odoo/odoo-17/addons/adigielite_it_service/views/res_partner_views.xml`.
  - [x] Inherit form view and use xpath to place `is_amc_customer` after `relationship_type`.
  - [x] External ID: `view_res_partner_form_inherit_amc`.
- [/] **Verification**
  - [ ] Verify the checkbox appears in the UI.
  - [ ] Verify toggling triggers a log in the Chatter.

## Dev Notes

- **Architecture Compliance**: Inherit from `adigielite_it_service`.
- **Implementation Pattern**: Use Odoo's `tracking=True` attribute on the field for the audit trail. This is the cleanest implementation for NFR5.
- **Naming**: Use `is_amc_customer` as per the defined naming conventions.
- **Source Paths**:
  - Model: [res_partner.py](file:///e:/odoo/odoo-17/addons/adigielite_it_service/models/res_partner.py#L141)
  - View: [res_partner_views.xml](file:///e:/odoo/odoo-17/addons/adigielite_it_service/views/res_partner_views.xml#L49)

### Project Structure Notes

- Alignment with unified project structure: Using existing `adigielite_it_service` module.
- Conflict detection: Ensure no clash with existing "AMC" logic if any (none detected in current grep).

### References

- [PRD: Functional Requirements #1](file:///e:/odoo/odoo-17/_bmad-output/planning-artifacts/prd.md)
- [Architecture: Data Architecture - Prorating Engine Section](file:///e:/odoo/odoo-17/_bmad-output/planning-artifacts/architecture.md)
- [Epics: Story 25.1 Details](file:///e:/odoo/odoo-17/_bmad-output/planning-artifacts/epics.md)

## Dev Agent Record

### Agent Model Used

### Debug Log References

### Completion Notes List

### File List
