# FeedBack — iOS Feedback Collection App

A native iOS app for collecting and reviewing user feedback, built with **SwiftUI**, **Clean Architecture**, and the **Coordinator pattern**, backed by **Firebase** (Auth + Firestore).

Users submit feedback through an animated mood slider; admins review all submissions from a single dashboard. Role-based access (User / Admin) is decided at sign-up and enforced through Firestore-backed routing.

---

##  Features

- **Email + Google Sign-In** authentication via Firebase Auth
- **Role-based routing** — Users see their own feedback, Admins see everyone's
- **Custom animated mood face** — a hand-built `Shape`-based UI component (not emoji) that morphs eyebrows, eyes, and mouth between Bad / Normal / Good as the user drags a slider
- **Real-time persistence** with Cloud Firestore
- **Coordinator-driven navigation** — no view ever instantiates another view directly
- **Mood-based filtering** on the Admin dashboard
- **Centralized design system** (`DesignTokens`) for consistent typography, color, and spacing across every screen

---

##  Tech Stack

| Layer | Technology |
|---|---|
| UI | SwiftUI, custom `Shape`-based vector animations |
| Architecture | Clean Architecture (Domain / Data / Presentation) + Coordinator pattern |
| State Management | `@Observable` (Swift Observation framework) |
| Backend | Firebase Authentication, Cloud Firestore |
| Auth Providers | Email/Password, Google Sign-In |
| Concurrency | Swift `async/await` throughout — no completion handlers |
| Dependency Management | Swift Package Manager |

---

##  Architecture

This project follows **Clean Architecture** with strict unidirectional dependencies: `Presentation → Domain ← Data`. The Domain layer has zero knowledge of SwiftUI or Firebase — it only depends on `Foundation`.

```
┌─────────────────┐
│   Presentation   │  SwiftUI Views + @Observable ViewModels
└────────┬─────────┘
         │ depends on
         ▼
┌─────────────────┐
│      Domain      │  Entities, UseCases, Repository protocols
│   (pure Swift)   │  ← no SwiftUI, no Firebase imports
└────────▲─────────┘
         │ implements
         │
┌─────────────────┐
│       Data       │  Firebase repositories, DTOs, mappers
└─────────────────┘
```

**Why this matters:** the Domain layer can be unit tested without mocking Firebase, and the Firebase SDK could be swapped for any other backend by writing a new repository implementation — no other layer would need to change.

### Navigation — Coordinator Pattern

Screens never navigate to each other directly. Each flow owns a `NavigationPath` and builds the next screen's ViewModel itself:

```
AppCoordinator (root — listens to Firebase auth state)
├── not logged in  → AuthCoordinator
│                      ├── Login
│                      └── Signup (with role selection: User / Admin)
└── logged in      → HomeCoordinator
                       ├── role == .user  → MyFeedbackView
                       └── role == .admin → AdminFeedbackView
```

---

##  Project Structure

```
FeedBack/
├── App/
│   └── Coordinator/
│       ├── AppCoordinator.swift        # Root — Firebase auth state listener
│       ├── AuthCoordinator.swift       # Login ↔ Signup navigation
│       ├── HomeCoordinator.swift       # User ↔ Admin routing
│       └── CoordinatorView.swift       # Renders the active coordinator tree
│   └── FeedBackApp.swift               # @main entry point, Firebase config
│
├── Domain/                             # Pure Swift — no UIKit/SwiftUI/Firebase
│   ├── Entities/
│   │   ├── AppUser.swift
│   │   ├── Feedback.swift
│   │   └── Mood.swift
│   ├── Repositories/                   # Protocols only
│   │   ├── AuthRepository.swift
│   │   └── FeedbackRepository.swift
│   ├── UseCases/
│   │   ├── AuthUseCases/
│   │   │   ├── SignUpUseCase.swift
│   │   │   ├── LoginUseCase.swift
│   │   │   ├── SignInWithGoogleUseCase.swift
│   │   │   └── FetchCurrentUserUseCase.swift
│   │   └── FeedbackUseCases/
│   │       ├── SubmitFeedbackUseCase.swift
│   │       ├── FetchMyFeedbackUseCase.swift
│   │       └── FetchAllFeedbackUseCase.swift
│   └── Errors/
│       ├── AuthValidationError.swift
│       └── FeedbackValidationError.swift
│
├── Data/                               # Concrete implementations
│   ├── DTOs/
│   │   ├── FeedbackDTO.swift
│   │   └── UserDTO.swift
│   ├── Repositories/
│   │   ├── FirebaseAuthRepository.swift
│   │   └── FirebaseFeedbackRepository.swift
│   └── Mock/
│       └── MockFeedbackRepository.swift
│
├── Presentation/
│   ├── Auth/
│   │   ├── Login/        (View + ViewModel)
│   │   └── Signup/       (View + ViewModel, includes role picker)
│   ├── Add Feedback Screen/   (View + ViewModel)
│   ├── MyFeedback Screen/     (View + ViewModel)
│   └── Admin Screen/          (View + ViewModel)
│
└── Common/                             # Shared, reusable UI
    ├── DesignTokens.swift              # Single source of truth for fonts/colors/spacing
    ├── MoodFace/
    │   └── MoodFaceView.swift          # Custom animated Shape-based face
    ├── FeedbackCardView/
    └── AuthComponents/                 # Reusable text fields, buttons
```

---

##  Firestore Data Model

```
users/{uid}
├── name: String
├── email: String
└── role: "user" | "admin"

feedback/{feedbackId}
├── userId: String
├── userName: String
├── mood: Int            // 0 = bad, 1 = neutral, 2 = good
├── comment: String
└── createdAt: TimeInterval
```

**Security rules** (production):
```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

---

##  Roadmap / Known Limitations

This is an actively developed portfolio project. Transparently tracking what's left:

- [ ] **Unit tests** — Domain layer (UseCases, validation logic) is structured to be fully testable in isolation but test coverage hasn't been written yet
- [ ] **Update / Delete feedback** — currently Create + Read only; Update/Delete are planned and the repository protocol is designed to extend cleanly for them
- [ ] **Admin role assignment** — currently self-selected at signup for demo purposes. Production version would gate this server-side via Firebase custom claims or an invite-only admin flow
- [ ] **Pagination** — Admin feed currently fetches all documents in one call; would need cursor-based pagination at scale

---

##  Getting Started

1. Clone the repo
2. Create a Firebase project, enable **Authentication** (Email/Password + Google) and **Cloud Firestore**
3. Download `GoogleService-Info.plist` from Firebase Console and add it to the project root
4. Add your `REVERSED_CLIENT_ID` as a URL Scheme (Target → Info → URL Types) for Google Sign-In
5. Build and run — Firebase SDK and GoogleSignIn-iOS resolve automatically via Swift Package Manager

---

##  License

MIT
