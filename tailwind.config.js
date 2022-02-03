module.exports = {
  purge: [],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      colors: {
        gray: {
          100: '#F7FAFC',
          200: '#EDF2F7',
          300: '#E2E8F0',
          400: '#CBD5E0',
          500: '#A0AEC0',
          600: '#718096',
          700: '#4A5568',
          800: '#2D3748',
          900: '#1A202C'
        },
        bluegray: {
          100: '#CDDEEE',
          200: '#ABC7E3',
          300: '#88B0D7',
          400: '#6699CC',
          500: '#4482C1',
          600: '#366BA1',
          700: '#2A547E',
        }
      }
    },
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/line-clamp')
  ],
}
