# TrustLens - Beta-Version

# 🔍 TrustLens — Online Fraud & Fake Review Detection System

TrustLens is a full-stack web application designed to detect and mitigate online fraud and fake reviews using AI/ML, secure database management, and blockchain technology for data integrity.

---

## ⚙️ Tech Stack

| Layer           | Technology                                         |
|----------------|----------------------------------------------------|
| Frontend        | **Next.js**, **Tailwind CSS**, **TypeScript**     |
| Backend         | **Node.js**, **API Routes (Next.js)**             |
| Database        | **Prisma ORM**, **PostgreSQL / MySQL**            |
| Blockchain      | **Smart Contracts (Ethereum)**, **web3.js / ethers** |
| ML Integration  | **Fake Review Detection API (Python, BERT/SVM)**  |
| Hosting         | **Vercel**, **PlanetScale / Supabase**            |

---

## 🗂️ Web App Folder Structure

### 📁 `app/`
Handles routing and core application views such as:
- `/dashboard`: Displays fraud statistics
- `/submit-review`: Fake review submission
- `/admin`: Admin fraud control panel

### 📁 `components/`
Reusable UI modules:
- `ReviewCard`, `AlertBadge`, `Navbar`, `BlockchainPopup`, etc.

### 📁 `hooks/`
Custom hooks for:
- `useReviewValidation()` – Calls ML API to classify reviews
- `useBlockchainLogger()` – Logs hash to smart contract
- `useAuth()` – Handles session and authentication logic

### 📁 `lib/`
Utility layer containing:
- `mlClient.ts`: Preprocesses and sends data to ML API
- `blockchain.ts`: Ethereum hash generation and writing
- `utils.ts`: String, token, or input handlers

### 📁 `prisma/`
Includes:
- `schema.prisma`: Database models
- `migrations/`: Prisma DB migrations

**Example Schema:**
```prisma
model Review {
  id         String   @id @default(uuid())
  content    String
  userId     String
  isFake     Boolean
  createdAt  DateTime @default(now())
}
```

### 📁 `public/`
Assets:
- Logos
- Model JSON info
- Static banners

### 📁 `styles/`
Global and component styles powered by Tailwind CSS.

---

## 🔗 Blockchain Integration

Smart contract records a **hash of review metadata** (e.g. review ID, timestamp, isFake flag). This ensures tamper-proof evidence for each flagged review. Implemented via:
- `lib/blockchain.ts`
- `hooks/useBlockchainLogger.ts`

---

## 🤖 AI/ML Integration

TrustLens uses a fake review detection model (e.g. BERT/SVM/LSTM) running on a separate API service. Flow:
1. User submits a review
2. Frontend calls ML API → returns `isFake` boolean
3. If fake, logs to database and blockchain

---

## 🛠 Features

- 🧠 **Fake Review Detection** using NLP models
- 🔗 **Blockchain Logging** to preserve trust
- 🧾 **Admin Panel** to manage flagged reviews
- 📊 **User Dashboard** with fraud insights
- 🧩 **Reusable Hooks** for ML + blockchain
- 🔐 **Authentication & Middleware** for secure route access

---

## 🚀 Deployment

- Hosted on **Vercel**: [`https://trust-lens-seven.vercel.app`](https://trust-lens-seven.vercel.app)
- Streamlit ML dashboard: [`Streamlit App`](https://mainpy-9pspmk3ecdfxyabxg3dgwz.streamlit.app)

