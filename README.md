# 🛍️ E-Commerce MERN Application

A full-stack e-commerce web application built with the **MERN stack** (MongoDB, Express.js, React, Node.js).  
It supports user authentication, product browsing, cart & order management, and Stripe payments.

---

## 📌 Features

- 👤 User authentication & authorization (JWT)
- 📦 Product listing & categories
- 🛒 Shopping cart & checkout flow
- 💳 Stripe payment gateway integration
- 📜 Order history & management
- 🎨 Responsive UI built with React + Tailwind
- ⚡ Fast development with Vite
- 🐳 Dockerized (frontend, backend, MongoDB, Mongo Express)

---

## 🛠️ Tech Stack

- **Frontend**: React, Vite, Tailwind CSS  
- **Backend**: Node.js, Express.js, Mongoose  
- **Database**: MongoDB (local or MongoDB Atlas)  
- **Payments**: Stripe API  
- **Containerization**: Docker & Docker Compose  

---

## 🚀 Getting Started

### 🔧 Prerequisites
- [Node.js](https://nodejs.org/) >= 18
- [MongoDB](https://www.mongodb.com/) (local or Atlas cluster)
- [Stripe](https://stripe.com/) account & secret key
- [Docker](https://www.docker.com/) (optional but recommended)

---

### 🖥️ Run locally (without Docker)

1. Clone repo
git clone https://github.com/chandanakrishna27/E-Commerce-MERN.git
cd E-Commerce-MERN

2. Backend
Copy code
cd backend
npm install

Create a .env in backend/:
Copy code
PORT=4000
MONGO_URL=mongodb://127.0.0.1:27017/store
STRIPE_SECRET_KEY=sk_test_your_key_here

Run:
Copy code
npm start

3. Frontend
Copy code
cd ../client
npm install
npm run dev

Frontend runs at http://localhost:5173
Backend API runs at http://localhost:4000



🐳 Run with Docker Compose
Make sure you’re in the project root.

Create a .env file:
Copy code
MONGO_URL=mongodb+srv://<user>:<password>@cluster0.mongodb.net
STRIPE_SECRET_KEY=sk_test_your_key_here

Run:
Copy code
docker-compose up --build


Frontend → http://localhost:5173
Backend → http://localhost:4000
Mongo Express → http://localhost:8081



📂 Project Structure
bash
Copy code
E-Commerce-MERN/
│── backend/          # Node.js + Express + Mongoose
│── client/           # React + Vite + Tailwind
│── docker-compose.yml
│── README.md
└── .env.example




🛡️ Environment Variables
Create a .env file in the root with:
Copy code
MONGO_URL=your_mongo_uri
STRIPE_SECRET_KEY=your_stripe_key
