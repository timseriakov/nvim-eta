/** @type {import('tailwindcss').Config} */
module.exports = {
  // IMPORTANT: Include .eta files in content paths
  content: [
    "./src/**/*.{html,js,ts,jsx,tsx,eta}",
    "./views/**/*.eta",
    "./templates/**/*.eta",
    "**/*.eta",
  ],
  theme: {
    extend: {
      // Your custom theme configuration
    },
  },
  plugins: [
    // Your Tailwind plugins
  ],
}

