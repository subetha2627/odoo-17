# PRD: Opportunity & Forecasting

**Constraint**: All custom logic and inheritance must reside in `adigielite_it_service`.

## Overview
Improve the predictability of the sales pipeline through automated alerts and standardized forecast status tracking.

## Requirements

### 1. Proactive Alerts
- **Opportunity Start Date Alert**: Send a notification to the Sales Person/Account Manager **1 month before** the estimated opportunity start date to ensure preparation and engagement.

### 2. Forecast Status
- Introduce a standardized `Forecast Status` field with clear progress stages, including:
  - `30%` (Initial qualification)
  - `In Progress` (Actively working)
  - (Further stages as defined by sales policy)
