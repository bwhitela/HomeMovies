# "Home Movies" tvOS App

Some time before this, I had put together a website to host all of my family home movies that I had digitized from our large pile of VHS tapes. I had a setup with a headless Mac mini always on so the Apple TV could stream the videos through iTunes sharing. This seemed rather wasteful, leaving a computer always on, so I decided to throw together a simple tvOS app to stream the videos from the website, instead. This was made very simple by using SwiftUI. I also referenced another project to get me up to speed (https://dev.to/video/creating-an-apple-tv-app-with-swiftui-51fa, https://github.com/Eyevinn/tvos-swift-example-app). I've made my best effort to keep this generic so anyone else could make use of it with very few tweaks.

## Customization

The tweaking that I've mentioned above comes in the form of two items in the `HomeMovies-Info.plist`. Here you can set the `MAIN_TITLE` to whatever you'd like. The app is a simple scrollable list with a title, and the title is taken from this value. The other item is the `JSON_URL`. This is a JSON file hosted at the specified URL. This list defines all the videos available to be streamed and a link for each of them. This allows for modification of videos available for streaming simply by adjusting them at the source and not needing to update the tvOS app. See below for JSON schema.

## Schema For JSON File at `JSON_URL`

The schema of the JSON file that is pulled from `JSON_URL` in the `HomeMovies-Info.plist` is meant to be pretty simple. The JSON should be a list of dictionaries/objects. The order of this list will be respected. Each dictionary/object represents one video that will be listed and available for streaming playback. This dictionary/object contains 3 key-value pairs. They are `title`, `id`, and `video_url`. The `title` will be used for display in the list of videos. The `video_url` will be used to stream the video for playback. The `id` is unused. I was not sure if the `id` was a requirement when creating `Decodable` `struct`'s or `Identifiable` objects in a `ForEach` usage. Here is an example bit of JSON that the app will read:

```
[
    {
        "title": "My first video",
        "id": "first-video",
        "video_url": "https://example.com/video1.mp4"
    },
    {
        "title": "My second video",
        "id": "second-video",
        "video_url": "https://example.com/video2.mp4"
    }
]
```

## Note On Usage

I am posting this on GitHub as I hope it is useful to others. I decided against trying to make it customizable in a way that I could submit it to the App Store, but decided against that as it is not worth the effort. Please don't do that or steal my graphics. And if you want to make this better (but not make it much more complicated) feel free to offer up a pull-request. This is running just fine on a Apple TV HD with tvOS 16.1. Enjoy!
