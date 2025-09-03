# Mobile App + Express Backend (Auth & Profile)

This is a full-stack project featuring a Flutter mobile application and a lightweight Express.js backend. The project demonstrates a clean, scalable architecture for both the frontend and backend, focusing on core user authentication and profile management features.

- **Live Backend API:** [`https://tht-iconplus.rakit.digital`](https://tht-iconplus.rakit.digital)
- **Android App (APK):** [Download from Google Drive](https://drive.google.com/drive/folders/1Ykzu4aJhie4FitLnAIW8Bx3eF54HDPVx?usp=sharing)

---

## Features

-   **User Authentication:** Secure user registration and login (email & password).
-   **Session Management:** JWT-based sessions with token refresh mechanism.
-   **Profile Management:** View and update user profile information (name, job title, company).

---

## Tech Stack

#### Backend (Express.js)

-   **Framework:** Express.js
-   **Database:** MySQL
-   **ORM:** Prisma
-   **Authentication:** JSON Web Tokens (JWT), bcrypt
-   **Validation:** Zod
-   **Deployment:** Docker & Docker Compose

#### Frontend (Flutter)

-   **Architecture:** Clean Architecture (Feature-First)
-   **State Management:** BLoC / flutter_bloc
-   **Navigation:** GoRouter (State-driven)
-   **Networking:** Dio (with automated token-refresh interceptor)
-   **Dependency Injection:** GetIt & Injectable
-   **Data Modeling:** Freezed
-   **UI:** Centralized Design System

---

## Getting Started

### Prerequisites

-   Node.js (v20+)
-   Flutter SDK (v3.16+)
-   Docker & Docker Compose

### Backend Setup (Local)

1.  **Navigate to the backend directory:**
    ```bash
    cd backend
    ```

2.  **Create an environment file:**
    ```bash
    cp .env.production .env
    ```
    *Update the `DATABASE_URL` in `.env` to point to local MySQL instance (e.g., `mysql://user:password@localhost:3306/iconplus_db`).*

3.  **Install dependencies:**
    ```bash
    npm install
    ```

4.  **Run database migrations:**
    ```bash
    npx prisma migrate dev
    ```

5.  **Run the development server:**
    ```bash
    npm run dev
    ```
    The backend API will be available at `http://localhost:8080`.

### Flutter App Setup (Local)

1.  **Navigate to the app directory:**
    ```bash
    cd app
    ```

2.  **Update API URL:**
    For local development, ensure the API `baseUrl` points to your local machine. Open `backend/src/modules/core/di/register_module.dart` and confirm the URL:
    ```dart
    // Inside the @Named('baseDio') getter
    baseUrl: 'http://localhost:8080/v1', 
    ```
    *To run against the live server, change this to `https://tht-iconplus.rakit.digital/v1`.*

3.  **Install dependencies:**
    ```bash
    flutter pub get
    ```

4.  **Run code generation:**
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

5.  **Run the app:**
    ```bash
    flutter run
    ```
