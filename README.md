# wardaya

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## API Key Security

### Google Maps API Key Setup
To protect sensitive API keys, we use environment variables and key obfuscation. Follow these steps to set up the Google Maps API key:

1. Create a `.env` file in the project root (this file is gitignored)
2. Add your Google Maps API key to the `.env` file:
   ```
   MAPS_API_KEY=your_actual_api_key_here
   ```
3. The app uses the `flutter_dotenv` package to securely access this key at runtime

### For Android
The app includes a placeholder API key in the checked-in `strings.xml` file. This key is replaced during the build process with the actual key from your environment.

### For iOS
For iOS, we use a method channel approach to securely pass the API key from Flutter to native code:

1. The `AppDelegate.swift` contains a placeholder API key
2. At runtime, the real API key is passed from Flutter to iOS native code using a method channel
3. This ensures the real API key is never stored in the source code

### CI/CD Pipeline
In your CI/CD pipeline, add a step to replace the placeholder API key with your actual key before building:

```yaml
# Example GitHub Actions step - Only needed for Android
- name: Replace API keys
  run: |
    sed -i 's/YOUR_MAPS_API_KEY_HERE/${{ secrets.GOOGLE_MAPS_API_KEY }}/g' android/app/src/main/res/values/strings.xml
```

For iOS, no modifications to native files are needed as our method channel implementation handles this securely.

## Contributing
Please never commit API keys directly to the repository. Always use the environment variable approach described above.
