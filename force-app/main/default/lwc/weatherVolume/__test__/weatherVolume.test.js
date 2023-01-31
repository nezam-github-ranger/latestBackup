import { createElement } from 'lwc';
import WeatherVolume from 'c/weatherVolume';
import { registerApexTestWireAdapter } from '@salesforce/sfdx-lwc-jest';
import fetchWeatherVolume from '@salesforce/apex/WeatherVolume.fetchWeatherVolume';

//const fetchWeatherVolume = registerApexTestWireAdapter(fetchWeatherVolume);

describe('c-weather-volume', () => {
    afterEach(() => {
        // The jsdom instance is shared across test cases in a single file so reset the DOM
        while (document.body.firstChild) {
            document.body.removeChild(document.body.firstChild);
        }
    });
    
    it('displays weather information of a city', () => {
        // Create initial element
        const element = createElement('c-weather-volume', {
            is: WeatherVolume
        });
        document.body.appendChild(element);

        // Set up test data
        const testData = {
            humidity: '78',
            pressure: '1022',
            temperature: '20',
            temp_max: '23',
            temp_min: '19',
            feels_like: '21',
            grnd_level: '1015',
            sea_level: '1020'
        };
        fetchWeatherVolume.emit(testData);

        // Get input element
        const inputEl = element.shadowRoot.querySelector('lightning-input');
        inputEl.value = 'New York';
        inputEl.dispatchEvent(new CustomEvent('change'));

        // Get button element
        const buttonEl = element.shadowRoot.querySelector('lightning-button');
        buttonEl.dispatchEvent(new CustomEvent('click'));

        // Return a promise to wait for any asynchronous DOM updates. Jest will automatically wait for the Promise chain to complete before ending the test and fail the test if the promise is rejected.
        return Promise.resolve().then(() => {
            // Verify displayed weather information
            const humidityEl = element.shadowRoot.querySelector('.humidity');
            expect(humidityEl.textContent).toBe('Humidity : 78');

            const pressureEl = element.shadowRoot.querySelector('.pressure');
            expect(pressureEl.textContent).toBe('Pressure : 1022');

            // Add more test cases to verify the rest of the weather information
        });
    });

    

})