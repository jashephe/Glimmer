# Glimmer

Glimmer is a simple Swift library for macOS application update checking for apps distributed via [GitHub releases](https://help.github.com/en/github/administering-a-repository/managing-releases-in-a-repository). It is available as a [Swift Package](https://swift.org/package-manager/).

---

## Usage

The library's functionality can be accessed through `GlimmerUpdater`, which is initialized with the repository owner and name. Calling `getLatestRelease()` will yield a [Combine](https://developer.apple.com/documentation/combine) `Publisher` that resolves to a `GlimmerRelease`, which contains information about the most recent published release. Importantly, `GlimmerRelease` contains a `tag` field, which matches the git repository tag that was used to generate the release. Your application can compare this tag to the current version of the application, and determine if and how to alert the user.

### Preferences

Your application decides whether or not to allow the end user to enable or disable update checks, and whether or not to allow the user to "skip" a particular update version.

## Important Notes

__Glimmer does not install application updates.__ It not meant to replicate the functionality of auto-update libraries such as [Sparkle](https://github.com/sparkle-project/Sparkle). It merely provides the methods to check if an update is available, and the means to inform the user of how to navigate to and download the latest version. Glimmer does not include built-in methods for notifying the user that an update is available, and it does not maintain any persistent history of the last update check or ignored versions.
