# AnimeVerse 50K — GitHub iOS build project

**App name:** AnimeVerse 50K  
**Bundle identifier:** `com.smd.sm64ios`  
**Website opened in the app:** https://gotaku.to/

This project is a small native iOS shell that opens Gotaku in an in-app browser, with back and reload controls.

## Put this project in GitHub

Upload the contents of this ZIP into the root of your repository. Keep the folders exactly as shown:
- `project.yml`
- `AnimeVerse/AnimeVerseApp.swift`
- `AnimeVerse/ContentView.swift`
- `.github/workflows/build.yml`

Then open the repository's **Actions** tab and run **Build AnimeVerse IPA**. When it finishes, open the workflow run and download the artifact named **AnimeVerse-unsigned-IPA**.

The workflow creates an **unsigned IPA**. It is not signed or guaranteed installable until you sign it with your signing app and a compatible certificate/profile.

This app opens the website; it does not include a separately verified anime catalog or extract video streams. Website availability, playback, and permissions are controlled by that website.
