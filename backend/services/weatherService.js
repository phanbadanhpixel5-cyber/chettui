const axios = require('axios');

class WeatherService {
  constructor(db) {
    this.db = db;
    this.apiKey = process.env.OPENWEATHER_API_KEY;
    this.updateInterval = process.env.WEATHER_UPDATE_INTERVAL || 600000; // 10 minutes
    this.intervalId = null;
    this.currentLocation = {
      lat: 21.0285,  // Default to Hanoi
      lon: 105.8542,
      city: 'Hanoi'
    };
  }

  startWeatherUpdates() {
    console.log('[Weather] Starting weather updates...');
    this.updateWeather(); // Initial update
    this.intervalId = setInterval(() => {
      this.updateWeather();
    }, this.updateInterval);
  }

  stopWeatherUpdates() {
    if (this.intervalId) {
      clearInterval(this.intervalId);
      console.log('[Weather] Weather updates stopped');
    }
  }

  async updateWeather() {
    try {
      if (!this.apiKey) {
        console.warn('[Weather] OpenWeatherMap API key not configured');
        return;
      }

      const response = await axios.get('https://api.openweathermap.org/data/2.5/weather', {
        params: {
          lat: this.currentLocation.lat,
          lon: this.currentLocation.lon,
          appid: this.apiKey,
          units: 'metric'
        }
      });

      const weatherData = {
        temperature: response.data.main.temp,
        feelsLike: response.data.main.feels_like,
        humidity: response.data.main.humidity,
        pressure: response.data.main.pressure,
        description: response.data.weather[0].description,
        main: response.data.weather[0].main,
        windSpeed: response.data.wind.speed,
        cloudiness: response.data.clouds.all,
        city: response.data.name,
        country: response.data.sys.country,
        updatedAt: new Date().toISOString(),
        sunrise: new Date(response.data.sys.sunrise * 1000).toISOString(),
        sunset: new Date(response.data.sys.sunset * 1000).toISOString()
      };

      await this.db.ref('weather').set(weatherData);
      console.log('[Weather] Updated:', weatherData.city, weatherData.temperature + '°C');

    } catch (error) {
      console.error('[Weather] Update error:', error.message);
    }
  }

  async setLocation(latitude, longitude, city = '') {
    this.currentLocation = {
      lat: latitude,
      lon: longitude,
      city: city || 'Custom Location'
    };
    console.log(`[Weather] Location changed to: ${this.currentLocation.city}`);
    await this.updateWeather();
  }

  getWeatherIcon(description) {
    const desc = description.toLowerCase();
    if (desc.includes('clear') || desc.includes('sunny')) return '☀️';
    if (desc.includes('cloud')) return '☁️';
    if (desc.includes('rain')) return '🌧️';
    if (desc.includes('thunder')) return '⛈️';
    if (desc.includes('snow')) return '❄️';
    if (desc.includes('wind')) return '💨';
    if (desc.includes('fog') || desc.includes('mist')) return '🌫️';
    return '🌡️';
  }
}

module.exports = WeatherService;
