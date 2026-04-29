# Story 27.4: Financial Correction Audit Trail

## User Story
**As an** Auditor or Accountant,
**I want** to see exactly how a credit note or invoice adjustment was calculated,
**So that** I can verify financial accuracy without reverse-engineering.

## Status
Status: ready-for-dev

## Acceptance Criteria
1. **Given** a subscription modification (Increase, Decrease, Upgrade, Terminate)
2. **When** the transaction (Credit Note or SO) is generated
3. **Then** the system should post a detailed calculation log to the subscription chatter.
4. **The log must include**:
   - Original Unit Price
   - Effective Date
   - Term Start and End Dates
   - Total Days in Period
   - Active/Unused Days
   - Calculation Formula Result

## Technical Requirements
- **Location**: `subscription_package_request.py` and potentially `sale_order_line.py`.
- **Implementation**: Create a helper method to generate the audit HTML and post it to the `package_id.message_post`.

## Developer Context
- Use the values from the day-basis engine (27.2).
- Ensure the log is readable and professional.

## Implementation Plan
1. Add an audit log generation step to `_adigielite_create_decrease_credit_note`.
2. Add a similar step to the increase/upgrade flow in `action_process`.
