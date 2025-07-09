# 🔐 TrustLens - Beta Version

## 🔍 Online Fraud & Fake Review Detection System

**TrustLens** is a full-stack AI-powered platform designed to combat **fake reviews** and **fraudulent financial transactions** using a combination of **NLP models**, **LightGBM classifiers**, **secure database management**, and **blockchain logging** for transparency and traceability.

---

## ⚙️ Tech Stack

| Layer           | Technology                                           |
|----------------|------------------------------------------------------|
| Frontend        | Next.js, Tailwind CSS, TypeScript                   |
| Backend         | Node.js, Next.js API Routes                         |
| Database        | Prisma ORM, PostgreSQL / MySQL                      |
| Blockchain      | Smart Contracts (Ethereum), web3.js / ethers        |
| ML Integration  | Python APIs: BERT/SVM for reviews, LightGBM for fraud |
| Hosting         | Vercel (Frontend), Streamlit (ML Dashboard), Supabase / PlanetScale |

---

## 🛠️ Core Features

### 🧠 Fake Review Detection (NLP)
- Classifies reviews using transformer or SVM models.
- Flags suspicious reviews and logs their metadata hash on Ethereum blockchain.

### 💸 Transaction Fraud Detection (ML)
- Predicts fraudulent financial transactions from engineered features using a LightGBM classifier.
- Based on IEEE-CIS Kaggle dataset.

### 🔗 Blockchain Logging
- Logs review hashes for immutable proof of fraud detection using `web3.js`.

### 🛡️ Admin Panel & Dashboard
- Visual dashboard for users/admins to view fraud stats, take action, and monitor trends.

---

## 🗂️ Web App Structure

```
trustlens/
├── app/                 # Routing and page views
├── components/          # UI modules (ReviewCard, Navbar, etc.)
├── hooks/               # Custom logic for ML, blockchain, auth
├── lib/                 # ML API calls, blockchain utils, helpers
├── prisma/              # Database schema and migrations
├── public/              # Static files and assets
├── styles/              # Tailwind-based styling
```

### 📄 Example Prisma Schema
```prisma
model Review {
  id         String   @id @default(uuid())
  content    String
  userId     String
  isFake     Boolean
  createdAt  DateTime @default(now())
}
```

---

## 🤖 AI/ML Architecture

### 🔍 Review Classification
- API endpoint receives review input.
- Uses BERT/SVM/LSTM model to return `isFake: true/false`.
- Logs flagged metadata hash on Ethereum blockchain.

### 📦 Fraud Detection (IEEE-CIS Dataset)
- **Dataset**: [IEEE Fraud Detection (Kaggle)](https://www.kaggle.com/competitions/ieee-fraud-detection)
- Combines `train_transaction.csv` and `train_identity.csv` on `TransactionID`.

### 🎯 Target Variable
| Column    | Description                     |
|-----------|---------------------------------|
| `isFraud` | 1 = fraud, 0 = legitimate        |

---

## 🧪 Feature Engineering

### 💳 Transaction Features
- `TransactionAmt`, `ProductCD`, engineered decimal-based stats
- `_amount_qcut10`, `amount_fraction`, `amount_decimal_len`

### 🕒 Time Features
- Derived from `TransactionDT`: `weekday`, `hour`, `hour_bucket`, `is_weekend`
- `hour_density`: behavioral modeling

### ⏱️ Rolling & Temporal Gaps
- `days_since_prev_txn`, `txn_gap_same_card`, `rolling_txn_count_short_term`

### 🔐 Identity & Card Info
- `card_id`, `card_type`, `addr1`, `DeviceInfo`, `M4`
- Engineered: `match_status`, `card_id_issuer`, frequency counts

### 📧 Email & Behavior
- `P_emaildomain`, `device_browser_combo_count`
- `shared_device_count`, `recent_txn_count`, `device_usage_frequency`

---

## 💡 LightGBM Model Setup

```python
from lightgbm import LGBMClassifier

model = LGBMClassifier(
    boosting_type='gbdt',
    objective='binary',
    metric='auc',
    num_leaves=256,
    learning_rate=0.01,
    feature_fraction=0.7,
    bagging_fraction=0.7,
    bagging_freq=5,
    max_depth=-1,
    n_estimators=10000,
    early_stopping_rounds=100
)
```

---

## 🔗 Blockchain Implementation

- Ethereum smart contract logs metadata hash of flagged reviews.
- Prevents tampering and ensures transparency.
- Integration via:
  - `lib/blockchain.ts`
  - `hooks/useBlockchainLogger.ts`

---

## 🔐 Authentication & Security

- Auth flow via custom `useAuth` hook
- Middleware protection for `/admin` and `/dashboard` routes

---

## 🌐 Deployment

| Module     | Platform | Link |
|------------|----------|------|
| Web App    | Vercel   | [TrustLens Web App](https://trust-lens-seven.vercel.app) |
| ML Backend | Streamlit | [ML Dashboard](https://mainpy-9pspmk3ecdfxyabxg3dgwz.streamlit.app) |

---

## 📌 Folder Highlights

- `hooks/useReviewValidation.ts` – Sends review to NLP API
- `hooks/useBlockchainLogger.ts` – Hashes and records review to blockchain
- `lib/mlClient.ts` – Bridges frontend with ML model
- `lib/utils.ts` – General preprocessing helpers

---

## 🧩 Future Improvements

- 🎯 Ensemble modeling (BERT + SVM for reviews)
- 🛡️ On-chain moderation for flagged reviews
- 📊 Real-time graph fraud monitoring
- 📱 Mobile app integration for reporting scams
- 🧠 Model explanations using SHAP for fraud insights

---

## 🤝 Contributing

Contributions are welcome! Please fork the repo, open a PR, or raise an issue.

---

## 📜 License

MIT License © 2025 TrustLens Team
