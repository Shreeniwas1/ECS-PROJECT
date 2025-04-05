Summary of the Warehouse Security System
The Warehouse Security System is an advanced monitoring solution that detects unauthorized intrusions (e.g., thieves, rodents) and environmental threats (e.g., fire, flooding) using sensor technology and machine learning. The system is structured into four key layers:
1.	Sensors/Hardware Layer – Integrates PIR sensors, RCWL-0516 microwave sensors, and DHT11 temperature & humidity sensors connected to a Raspberry Pi for real-time data collection.
2.	Edge ML Layer (Raspberry Pi) – Processes sensor data and feeds it into an LSTM-based machine learning model to predict motion status and anomalies.
3.	Backend/API Layer – A Flask/FastAPI/Node.js API that receives ML predictions, stores data in a database, and communicates with the frontend.
4.	Frontend Layer – A web-based dashboard that displays real-time data (motion, temperature, humidity) and fetches predictions via AJAX/WebSocket for live monitoring.
Key Features:
1.	Real-time motion and environmental monitoring
2.	ML-based anomaly detection for reducing false alarms
3.	Web-based dashboard for easy access and alerts
4.	Improved warehouse security through automated threat detection
Future Scope:
•	Integration of additional environmental sensors (e.g., smoke, gas detectors)
•	Enhanced AI models for predictive analytics
•	IoT and mobile app connectivity for remote monitoring
This system provides an efficient, AI-powered security solution for warehouses, ensuring faster response times and improved threat detection over traditional methods.