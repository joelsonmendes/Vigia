import numpy as np
import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import classification_report
import joblib

np.random.seed(42)
n_samples = 6000

data = {
    "daily_steps": np.random.normal(6000, 2500, n_samples),
    "hours_upright": np.random.normal(4.0, 1.5, n_samples),
    "sleep_hours": np.random.normal(7.0, 2.0, n_samples),
    "sleep_std": np.random.exponential(1.0, n_samples),
    "mobility_radius_m": np.random.exponential(2000, n_samples),
    "night_usage_ratio": np.random.beta(2, 4, n_samples),
    "notifications_ignored_ratio": np.random.beta(3, 2, n_samples),
}

data["daily_steps"] = np.clip(data["daily_steps"], 0, 15000)
data["hours_upright"] = np.clip(data["hours_upright"], 0, 12)
data["sleep_hours"] = np.clip(data["sleep_hours"], 2, 12)
data["mobility_radius_m"] = np.clip(data["mobility_radius_m"], 0, 10000)

df = pd.DataFrame(data)

def clinical_risk(row):
    score = 0
    if row["daily_steps"] < 4000:
        score += 1
    if row["hours_upright"] < 2:
        score += 1
    if row["sleep_hours"] < 5 or row["sleep_hours"] > 10:
        score += 1
    if row["sleep_std"] > 2.0:
        score += 1
    if row["mobility_radius_m"] < 500:
        score += 1
    if row["night_usage_ratio"] > 0.35:
        score += 1
    if row["notifications_ignored_ratio"] > 0.8:
        score += 1

    if score >= 4:
        return 2
    elif score >= 2:
        return 1
    else:
        return 0

df["risk_level"] = df.apply(clinical_risk, axis=1)

X = df.drop("risk_level", axis=1)
y = df["risk_level"]

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, stratify=y)
model = RandomForestClassifier(n_estimators=150, random_state=42)
model.fit(X_train, y_train)

joblib.dump(model, "clinical_mental_health_model.pkl")
print("✅ Modelo clínico salvo!")