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
