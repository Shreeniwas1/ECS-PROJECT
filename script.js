// State variables
let temperatureHistory = [];
let humidityHistory = [];
let alertSettings = {
    temperature: { min: 15, max: 30 },
    humidity: { min: 30, max: 70 },
    notifications: { email: true, sms: false }
};
let temperatureChart, humidityChart, performanceChart;
const OPENWEATHER_API_KEY = '5f29e311cbac55fa1ef22d648221ead4';
let defaultLocation = { lat: 40.7128, lon: -74.0060 }; // Default to New York City

// Global map variable
let warehouseMap = null;
let warehouseMarker = null;

// DOM Content Loaded - Initialize the application
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
});

// Main initialization function
function initializeApp() {
    // Load saved settings and data
    loadSavedSettings();
    
    // Initialize charts
    initializeCharts();
    
    // Load initial data
    updateDashboardData();
    
    // Setup event listeners
    setupEventListeners();
}

// Load any saved settings from localStorage
function loadSavedSettings() {
    // Load saved location if available
    const savedLocation = localStorage.getItem('warehouseLocation');
    if (savedLocation) {
        document.getElementById('location-display').textContent = savedLocation;
        updateMapDisplay(savedLocation);
        
        // Try to geocode the location for weather
        geocodeLocation(savedLocation);
    }
    
    // Load saved coordinates for weather if available
    const savedCoords = localStorage.getItem('weatherCoordinates');
    if (savedCoords) {
        try {
            defaultLocation = JSON.parse(savedCoords);
        } catch (e) {
            console.error('Error parsing saved coordinates:', e);
        }
    }
    
    // Load alert settings if available
    const savedAlertSettings = localStorage.getItem('alertSettings');
    if (savedAlertSettings) {
        alertSettings = JSON.parse(savedAlertSettings);
        
        // Update form fields with saved settings
        document.getElementById('temp-min').value = alertSettings.temperature.min;
        document.getElementById('temp-max').value = alertSettings.temperature.max;
        document.getElementById('humid-min').value = alertSettings.humidity.min;
        document.getElementById('humid-max').value = alertSettings.humidity.max;
        document.getElementById('notify-email').checked = alertSettings.notifications.email;
        document.getElementById('notify-sms').checked = alertSettings.notifications.sms;
    }
}

