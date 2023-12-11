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
      colors: {
        customYellow1: '#fffee6',
        customYellow2: '#dbca00',
        customYellow3: '#f7ff0f',
        customYellow4: '#d4db00',
        customGreen1: '#639031',
        customGreen5: '#6F7D42',
        customGreen6: '#B6B486',
        customGreen7: '#C0BE97',
        customBrown: '#B98B73',
        customBrown2: '#ddb892',
        customBrown3: '#a98467',
        customBeige: '#F0ECE3',
        customBeige2: '#e2dbc9',
        customBeige3: '#f7f5f0',
        customBeige4: '#dcd3bd',
      }
    }
  },
}
