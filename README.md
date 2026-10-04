# LAND STACK INDIA — National Backend & Frontend Architecture

> **National Digital Public Infrastructure for Land Records & GIS Interoperability**

---

## 1. Overview & Architecture

Land Stack India is an integrated, full-stack digital land governance platform featuring:
- **Interactive Web Frontend**: Leaflet GIS maps, multi-portal UI (Public, Citizen, Government), real-time cadastral polygon rendering, and verification panels.
- **API Gateway**: REST APIs, versioning (`/api/v1`), rate limiting, request validation, CORS, and `/api` frontend compatibility bridge.
- **Three Portals**:
  - **Public Portal**: Open discovery by ULPIN, survey number, and administrative hierarchy; privacy-preserving DPDP-compliant masked title view.
  - **Citizen Portal**: Authenticated OTP/JWT dashboard, title view, legal document extracts, and mutation application submission.
  - **Government Portal (RBAC)**: Role-Based Access Control (Super Admin, Revenue Officer, SRO, Planning Officer, Municipal Officer, Police Officer, Auditor).
- **Land Core Engine**: Configurable ULPIN (Bhu-Aadhaar), Parcel 360° Aggregation, Record of Rights (RoR), and SRO Registration.
- **GIS Engine**: PostGIS GeoJSON endpoints, multi-category spatial layers (Base, Governance, Planning, Utility, Environment), and proximity queries.
- **Workflow Engine**: 11-step Ownership Transfer & Mutation state machine with automated checks.
- **Document Service**: Cryptographic SHA-256 tamper-evident integrity verification.
- **Integration Layer**: State adapters for Tamil Nadu Nilam, Maharashtra MahaBhulekh, and Karnataka Bhoomi.
- **AI / ML Engine**: Temporal satellite optical change detection, multi-factor title fraud risk scoring, and predictive valuation.
- **Audit Service**: Immutable, append-only security logs for all sensitive land transactions.

```
                         LAND STACK INDIA
                              BACKEND
                                │
                         ┌──────▼──────┐
                         │ API GATEWAY │ (/api/v1 & /api bridge)
                         └──────┬──────┘
                                │
             ┌──────────────────┼──────────────────┐
             │                  │                  │
             ▼                  ▼                  ▼
        🌍 PUBLIC          🏠 CITIZEN         🏛️ GOVERNMENT
        Parcels & Search   Auth & Title       RBAC & Mutations
             │                  │                  │
             └──────────────────┼──────────────────┘
                                ▼
                    ┌─────────────────────┐
                    │ AUTH + RBAC + MFA   │
                    └──────────┬──────────┘
                               │
                    ┌──────────▼──────────┐
                    │   LAND CORE ENGINE  │
                    └──────────┬──────────┘
                               │
       ┌──────────┬────────────┼───────────┬───────────┐
       ▼          ▼            ▼           ▼           ▼
     ULPIN      PARCEL        RoR        REGISTRY   OWNERSHIP
     SERVICE    SERVICE      SERVICE     SERVICE     SERVICE
       │          │            │           │           │
       └──────────┴────────────┼───────────┴───────────┘
                               ▼
                    ┌─────────────────────┐
                    │    GIS ENGINE       │
                    │     PostGIS         │
                    │ Cadastral + ULPIN   │
                    │ Spatial Layers      │
                    └──────────┬──────────┘
                               │
          ┌────────────────────┼────────────────────┐
          ▼                    ▼                    ▼
      GOVERNANCE           PLANNING             SERVICES
       RoR / SRO            Zoning               Municipal Tax
       Encumbrances         Master Plan          Utilities
       Disputes             Permissions          Environment
          │                    │                    │
          └────────────────────┼────────────────────┘
                               ▼
                    ┌─────────────────────┐
                    │ INTEGRATION LAYER   │
                    │ State Adapters:     │
                    │  - Tamil Nadu Nilam │
                    │  - MH MahaBhulekh   │
                    │  - KA Bhoomi        │
                    └──────────┬──────────┘
                               ▼
                    ┌─────────────────────┐
                    │ WORKFLOW ENGINE     │
                    │ 11-Stage Transfer & │
                    │ Mutation Automation │
                    └──────────┬──────────┘
                               │
                 ┌─────────────┼──────────────┐
                 ▼             ▼              ▼
           DOCUMENTS      NOTIFICATIONS     AUDIT
           (SHA-256)        SMS/EMAIL       TRAIL (Immutable)
                 │             │              │
                 └─────────────┼──────────────┘
                               ▼
                    ┌─────────────────────┐
                    │ DATA PLATFORM       │
                    │ PostgreSQL/PostGIS  │
                    │ Redis + Object Store│
                    └──────────┬──────────┘
                               ▼
                    ┌─────────────────────┐
                    │ AI / ML ENGINE      │
                    │ Change Detection    │
                    │ Risk / Fraud Score  │
                    │ Valuation Prediction│
                    └─────────────────────┘
```

---

## 2. Integrated Web Frontend

The interactive single-page application is located in `frontend/index.html` and served directly by the backend at `http://localhost:8000/`.

Features:
- **Interactive Leaflet Cadastral Map**: Renders real-time cadastral polygons from the backend's PostGIS GeoJSON endpoints.
- **Search & Filter**: Search parcels by ULPIN, survey number, or village.
- **Three View Switching**:
  - **Public View**: Masked title summary, parcel metadata, zoning.
  - **Citizen View**: My Land dashboard, ownership details, document downloads.
  - **Government View**: Officer dashboard, verification checklists, dispute status, SRO reverification.
- **Auto-Host Detection**: Automatically directs API queries to the active backend on port 8000.

---

## 3. Pre-Seeded Demonstration Accounts

All accounts use default password: `Password@123`

| Role | Email | Department / Notes |
|---|---|---|
| **Super Admin** | `admin@landstack.gov.in` | Universal nationwide access |
| **Revenue Officer** | `revenue.officer@landstack.gov.in` | RoR updates, Mutation orders, Application reviews |
| **SRO Officer** | `sro.guindy@landstack.gov.in` | SRO registrations, deeds, mortgages, encumbrances |
| **Planning Officer**| `planning.officer@landstack.gov.in`| Master plans, zoning, building permits |
| **Municipal Officer**| `municipal.officer@landstack.gov.in`| Property tax, utilities |
| **Police Officer** | `police.officer@landstack.gov.in` | Encroachment & dispute verification |
| **Auditor** | `auditor@landstack.gov.in` | Read-only compliance + immutable audit trail |
| **Citizen (Owner)** | `citizen.ramesh@gmail.com` | Owns parcel `IN-TN-CHN-000001234567` (Phone: `9876543210`) |
| **Citizen (Buyer)** | `citizen.priya@gmail.com` | Owns parcel `IN-TN-CHN-000002345678` (Phone: `9876543211`) |

---

## 4. How to Run

### Start Backend & Frontend Together:

```powershell
py -m uvicorn app.main:app --port 8000 --reload
```

- **Interactive Web App**: [http://localhost:8000/](http://localhost:8000/)
- **Swagger API Docs**: [http://localhost:8000/docs](http://localhost:8000/docs)
- **ReDoc API Docs**: [http://localhost:8000/redoc](http://localhost:8000/redoc)
- **Gateway Root Info**: [http://localhost:8000/api-info](http://localhost:8000/api-info)

---

## 5. Running Automated Tests

Run the complete test suite (36 tests):
```powershell
py -m pytest -v
```
All tests verify authentication, RBAC, public queries, citizen portal, 11-step workflow, GIS spatial layers, state integration adapters, and frontend compatibility bridge.
