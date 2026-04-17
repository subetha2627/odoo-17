# PRD: CRM & Lead Management

**Constraint**: All custom logic and inheritance must reside in `adigielite_it_service`.

## Overview
Streamline the lead intake and conversion process, integrating ticketing for follow-up and clear progression path to opportunities.

## Requirements

### 1. Lead Source Categorization
- **Lead Source Dropdown**: Add a mandatory dropdown field in the Lead form with the following options:
  - `Email`
  - `MSPC`
  - `Telecalling`

### 2. Follow-up & Ticketing
- **Ticket Creation**: Add a functionality to create a Helpdesk ticket (`sh.helpdesk.ticket`) directly from a Lead to manage specific follow-up actions.
- **Action Button**: A "Create Ticket" button should be prominently displayed on the Lead form.
- **Integration**: Leverage the native Softhealer Lead-to-Ticket linkage if available, or implement custom mapping in `adigielite_it_service`.

### 3. Lead Conversion
- **Opportunity Conversion**: Ensure standard "Convert to Opportunity" workflow is aligned with the new fields, ensuring data persistence (like lead source) during the transition.
