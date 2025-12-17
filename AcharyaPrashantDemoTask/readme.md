# Acharya Prashant Image Grid (SwiftUI)

Small iOS app that shows a grid of images from the Acharya Prashant media coverage API.  
Built in SwiftUI using MVVM, manual URLSession networking, and custom memory + disk image caching.

---

## Requirements

- Xcode (latest stable)
- iOS 17.0+
- Internet connection

---

## How to run

1. Clone or download the project.
2. Open the project in Xcode.
3. Select a simulator.
4. Build the project.
5. Run the app.
   - The app will:
     - Call `https://acharyaprashant.org/api/v2/content/misc/media-coverages?limit=250`
     - Build thumbnail URLs from `domain + "/" + basePath + "/0/" + key`
     - Show them in a scrollable, responsive grid.

---

## What’s inside (architecture)

- **Application**
  - `ImageGridApp` – app entry point, sets up dependencies.

- **Presentation (MVVM)**
  - `ImageGridView` – main grid screen.
  - `GridImageCell` – single image cell (handles load/cancel per cell).
  - `ImageGridViewModel` – holds list of images, loading state, and errors.

- **Domain**
  - `ImageItem` – domain model for each image.
  - `FetchMediaCoveragesUseCase` – fetches data from the API client and maps to `ImageItem`.

- **Data**
  - `MediaCoverageAPIClient` – calls the API using `URLSession`.
  - `MediaCoverageResponseItem` – raw DTO for API response.
  - `ImageLoader` – downloads images, cancels work for off‑screen cells.
  - `MemoryImageCache`, `DiskImageCache`, `CompositeImageCache` – custom memory + disk cache.
  - `Cancellable` – simple abstraction over `cancel()`.




// Mark:- References

1.) https://microsoft.github.io/swift-guide/Naming.html
2.) https://www.ai-meeee.com/?p=510&lang=en
3.) https://stackoverflow.com/questions/53895980/how-to-organise-and-name-code-when-working-in-mvvm
4.)https://stackoverflow.com/questions/56603213/swift-ui-how-to-make-image-grids
5.) https://bugfender.com/blog/swiftui-grid/
6.) https://codewithchris.com/swiftui-grid-views/
7.) https://www.avanderlee.com/swiftui/grid-lazyvgrid-lazyhgrid-gridviews/
8.) https://www.codecademy.com/article/working-with-grids-in-swiftui
9.) https://www.kodeco.com/books/swiftui-cookbook/v1.0/chapters/7-build-a-grid-of-views-in-swiftui
10.) https://www.youtube.com/watch?v=nF6kG9Fu_hs
11.) https://www.youtube.com/watch?v=CQDiQF-1_rY&t=1s
12.) https://www.youtube.com/watch?v=yXSC6jTkLP4
13.) & many more
