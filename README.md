# 📱 IU Community App

A mobile Flutter application designed for students and tutors at the Islamic University of Madinah.  
Built with **Flutter + Dart + Supabase**, the app focuses on community learning, private tutoring, study collaboration, and real-time communication.

---

## 🚀 Features Implemented (Fully Working)

### ✅ Authentication System
- Email/Password sign-up & sign-in  
- Start screen, Login screen, Register screen  
- Secure Supabase authentication  
- Role selection during registration: **Student**, **Tutor**, or **Both**

---

## 👤 User Profile
- Automatic profile creation for every new user  
- Editable fields: **bio, skills, subjects, LinkedIn URL**  
- View your own profile  
- View other users’ profiles (especially tutors)  
- Clearly displays user role: **STUDENT / TUTOR / BOTH**  
- Profile displays:
  - Full name  
  - Role  
  - Bio  
  - Skills & subjects  
  - Social links  

---

## 🔎 Search & Community
Search for tutors by:
- Name  
- Skill  
- Subject  

UI features:
- Clean tutor cards  
- Tap to view full tutor profile  
- **Contact Tutor** → opens chat instantly  

---

## 💬 Real-Time Chat System
Built using **Supabase Realtime** + **Postgres triggers**

### Chat Features
- One-to-one messaging  
- Real-time incoming messages  
- Conversation list showing:
  - Other user’s name  
  - Last message  
  - Last updated time  
- Beautiful chat UI:
  - Colored bubbles  
  - Timestamps  
  - Auto-scroll  
  - Gradient header  

### Database Structure

#### `conversations` table
- user1_id / user2_id  
- user1_name / user2_name  
- member_ids (UUID[])  
- last_message  
- updated_at  

#### `messages` table
- conversation_id  
- sender_id  
- text  
- created_at  

_All fully integrated with the app UI._

---

## 🗂️ Home Screen
Gradient header showing:
- User name  
- Today’s date  
- Personalized welcome message  

Quick action cards:
- Schedule  
- Profile  
- Community  
- Messages  

Smooth navigation using bottom tabs.

---

## 📅 Schedule System (Basic Version)
- User can open schedule screen  
- (Advanced scheduling is planned — see Next Features)

---

## 🛠️ Tech Stack

| Area        | Technology |
|-------------|------------|
| Frontend    | Flutter + Dart |
| Backend     | Supabase (PostgreSQL + Realtime) |
| Auth        | Supabase Auth |
| Database    | Supabase Table Editor |
| State Mgmt  | Provider |
| UI          | Custom Material UI components |

---

## 🧩 App Architecture

### Services Layer
- AuthService  
- ProfileService  
- ChatService  

### Models
- AppUser  
- Conversation  
- ChatMessage  
- UserRole (enum)

### Screens
- Authentication (Start, Login, Signup)  
- Home  
- Profile (view + edit)  
- Community (search tutors)  
- Tutor Profile  
- Chat & Conversations  
- Schedule  

Clean folder structure and modular design for easy expansion.

---
## 📸 App Screenshots

### 🏠 Home & Onboarding
| Home | Onboarding |
|------|------------|
| ![5848336987511786398_121](https://github.com/user-attachments/assets/5f3fabfc-1dc3-4f6d-a888-f05b737c43ce) | ![5848336987511786397_121](https://github.com/user-attachments/assets/4e21f7f9-1901-44be-bc8b-66193febe493)|
--- 
### 📝 Create Account & Login
| Create Account | Login |
|----------------|-------|
| ![5848336987511786394_121](https://github.com/user-attachments/assets/6e2173a0-a7f9-4063-a6ea-49bd3601cfdf)| ![5848336987511786395_121](https://github.com/user-attachments/assets/ba467e3c-0d9f-4d0b-aa46-110c78162f0a)|


---

### 👤 Profile & Tutor Feed
| Profile | Tutor Feed |
|--------|------------|
| ![5848336987511786389_121](https://github.com/user-attachments/assets/daa526d3-11c6-4332-8ceb-31e76eccd1be)| ![5848336987511786396_121](https://github.com/user-attachments/assets/aa3a5477-e703-4c39-b45d-6ed05282fc65)|

---

### 💬 Chat & Messages
| Chat Screen | Conversations List |
|-------------|--------------------|
|![5848336987511786390_121](https://github.com/user-attachments/assets/09e57b2f-4726-47d6-88df-6d2be5d403f9) | ![5848336987511786393_121](https://github.com/user-attachments/assets/c0261e4e-661a-4928-bfb1-ea684a69bf29)|

---

### 📅 Schedule System
| Schedule |
|----------|
|![5848336987511786392_121](https://github.com/user-attachments/assets/bdaa503e-5bbf-42f9-ac28-a9b051172fb2) |

---

## 🔮 Future Enhancements (Planned Features)

### 🟦 1. Advanced Schedule System
- Tasks, deadlines, reminders  
- Calendar view  
- Push notifications  

### 🟪 2. Group Study Feature
- Create groups  
- Group chat  
- Group tasks  
- Shared files  
- Progress tracking  

### 🟩 3. Community Post Feed
- User posts  
- Like & comment system  
- Filters by subjects/interests  

### 🟧 4. Tutor Booking System
- Book one-to-one tutoring sessions  
- Tutor availability calendar  

### 🟫 5. Voice Messages in Chat
- Audio clips upload  
- Auto-play inside chat  

### 🟩 6. File Sharing
- Upload PDFs / Images  
- Supabase storage integration  

### 🟨 7. Dark Mode
- Full dark theme support  

### 🟥 8. Push Notifications (FCM)
- Message alerts  
- Appointment reminders  

---

## 📦 How to Run the Project

```bash
git clone https://github.com/Abom6r/IU-Community.git
flutter pub get
flutter run
