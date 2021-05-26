# Whether Sweater

Whether Sweater was completed in 5 days in the Backend Program at the Turing School of Software and Design. This project is an API based application for making Road Trips with weather information at your destination for the time you will arrive. These endpoints are ready to be utilized by a frontend team, including current weather, a weather forecast and the time needed to travel to your destination.

## Table of Contents
- [Learning Goals](#learning-goals)
- [Getting Started](#getting-started)
- [API Keys](#api-keys)
- [Endpoints](#endpoints)
- [Testing](#testing)
- [Author](#author)


## Learning Goals

 * Expose an API that aggregates data from multiple external APIs
 * Expose an API that requires an authentication token
 * Expose an API for CRUD functionality
 * Determine completion criteria based on the needs of other developers
 * Research, select, and consume an API based on your needs as a developer

## Getting Started

Clone repo to your local machine and run:
```
bundle install
rails db:{create,migrate}
```

## API Keys
  This application utilizes 3 externail API endpoints. You will need a key for each of these services, which can be found here:
  
- [MapQuest](https://developer.mapquest.com/plan_purchase/steps/business_edition/business_edition_free/register)
- [OpenWeather](https://home.openweathermap.org/)
- [Unsplash](https://unsplash.com/developers)

 Run `figaro install` this installs a file `config/application.yml`. It is in this file you need to include your API keys, they are formated as:
 ```
MAPQUEST_API_KEY: "your_mapquest_api_key"
OPENWEATHER_API_KEY: "your_openweather_api_key"
UNSPLASH_API_KEY: "your_unsplash_api_key"
```

### Endpoints
`POST /api/v1/users`
Creates a new user and generates a unique api key. The request needs to include the following information in the body of the request formatted in JSON.
```
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

The response status will be `201` and will be formatted in JSON as well.
```
{
    "data": {
        "id": "5",
        "type": "user",
        "attributes": {
            "email": "test@example.com",
            "api_key": "8nsU2zNnwi6eW61GJJdrhAtt"
        }
    }
}
```
---
`POST /api/v1/sessions`
Logs in a user. The request must include the user's email and password formatted in JSON.
```
{
  "email": "whatever@example.com",
  "password": "password"
}
```
The response will also be formatted in JSON.
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "whatever@example.com",
            "api_key": "61GW56vdjLReAhLbGAunZg=="
        }
    }
}
```
---
`GET /api/v1/forecast`
Returns the forcast for a given location. The query parameter `location` is required formatted as a city and state `denver,co`.

The response will include the current weather, 5 days of daily weather, and 8 hours of hourly weather.
```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2021-04-27 11:24:32 -0600",
                "sunrise": "2021-04-27 06:05:00 -0600",
                "sunset": "2021-04-27 19:49:46 -0600",
                "temperature": 50.95,
                "feels_like": 48.81,
                "humidity": 65,
                "uvi": 5.59,
                "visibility": 10000,
                "conditions": "overcast clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "2021-04-27",
                    "sunrise": "2021-04-27 06:05:00 -0600",
                    "sunset": "2021-04-27 19:49:46 -0600",
                    "min_temp": 38.17,
                    "max_temp": 59.68,
                    "conditions": "heavy intensity rain",
                    "icon": "10d"
                },
                {...} etc
            ],
            "hourly_weather": [
                {
                    "time": "11:00:00",
                    "temperature": 50.95,
                    "conditions": "light rain",
                    "icon": "10d"
                },
                {...} etc
            ]
        }
    }
}
```
---
`GET /api/v1/backgrounds`
Returns a background image for a given location. The `location` query parameter is required formatted as city and state `denver,co`.

THe response will return the image with the necesary credit information.
```
{
    "data": {
        "id": null,
        "type": "image",
        "attributes": {
            "image": {
                "location": "denver",
                "image_url": "https://images.unsplash.com/photo",
                "credit": {
                    "source": "unsplash.com",
                    "author": "Author's name",
                    "authorUrl": "https://unsplash.com/user"
                }
            }
        }
    }
}
```
---
`POST /api/v1/road_trip`
Returns trip information including travel time and weather at destination for the time of arrival. 
The parameters must be included in the body of the post formatted in JSON. `origin`, `destination`, and `api_key` are required.
```
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```

The response with be in JSON and include the start and end cities, total travel time, and weather at the destination at the time of arrival.
```
{
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver, CO",
            "end_city": "Estes Park, CO",
            "travel_time": "1 hour, 22 minutes",
            "weather_at_eta": {
                "temperature": 40.98,
                "conditions": "snow"
            }
        }
    }
}
```

## Testing

This application was developed using TDD with the test suite RSpec. To run the etire suite run `bundle exec rspec` from the command line. Test coverage was tracked with SimpleCov, and has 100% coverage.

## Author

* **Megan Gonzales** 
-[linkedin](https://www.linkedin.com/in/megan-e-gonzales/) 
-[github](https://github.com/MGonzales26)
