# E-Commerce Customer Analytics Platform

![Project Status](https://img.shields.io/badge/status-in%20progress-yellow)  
**A data-driven platform to analyze customer purchase behavior, predict churn, segment customers, and optimize marketing strategies using the UCI Online Retail Dataset.**

## Table of Contents
- [E-Commerce Customer Analytics Platform](#e-commerce-customer-analytics-platform)
  - [Table of Contents](#table-of-contents)
  - [Project Overview](#project-overview)
  - [Features](#features)
  - [Technologies](#technologies)
  - [Setup Instructions](#setup-instructions)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Verification](#verification)
  - [Usage](#usage)
  - [File Structure](#file-structure)
  - [Screenshots](#screenshots)
  - [Contributing](#contributing)
  - [License](#license)

## Project Overview
The E-Commerce Customer Analytics Platform leverages the UCI Online Retail Dataset to provide actionable insights for e-commerce businesses. The platform performs exploratory data analysis (EDA), calculates RFM (Recency, Frequency, Monetary) scores, predicts customer churn, segments customers for targeted marketing, and visualizes key performance indicators (KPIs) through an interactive dashboard. Built using Agile methodology across three sprints, the project emphasizes modular design, scalability, and ethical data practices.

This project is part of a portfolio to demonstrate skills in data analysis, machine learning, database design, web development, and system design.

## Features
- **Exploratory Data Analysis (EDA)**: Visualizes purchase patterns, top countries, and sales trends.
- **RFM Analysis**: Quantifies customer value based on recency, frequency, and monetary metrics.
- **Churn Prediction**: Uses classification models (e.g., logistic regression) to identify at-risk customers.
- **Customer Segmentation**: Applies clustering (e.g., K-means) for targeted marketing.
- **Interactive Dashboard**: Displays KPIs (CLV, churn rate) and visualizations using Plotly Dash (in progress).
- **A/B Testing Support**: Framework for designing marketing experiments (planned).
- **PostgreSQL Star Schema**: Optimized database for analytical queries, including RFM scores.
- **Ethical Modeling**: Bias detection and transparency measures (planned).

## Technologies
- **Programming**: Python 3.9+
- **Data Analysis**: pandas, NumPy, Seaborn, Matplotlib
- **Machine Learning**: scikit-learn, SHAP (planned)
- **Database**: PostgreSQL (star schema with customers, products, time, transactions tables)
- **Web Framework**: Flask (API, planned), Plotly Dash (dashboard, in progress)
- **Visualization**: Plotly, Folium (planned)
- **Testing**: pytest
- **Version Control**: Git, GitHub
- **Other**: SQLAlchemy, psycopg2-binary, Jupyter Notebooks

## Setup Instructions
Follow these steps to set up the project locally.

### Prerequisites
- Python 3.9+
- PostgreSQL 14+ (or Docker for PostgreSQL)
- Git
- UCI Online Retail Dataset (download from [UCI Machine Learning Repository](https://archive.ics.uci.edu/ml/datasets/online+retail))

### Installation
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/ecommerce-analytics-platform.git
   cd ecommerce-analytics-platform
   ```

2. **Set Up Virtual Environment**:
   ```bash
   python -m venv venv
   source venv/bin/activate  # On Windows: venv\Scripts\activate
   ```

3. **Install Dependencies**:
   ```bash
   pip install -r requirements.txt
   ```

4. **Place Dataset**:
   - Download `Online Retail.xlsx` from the UCI repository.
   - Place it in `data/raw/` (excluded from Git via `.gitignore`).

5. **Set Up PostgreSQL**:
   - Install PostgreSQL or run via Docker:
     ```bash
     docker run -d --name postgres_db -e POSTGRES_PASSWORD=your_password -p 5432:5432 postgres
     ```
   - Create the `ecommerce` database:
     ```bash
     psql -U postgres -c "CREATE DATABASE ecommerce;"
     ```
   - Update `src/database/db_connection.py` and `scripts/setup_db.sh` with your PostgreSQL password.

6. **Initialize Database**:
   - Run the setup script to create and populate the star schema:
     ```bash
     chmod +x scripts/setup_db.sh
     ./scripts/setup_db.sh
     ```

### Verification
- Confirm `data/processed/cleaned_transactions.csv` exists after running EDA.
- Verify PostgreSQL tables (`customers`, `products`, `time`, `transactions`) are populated:
  ```bash
  psql -U postgres -d ecommerce -c "SELECT COUNT(*) FROM transactions;"
  ```

## Usage
1. **Run EDA**:
   - Open `notebooks/eda.ipynb` in Jupyter Notebook:
     ```bash
     jupyter notebook notebooks/eda.ipynb
     ```
   - Execute cells to generate visualizations and cleaned data.

2. **Query Database**:
   - Use `notebooks/db_queries.ipynb` (or create one) to run RFM and sales queries:
     ```python
     from src.database.db_connection import Database
     db = Database()
     rfm = db.execute_query("SELECT CustomerID, MAX(InvoiceDate) as last_purchase, COUNT(DISTINCT InvoiceNo) as frequency, SUM(TotalSpend) as monetary FROM transactions GROUP BY CustomerID;")
     print(rfm)
     db.close()
     ```

3. **Future Features** (In Progress):
   - Run the Flask API: `bash scripts/run_api.sh` (after implementation).
   - Launch the Plotly Dash dashboard: `bash scripts/run_dashboard.sh` (after implementation).

## File Structure
```
ecommerce-analytics-platform/
├── data/
│   ├── raw/                    # UCI Online Retail Dataset
│   ├── processed/              # Cleaned data (CSV)
│   └── database/               # Placeholder for PostgreSQL setup
├── src/
│   ├── data_ingestion/         # Data loading and cleaning
│   ├── database/               # PostgreSQL schema and connection
│   └── utils/                  # Configuration and metrics (planned)
├── notebooks/                  # EDA and query notebooks
├── docs/                       # Requirements and design docs
├── scripts/                    # Setup and run scripts
├── .gitignore                  # Excludes venv, data, logs
├── README.md                   # This file
└── requirements.txt            # Python dependencies
```

## Screenshots
*To be added after dashboard implementation.*
- EDA Visualizations: Quantity distribution, top countries by sales, monthly sales trend.
- Database: RFM query results from PostgreSQL.

## Contributing
Contributions are welcome! Please:
1. Fork the repository.
2. Create a feature branch (`git checkout -b feature/your-feature`).
3. Commit changes (`git commit -m "Add your feature"`).
4. Push to the branch (`git push origin feature/your-feature`).
5. Open a pull request.

## License
[MIT License](LICENSE)  
Copyright (c) 2025 [Rohit Palusa](https://www.linkedin.com/in/palusa-rohit-goud/)