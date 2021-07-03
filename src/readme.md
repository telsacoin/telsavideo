

While adding an app on your Firebase Project, cross-check your android application's package name (e.g com.example.application) which you will find on AndroidManifest.xml or, build.gradle (app level) file. If the package name is wrong adding SHA1 or SHA512 won't be helpful.

Follow the Firebase SDK Instructions properly. Add the required lines of code which they are recommending you to add.

Don't forget to add the SHA1 or SHA512 to your project which you can easily generate using the following command using the terminal of Android Studio.

cd android 
gradlew signingReport
Use the command flutter clean on the terminal before running the application.

Following the Firebase SDK Instructions properly will save you lots of time.