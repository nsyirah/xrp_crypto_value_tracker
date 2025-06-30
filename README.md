📱 XRP Crypto Value Tracker (MYR)
A Flutter mobile application that fetches and displays the live value of XRP (Ripple) in Malaysian Ringgit (MYR) using real-time data from a public API.

🎯 Objective
This app is built for a Lab Assignment with the goal of practicing:

JSON parsing in Flutter

API integration

UI building using widgets and Material design

Multi-screen navigation

Presentation and documentation skills

📦 Features
✅ Live XRP Price Fetching
The app retrieves real-time XRP prices from this API endpoint:
https://api.mypapit.net/crypto/XRPMYR.json

✅ Formatted Price Display

Price shown in MYR with 2 decimal places

Clearly labeled UI with Current Price, Last Price, Price Change and Last Updated timestamp

Responsive refresh button to update data manually

✅ Beautiful User Interface

Pink-themed color scheme using custom ThemeData

Responsive layout with smooth rounded cards and icons

Clean typography and layout using Poppins font

✅ About Page

Accessible via AppBar info icon

Displays app purpose and developer name, student ID, class section

✅ Modular Code Structure

Separated into multiple files:

main.dart – UI & logic

api_services.dart – API integration

about_page.dart – About screen content

pubspec.yaml – project dependencies

