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
  daisyui: {
    themes: [
      {
        mytheme: {
          "base-100": "#fffec2",
        },
      },
    ],
    darkMode: false, // ダークモードの自動適用を無効化
  }
}
