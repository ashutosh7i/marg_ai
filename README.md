# marg_ai

## Backend
- URL: `20.197.18.36:5000`

## Aadhar API
- Base URL: `20.197.18.36:8000`
- Endpoints (POST):
  - Send OTP: `/api/send-otp`
    - Parameters: `{aadharno}`
  - Verify OTP: `/api/verify-otp`
    - Parameters: `{aadharno, otp}`