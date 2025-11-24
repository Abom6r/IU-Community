📱 IU Community App

A mobile Flutter application designed for students and tutors at the Islamic University of Madinah.
Built with Flutter + Dart + Supabase, the app focuses on community learning, private tutoring, study collaboration, and communication.

🚀 Features Implemented (Fully Working)
✅ Authentication System

Email/Password sign-up & sign-in.

Start screen + Login screen + Register screen.

Secure Supabase authentication.

Role selection during registration:
Student, Tutor, or Both.

👤 User Profile

Each new user automatically gets a profile record in Supabase.

Editable profile (bio, skills, subjects, LinkedIn URL).

View your profile with a clean UI.

View other users’ profiles (especially tutors).

Display user role clearly: STUDENT / TUTOR / BOTH.

Display:

Full name

Role

Bio

Skills & subjects

Social links (LinkedIn)

🔎 Search & Community

Search for tutors by:

Name

Skill

Subject

Clean UI with tutor cards.

Tap a tutor to view full profile.

“Contact Tutor” button opens chat instantly.

💬 Real-Time Chat System

Implemented using Supabase Realtime and Postgres triggers.

Chat Features:

One-to-one messaging.

Real-time streaming of messages.

Conversation list showing:

The other user’s name

Last message

Last updated time

Beautiful chat UI with:

Colored message bubbles

Timestamps

Auto-scroll

Gradient header

Database structure:

conversations table with:

user1_id / user2_id

user1_name / user2_name

member_ids (UUID[])

last_message

updated_at

messages table with:

conversation_id

sender_id

text

created_at

All fully integrated with the app’s UI.

🗂️ Home Screen

Gradient header with:

User name

Today’s date

Welcome message

Quick action cards:

Schedule

Profile

Community

Messages

Smooth navigation between screens via bottom tabs.

📅 Schedule System (Basic Version)

User can open schedule screen.
(Advanced scheduling is planned in the Next Features section)

🛠️ Tech Stack
Area	Technology
Frontend	Flutter + Dart
Backend	Supabase (PostgreSQL + Realtime)
Auth	Supabase Auth
Database	Supabase Table Editor
State Management	Provider
UI	Custom Material UI components
🧩 App Architecture

Services Layer

AuthService

ProfileService

ChatService

Models

AppUser

Conversation

ChatMessage

UserRole (enum)

Screens

Authentication (Start, Login, Signup)

Home

Profile (view + edit)

Community (search tutors)

Tutor Profile

Chat & Conversations

Schedule

Clean folder structure and modular design for easy expansion.

🔮 Future Enhancements (Planned Features)
🟦 1. Advanced Schedule System

Add tasks, deadlines, reminders.

Calendar view.

Push notifications.

🟪 2. Group Study Feature

Create groups.

Group chat.

Group tasks.

Shared files.

Progress tracking for group members.

🟩 3. Post Feed (Community Wall)

Students/Tutors can post updates.

Like & comment system.

Filters for subjects and interests.

🟧 4. Tutor Booking System

Students can book 1:1 tutoring sessions.

Tutor availability calendar.

🟫 5. Voice Messages in Chat

Upload audio clips.

Auto-play inside chat.

🟩 6. File Sharing

Upload PDFs / Images inside chat.

Supabase storage integration.

🟨 7. Dark Mode

Full dark theme support.

🟥 8. Push Notifications (FCM)

New message alerts.

Appointment reminders.

📦 How to Run the Project
flutter pub get
flutter run


Make sure you have a valid Supabase project with:

Project URL

ANON key

Properly set database schema

RLS enabled with allowed policies

🤝 Contributing

Pull requests and feature suggestions are welcome.
