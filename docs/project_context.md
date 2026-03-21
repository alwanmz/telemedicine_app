# Project Context

## Project

Flutter telemedicine mobile app frontend.
Backend later will use Laravel API.

## Design Direction

Use the existing UI style already implemented in this repo:

- clean
- rounded corners
- card-based layout
- soft medical colors
- mobile-first
- spacing airy and modern
- consistent with the earlier telemedicine mockup/PDF

## Current Implemented Features

- splash
- login/register
- home dashboard
- doctor list
- doctor search
- doctor category filter
- doctor detail
- booking page
- booking success
- appointment detail
- appointment provider
- reschedule appointment
- cancel appointment
- appointment detail reads latest data from provider using appointment id

## Current Routing / Behavior

- /splash
- /login
- /register
- /home
- /appointments
- /doctor-detail-list
- /doctor-detail
- /booking
- /booking-success
- /appointment-detail

## Important Rules

- Keep current code structure unless there is a strong reason to change it
- Preserve current UI style
- Make minimal, high-confidence changes
- Do not refactor unrelated files
- Keep code readable for a beginner Flutter developer
- Prefer small patches over large rewrites

## Current Goal

Implement segmented status filters on the Janji Temu page with these tabs:

- Semua
- Terjadwal
- Dijadwalkan Ulang
- Dibatalkan

## Behavior Required

- Filter appointment list from appointmentsProvider
- Keep existing navigation to appointment detail
- Show appropriate empty state when a selected tab has no items
- Do not break booking flow

## New Goal

Enhance the Janji Temu status segmented tabs by adding counters:

- Semua (count)
- Terjadwal (count)
- Dijadwalkan Ulang (count)
- Dibatalkan (count)

## Counter Rules

- Semua shows total number of appointments
- Terjadwal shows only appointments with status "Terjadwal"
- Dijadwalkan Ulang shows only appointments with status "Dijadwalkan Ulang"
- Dibatalkan shows only appointments with status "Dibatalkan"

## UI Rules

- Keep current segmented tab style
- Counter should be compact and visually secondary but still readable
- Do not make the tabs feel crowded
- Preserve current filtering behavior

## New Goal

Implement a telemedicine intake form aligned with the telemedicine PDF workflow.

## Intake Form Fields

- chief complaint
- allergy history
- blood pressure
- body temperature
- weight
- height
- patient type: Umum / Asuransi / BPJS
- consultation method: Chat / Voice Call / Video Call
- payment method: Tunai / Transfer Bank / E-Wallet

## Behavior Required

- Preserve the existing booking flow
- Keep current visual style
- The intake form should fit naturally into the booking flow
- Store the intake data together with the appointment object
- Keep code readable and beginner-friendly
- Make minimal, high-confidence changes
- Do not refactor unrelated files

## New Goal

Implement frontend payment method and payment status flow for telemedicine booking.

## Payment Rules

- Store payment method in the appointment object
- Add payment status to the appointment object
- Add invoice number to the appointment object
- Initial payment statuses:
  - Tunai -> unpaid
  - Transfer Bank -> pending
  - E-Wallet -> pending

## UI Requirements

- Preserve current booking flow
- Preserve current visual style
- Show payment method, payment status, and invoice number in appointment detail
- Keep code simple and beginner-friendly
- Make minimal, high-confidence changes only

## New Goal

Implement dummy payment actions for appointments:

- Bayar Sekarang
- Tandai Sudah Bayar

## Payment Action Rules

- Tunai starts as unpaid
- Transfer Bank starts as pending
- E-Wallet starts as pending

## Dummy Action Behavior

- "Bayar Sekarang" changes paymentStatus to paid
- "Tandai Sudah Bayar" changes paymentStatus to paid
- Appointment detail should update immediately after the action
- Preserve current appointment and payment flow
- Keep changes minimal and readable

## New Goal

Implement telemedicine chat consultation flow.

## Chat Flow Requirements

- Add a consultation chat list page or reuse the existing Chat tab
- Show active consultation sessions between patient and doctor
- Add chat room detail page
- Show doctor info, session status, and message bubbles
- Keep the current mobile design style: clean, rounded, card-based
- Use dummy local data for now
- Keep the structure simple and beginner-friendly
- Make minimal, high-confidence changes only

