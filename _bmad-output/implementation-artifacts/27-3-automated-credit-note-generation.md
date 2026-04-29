# Story 27.3: Automated Credit Note Generation

## User Story
**As a** Finance Manager,
**I want** the system to automatically generate Credit Notes when a subscription quantity is decreased,
**So that** we accurately reflect the unused portion of the pre-paid service.

## Status
Status: ready-for-dev

## Acceptance Criteria
1. **Given** an active subscription is decreased mid-period
2. **When** the decrease request is approved/processed
3. **Then** the system should calculate the "Unused Portion" from the change date to the term end.
4. **And** generate a Draft Credit Note for that amount.
5. **And** link this Credit Note to the Subscription Package.

## Technical Requirements
- **Trigger**: When a `subscription.package.request` of type `decrease` is processed.
- **Logic**:
  - Find the last posted invoice for this subscription (or the one covering the current period).
  - Calculate `unused_days = (end_date - change_date).days + 1`.
  - `credit_amount = (unit_price / total_days) * unused_days * decreased_quantity`.
  - Create `account.move` (move_type='out_refund') in state 'draft'.
- **Audit**: Post a message on the subscription with the CN reference.

## Developer Context
- Check `subscription_package_request.py` for processing logic.
- Look for where quantity changes are applied to the package.

## Implementation Plan
1. Hook into the processing logic of `subscription.package.request`.
2. Implement credit note generation helper.
3. Ensure the CN is linked via a field or message.
