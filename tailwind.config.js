module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  plugins: [
    require('daisyui'),
    // ... 他のプラグイン ...
  ],
  plugins: [
    require("daisyui"),
  ],
  theme: {
    extend: {
      fontFamily: {
        gorilla: ['Zen Maru Gothic', 'sans-serif'],
      },
      colors: {
        customPaper: '#f8fafb',
        customYellow1: '#fffee6',
        customYellow2: '#dbca00',
        customYellow3: '#f7ff0f',
        customYellow4: '#d4db00',
        customBlue1: '#183654',
        customBlue2: '#5cd6ff',
        customBlue3: '#00a4db',
        customgray1: '#6b7b6e',
        customgray2: '#566158',
        customGreen1: '#639031',
      }
    }
  }
}
