# PRD: Purchase Order Management

**Constraint**: All custom logic and inheritance must reside in `adigielite_it_service`.

## Overview
Automate and optimize the procurement process by linking PO generation directly to vendors identified in the Sales Order lines.

## Requirements

### 1. Vendor-Based PO Creation
- **Automated Generation**: When the "Create Purchase Order" action is triggered from a Sales Order, the system must split the procurement items by their assigned **Vendor**.
- **Multi-Vendor Logic**: 
  - If a Sales Order contains products from multiple vendors, notify the user with an info message: "Products from multiple vendors detected. Separate Purchase Orders will be created."
  - Automatically generate distinct POs for each vendor involved.

### 2. Traceability
- Maintain a link between the parent Sales Order and all child Purchase Orders for tracking procurement status.
- Ensure cost prices from the SO lines are correctly transferred to the PO as purchase prices.
