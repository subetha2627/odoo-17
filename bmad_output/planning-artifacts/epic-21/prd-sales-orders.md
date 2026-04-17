# PRD: Sales Order & Quotation Enhancements

**Constraint**: All custom logic and inheritance must reside in `adigielite_it_service`.

## Overview
Advance the quotation and sales order workflow with multi-currency support, gross profit analysis, automated document generation, and flexible customer data handling.

## Requirements

### 1. Multi-Currency Support
- **Supported Currencies**: Enable switching between `AED` (local) and `USD`.
- **Logic**: Ensure exchange rates are handled correctly for pricing and reporting.

### 2. Quotation (Quote-First) Strategy
- **Quotes Without Formal Customer**: Allow quotes to be created without selecting a pre-existing Customer configuration.
- **On-Quote Fields**:
  - `Customer Name` (Free text)
  - `Email`
  - `Address`
- **Validation**: While quotes are flexible, an **Invoice requires a formally created Customer**.

### 3. Margin & Profitability Tracking
- **Product-Level Data**:
  - `Distributor Info`
  - `Vendor Info`
- **GP Calculation**:
  - Automatically calculate **Gross Profit (GP)** at the line level.
  - Recalculate GP dynamically when Cost Price (CP) or Sales Price (SP) is modified.

### 4. Automated Item/Task Creation
- **Action Buttons**: Add buttons onto the Sales Order:
  - `Create Purchase Order`: Generates PO(s) from SO lines.
  - `Create Subscription`: Generates subscription service records.
- **Approval/Ticketing**: Automatically create a Helpdesk ticket (`sh.helpdesk.ticket`) whenever a PO or Subscription is generated for tracking and fulfillment confirmation.
- **Integration**: Leverage the `sh_helpdesk_so` native integration logic if applicable, with customizations in `adigielite_it_service`.

### 5. Subscription Line Level Details
- For service-based lines, capture:
  - `Vendor`
  - `Start Date`
  - `End Date`
  - `Subscription Package Link`

## User Workflow
- Sales Person creates a quote with manual customer details.
- Upon approval, the quote is converted to a Sales Order, and a Customer record is created/linked.
- Post-SO, the User generates POs and Subscriptions via the action buttons, triggering automated tracking tickets.