## Session Status

- Belum Dimulai
- Aktif
- Selesai

## New Goal

Implement patient prescription (e-resep) flow.

## Prescription Requirements

- Add a "Resep Saya" page for patients
- Show prescription cards with doctor name, date, and status
- Add prescription detail page
- Show medicine items, dosage, frequency, and doctor notes
- Add "Tebus Obat" button as entry point for the next pharmacy flow
- Keep the current visual style: clean, rounded, card-based, mobile-first
- Use dummy local data for now
- Make minimal, high-confidence changes only

## New Goal

Implement medicine redemption (Tebus Obat) and pharmacy order tracking flow.

## Tebus Obat Requirements

- Add a medicine redemption page from the prescription detail page
- Show medicine items from the prescription
- Show shipping address section
- Show delivery method selection
- Show medicine subtotal, shipping cost, and total cost
- Add a confirmation button as the next step

## Pharmacy Order Tracking Requirements

- Add pharmacy order detail page
- Show order number, prescription source, medicine items, shipping address, and delivery method
- Show pharmacy order status:
  - Menunggu Pembayaran
  - Diproses Farmasi
  - Dikirim
  - Selesai

## Rules

- Keep current visual style
- Use dummy local data for now
- Make minimal, high-confidence changes only
- Do not refactor unrelated files

## New Goal

Implement pharmacy order state and patient pharmacy order list.

## Requirements

- Save medicine redemption orders into a pharmacy order provider
- Add a "Pesanan Obat Saya" page
- Show pharmacy order cards with order number, date, total, and status
- Keep existing pharmacy order detail navigation working
- Use dummy local data for now
- Keep current visual style
- Make minimal, high-confidence changes only

## New Goal

Automatically mark a prescription as completed after the user successfully confirms medicine redemption.

## Requirements

- When the user confirms "Tebus Obat", the related prescription status should change from "Aktif" to "Selesai"
- The updated status should be reflected in:
  - prescription list
  - prescription detail page
- A completed prescription must no longer allow medicine redemption
- Keep the current visual style
- Use local dummy state/provider for now
- Make minimal, high-confidence changes only
- Do not refactor unrelated files

## New Goal

Implement dummy status actions for pharmacy orders.

## Pharmacy Order Status Flow

- Menunggu Pembayaran -> Diproses Farmasi
- Diproses Farmasi -> Dikirim
- Dikirim -> Selesai
- Selesai -> no further action

## Requirements

- Add provider logic to update pharmacy order status
- Show the correct action button in pharmacy order detail based on current status
- Update the status immediately in the UI after the action
- Keep the current visual style
- Make minimal, high-confidence changes only
- Do not refactor unrelated files

## New Goal

Separate pharmacy order payment status from fulfillment status.

## Requirements

- Pharmacy orders must have two separate fields:
  - paymentStatus
  - fulfillmentStatus
- Payment status values:
  - unpaid
  - pending
  - paid
  - failed
- Fulfillment status values:
  - waiting_payment
  - processing
  - shipped
  - completed

## UI Requirements

- Show payment status and fulfillment status separately in pharmacy order detail
- Keep the current visual style
- Preserve current medicine redemption and pharmacy order flow
- Make minimal, high-confidence changes only
- Do not refactor unrelated files

## New Goal

Refactor the frontend to be backend-ready, starting with appointment domain models and status standardization.

## Phase 1 Scope

- Create an Appointment model
- Standardize appointment status values
- Standardize payment status values
- Reduce direct Map<String, dynamic> usage in appointment-related flow
- Keep current UI and app behavior unchanged as much as possible

## Rules

- Prefer minimal, incremental refactors
- Do not rewrite the whole app
- Keep the project beginner-friendly
- Preserve existing visual behavior
- Prepare the codebase for future Laravel API integration

## Phase 2 Scope

Refactor the prescription domain to be backend-ready.

### Goals

- Create a Prescription model
- Create a PrescriptionMedicine model
- Standardize prescription status values
- Reduce direct Map<String, dynamic> usage in prescription-related flow
- Preserve current UI and current app behavior as much as possible

### Rules

- Keep the refactor incremental
- Do not rewrite unrelated features
- Preserve the existing prescription list, detail, and redeem medicine flow
- Keep the project beginner-friendly