// Initialize all charts
function initializeCharts() {
    // Temperature chart
    const tempCtx = document.getElementById('temperatureChart').getContext('2d');
    temperatureChart = new Chart(tempCtx, {
        type: 'line',
        data: {
            labels: Array(10).fill(''),
            datasets: [{
                label: 'Temperature (°C)',
                data: Array(10).fill(null),
                borderColor: 'rgba(255, 99, 132, 1)',
                backgroundColor: 'rgba(255, 99, 132, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    grid: { display: false }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
    
    // Humidity chart
    const humidCtx = document.getElementById('humidityChart').getContext('2d');
    humidityChart = new Chart(humidCtx, {
        type: 'line',
        data: {
            labels: Array(10).fill(''),
            datasets: [{
                label: 'Humidity (%)',
                data: Array(10).fill(null),
                borderColor: 'rgba(54, 162, 235, 1)',
                backgroundColor: 'rgba(54, 162, 235, 0.1)',
                borderWidth: 2,
                fill: true,
                tension: 0.3
            }]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: { display: false }
            },
            scales: {
                y: {
                    beginAtZero: false,
                    grid: { display: false }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
    
    // Performance chart
    const perfCtx = document.getElementById('performanceChart').getContext('2d');
    performanceChart = new Chart(perfCtx, {
        type: 'bar',
        data: {
            labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
            datasets: [
                {
                    label: 'Items Processed',
                    data: [1200, 1900, 1500, 1700, 2000, 1000, 500],
                    backgroundColor: 'rgba(75, 192, 192, 0.7)',
                    borderRadius: 5
                },
                {
                    label: 'Items Shipped',
                    data: [1000, 1700, 1300, 1500, 1800, 800, 400],
                    backgroundColor: 'rgba(153, 102, 255, 0.7)',
                    borderRadius: 5
                }
            ]
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    position: 'top',
                    align: 'end'
                },
                tooltip: {
                    mode: 'index',
                    intersect: false
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    grid: { 
                        color: 'rgba(0, 0, 0, 0.05)'
                    }
                },
                x: {
                    grid: { display: false }
                }
            }
        }
    });
}

// Setup all event listeners
function setupEventListeners() {
    // Refresh buttons
    document.getElementById('refresh-temp').addEventListener('click', fetchTemperature);
    document.getElementById('refresh-humid').addEventListener('click', fetchHumidity);
    document.getElementById('refresh-all').addEventListener('click', updateDashboardData);
    
    // Location form
    document.getElementById('location-form').addEventListener('submit', function(e) {
        e.preventDefault();
        const locationInput = document.getElementById('location-input');
        const locationDisplay = document.getElementById('location-display');
        
        if (locationInput.value.trim() !== '') {
            const newLocation = locationInput.value;
            locationDisplay.textContent = newLocation;
            localStorage.setItem('warehouseLocation', newLocation);
            locationInput.value = '';
            
            // Update map with new location
            updateMapDisplay(newLocation);
            
            // Geocode the location for weather data
            geocodeLocation(newLocation);
        }
    });
    
    // Geolocation button
    document.getElementById('get-current-location').addEventListener('click', getCurrentLocation);
    
    // Alert toggles
    document.getElementById('temp-alert-toggle').addEventListener('change', function(e) {
        if (e.target.checked) {
            const alertModal = new bootstrap.Modal(document.getElementById('alertSettingsModal'));
            alertModal.show();
        }
    });
    
    document.getElementById('humid-alert-toggle').addEventListener('change', function(e) {
        if (e.target.checked) {
            const alertModal = new bootstrap.Modal(document.getElementById('alertSettingsModal'));
            alertModal.show();
        }
    });
    
    // Save alert settings
    document.getElementById('save-alert-settings').addEventListener('click', saveAlertSettings);
}

// Update the dashboard with fresh data
function updateDashboardData() {
    fetchTemperature();
    fetchHumidity();
}

// Function to fetch temperature from OpenWeatherMap API
async function fetchTemperature() {
    try {
        const response = await fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${defaultLocation.lat}&lon=${defaultLocation.lon}&units=metric&appid=${OPENWEATHER_API_KEY}`);
        
        if (!response.ok) {
            throw new Error(`Weather API responded with status: ${response.status}`);
        }
        
        const data = await response.json();
        console.log('Weather data:', data);
        
        // OpenWeatherMap provides temperature in Celsius when using metric units
        const temp = data.main.temp;
        updateTemperatureDisplay(temp);
        
        // Also update humidity while we're at it if we need to
        if (humidityHistory.length === 0) {
            updateHumidityDisplay(data.main.humidity);
        }
    } catch (error) {
        console.error('Error fetching temperature from OpenWeatherMap:', error);
        // Fallback to simulated data if API fails
        updateTemperature();
    }
}

// Function to fetch humidity from OpenWeatherMap API
async function fetchHumidity() {
    try {
        // We can use the same API call as temperature since it returns both values
        const response = await fetch(`https://api.openweathermap.org/data/2.5/weather?lat=${defaultLocation.lat}&lon=${defaultLocation.lon}&units=metric&appid=${OPENWEATHER_API_KEY}`);
        
        if (!response.ok) {
            throw new Error(`Weather API responded with status: ${response.status}`);
        }
        
        const data = await response.json();
        
        // OpenWeatherMap provides humidity as a percentage
        const humidity = data.main.humidity;
        updateHumidityDisplay(humidity);
    } catch (error) {
        console.error('Error fetching humidity from OpenWeatherMap:', error);
        // Fallback to simulated data if API fails
        updateHumidity();
    }
}

// Simulated data for demonstration (fallback)
function updateTemperature() {
    const temp = (Math.random() * 10 + 20).toFixed(1); // Random temp between 20-30°C
    updateTemperatureDisplay(temp);
}

function updateHumidity() {
    const humidity = Math.floor(Math.random() * 30 + 40); // Random humidity between 40-70%
    updateHumidityDisplay(humidity);
}

// Update temperature display and history
function updateTemperatureDisplay(temp) {
    const temperatureElement = document.getElementById('temperature');
    temperatureElement.textContent = `${temp}°C`;
    updateTimestamp('temp-time');
    
    // Add to history and update chart
    temperatureHistory.push(temp);
    if (temperatureHistory.length > 10) temperatureHistory.shift();
    
    // Update chart
    updateTemperatureChart();
    
    // Check for alerts
    checkTemperatureAlert(temp);
}

// Update humidity display and history
function updateHumidityDisplay(humidity) {
    const humidityElement = document.getElementById('humidity');
    humidityElement.textContent = `${humidity}%`;
    updateTimestamp('humid-time');
    
    // Add to history and update chart
    humidityHistory.push(humidity);
    if (humidityHistory.length > 10) humidityHistory.shift();
    
    // Update chart
    updateHumidityChart();
    
    // Check for alerts
    checkHumidityAlert(humidity);
}

// Update the temperature chart with new data
function updateTemperatureChart() {
    const now = new Date();
    const timeLabels = temperatureHistory.map((_, i) => {
        const time = new Date(now - (9 - i) * 60000);
        return time.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    });
    
    temperatureChart.data.labels = timeLabels;
    temperatureChart.data.datasets[0].data = temperatureHistory;
    temperatureChart.update();
}

// Update the humidity chart with new data
function updateHumidityChart() {
    const now = new Date();
    const timeLabels = humidityHistory.map((_, i) => {
        const time = new Date(now - (9 - i) * 60000);
        return time.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
    });
    
    humidityChart.data.labels = timeLabels;
    humidityChart.data.datasets[0].data = humidityHistory;
    humidityChart.update();
}

// Check if temperature is outside alert range
function checkTemperatureAlert(temp) {
    const temperatureElement = document.getElementById('temperature');
    
    if (temp < alertSettings.temperature.min || temp > alertSettings.temperature.max) {
        temperatureElement.classList.add('alert');
        
        if (document.getElementById('temp-alert-toggle').checked) {
            sendAlert(`Temperature alert: ${temp}°C is outside the range (${alertSettings.temperature.min}-${alertSettings.temperature.max}°C)`);
        }
    } else {
        temperatureElement.classList.remove('alert');
    }
}

// Check if humidity is outside alert range
function checkHumidityAlert(humidity) {
    const humidityElement = document.getElementById('humidity');
    
    if (humidity < alertSettings.humidity.min || humidity > alertSettings.humidity.max) {
        humidityElement.classList.add('alert');
        
        if (document.getElementById('humid-alert-toggle').checked) {
            sendAlert(`Humidity alert: ${humidity}% is outside the range (${alertSettings.humidity.min}-${alertSettings.humidity.max}%)`);
        }
    } else {
        humidityElement.classList.remove('alert');
    }
}

// Send an alert notification
function sendAlert(message) {
    console.log('ALERT:', message);
    // In a real app, this would send the alert via email, SMS, or show a notification
    
    // Show browser notification if supported
    if (Notification.permission === 'granted') {
        new Notification('Warehouse Alert', {
            body: message,
            icon: 'https://via.placeholder.com/64'
        });
    } else if (Notification.permission !== 'denied') {
        Notification.requestPermission().then(permission => {
            if (permission === 'granted') {
                new Notification('Warehouse Alert', {
                    body: message,
                    icon: 'https://via.placeholder.com/64'
                });
            }
        });
    }
}

// Save alert settings from modal
function saveAlertSettings() {
    alertSettings = {
        temperature: {
            min: parseFloat(document.getElementById('temp-min').value),
            max: parseFloat(document.getElementById('temp-max').value)
        },
        humidity: {
            min: parseFloat(document.getElementById('humid-min').value),
            max: parseFloat(document.getElementById('humid-max').value)
        },
        notifications: {
            email: document.getElementById('notify-email').checked,
            sms: document.getElementById('notify-sms').checked
        }
    };
    
    // Save to localStorage
    localStorage.setItem('alertSettings', JSON.stringify(alertSettings));
    
    // Close modal
    const alertModal = bootstrap.Modal.getInstance(document.getElementById('alertSettingsModal'));
    alertModal.hide();
    
    // Show confirmation
    alert('Alert settings saved successfully!');
}

// Update timestamp display
function updateTimestamp(elementId) {
    const now = new Date();
    document.getElementById(elementId).textContent = now.toLocaleTimeString();
}

// Get current location using Geolocation API
function getCurrentLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(
            async position => {
                const lat = position.coords.latitude;
                const lon = position.coords.longitude;
                const locationStr = `Lat: ${lat.toFixed(4)}, Long: ${lon.toFixed(4)}`;
                document.getElementById('location-input').value = locationStr;
                
                // Save coordinates for weather fetching
                defaultLocation = { lat, lon };
                localStorage.setItem('weatherCoordinates', JSON.stringify(defaultLocation));
                
                // Try to get a human-readable location name using reverse geocoding
                try {
                    const response = await fetch(`https://api.openweathermap.org/geo/1.0/reverse?lat=${lat}&lon=${lon}&limit=1&appid=${OPENWEATHER_API_KEY}`);
                    
                    if (response.ok) {
                        const data = await response.json();
                        if (data.length > 0) {
                            const { name, country } = data[0];
                            const formattedLocation = `${name}, ${country}`;
                            document.getElementById('location-input').value = formattedLocation;
                        }
                    }
                } catch (error) {
                    console.error('Error with reverse geocoding:', error);
                    // Keep the coordinates if reverse geocoding fails
                }
                
                // Fetch weather for the new location
                fetchTemperature();
                fetchHumidity();
            },
            error => {
                console.error('Error getting location:', error);
                alert('Could not get your location. Please enter it manually.');
            }
        );
    } else {
        alert('Geolocation is not supported by this browser.');
    }
}

// Function to geocode a location string to coordinates
async function geocodeLocation(locationString) {
    try {
        // Check if already in coordinate format
        const coordPattern = /Lat: ([-\d.]+), Long: ([-\d.]+)/i;
        const match = locationString.match(coordPattern);
        
        if (match) {
            const lat = parseFloat(match[1]);
            const lon = parseFloat(match[2]);
            if (!isNaN(lat) && !isNaN(lon)) {
                defaultLocation = { lat, lon };
                localStorage.setItem('weatherCoordinates', JSON.stringify(defaultLocation));
                
                // Update map with the new coordinates
                updateMapDisplay(locationString, { lat, lon });
                return;
            }
        }
        
        // Otherwise, try to geocode the string using OpenWeatherMap Geocoding API
        const encodedLocation = encodeURIComponent(locationString);
        const response = await fetch(`https://api.openweathermap.org/geo/1.0/direct?q=${encodedLocation}&limit=1&appid=${OPENWEATHER_API_KEY}`);
        
        if (!response.ok) {
            throw new Error(`Geocoding API responded with status: ${response.status}`);
        }
        
        const data = await response.json();
        
        if (data.length > 0) {
            const { lat, lon, name, country } = data[0];
            defaultLocation = { lat, lon };
            localStorage.setItem('weatherCoordinates', JSON.stringify(defaultLocation));
            
            // Update map with the geocoded coordinates and location name
            const formattedLocation = `${name}, ${country}`;
            updateMapDisplay(formattedLocation, { lat, lon });
            
            // Fetch weather for the new location
            fetchTemperature();
            fetchHumidity();
        } else {
            console.warn('Location could not be geocoded:', locationString);
            // Still update the map with text only
            updateMapDisplay(locationString);
        }
    } catch (error) {
        console.error('Error geocoding location:', error);
        // Still update the map with text only in case of error
        updateMapDisplay(locationString);
    }
}

// Update map display with Leaflet
function updateMapDisplay(locationText, coordinates = null) {
    const mapContainer = document.getElementById('map-container');
    
    // If we don't have coordinates, just show a message
    if (!coordinates) {
        mapContainer.innerHTML = `
            <div class="text-center p-3">
                <i class="fas fa-map-marker-alt fa-2x mb-2 text-danger"></i>
                <p>${locationText}</p>
                <small class="text-muted">Set precise location to view map</small>
            </div>
        `;
        return;
    }
    
    // Ensure the map container is empty
    mapContainer.innerHTML = '';
    
    // Initialize the map if it doesn't exist
    if (!warehouseMap) {
        warehouseMap = L.map(mapContainer).setView([coordinates.lat, coordinates.lon], 13);
        
        // Add the OpenStreetMap tiles
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 19,
            attribution: '&copy; <a href="https://openstreetmap.org/copyright">OpenStreetMap contributors</a>'
        }).addTo(warehouseMap);
    } else {
        // If map exists, just update the view
        warehouseMap.setView([coordinates.lat, coordinates.lon], 13);
    }
    
    // Remove existing marker if it exists
    if (warehouseMarker) {
        warehouseMap.removeLayer(warehouseMarker);
    }
    
    // Create a custom popup with location and weather info
    const popupContent = `
        <div class="warehouse-popup">
            <h5>Warehouse</h5>
            <p>${locationText}</p>
            <div class="weather-info">
                <i class="fas fa-thermometer-half text-danger"></i> ${document.getElementById('temperature').textContent}<br>
                <i class="fas fa-tint text-primary"></i> ${document.getElementById('humidity').textContent}
            </div>
        </div>
    `;
    
    // Add a new marker with popup
    warehouseMarker = L.marker([coordinates.lat, coordinates.lon])
        .addTo(warehouseMap)
        .bindPopup(popupContent)
        .openPopup();
    
    // Ensure the map resizes correctly after container changes
    setTimeout(() => {
        warehouseMap.invalidateSize();
    }, 100);
}

// Set up a recurring data refresh (every 30 minutes for weather)
setInterval(updateDashboardData, 1800000); // 30 minutes
