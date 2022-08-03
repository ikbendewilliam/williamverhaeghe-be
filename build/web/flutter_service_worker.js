'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "favicon-16x16.png": "aaf5e5b94c3446bdbfb5d15e61377609",
"version.json": "9b0ade61f287d3749fce0a9b28a6c36f",
"favicon.ico": "2d182294a500e3ec8fac6407499bec56",
"index.html": "636029f0bd80e8880c4cdd821bd2e8a8",
"/": "636029f0bd80e8880c4cdd821bd2e8a8",
"apple-icon.png": "b8a3deb6d6546334caa1e29dd865b862",
"apple-icon-144x144.png": "f54f5b1857ae3a853ef12dd56ddae136",
"android-icon-192x192.png": "d34b7ef1e40db163311fbc2a382fc3df",
"apple-icon-precomposed.png": "b8a3deb6d6546334caa1e29dd865b862",
"apple-icon-114x114.png": "f4d1719e5c535b7fef4a9c72905ea627",
"main.dart.js": "a82c85519fa87081f4d6aba1af55b69b",
"ms-icon-310x310.png": "37096c63b04885cf9742fdec9966359e",
"ms-icon-144x144.png": "f54f5b1857ae3a853ef12dd56ddae136",
"apple-icon-57x57.png": "1a31661bae1e8d9442bc64c30d413f3e",
"apple-icon-152x152.png": "1ab1f445d52278ca3ae85455928be6bd",
"favicon.png": "f90af6d99dbb43a953c7e71346d1b221",
"ms-icon-150x150.png": "4f83677a34e53cd96c37ebb5172e7c74",
"android-icon-72x72.png": "eab03b12eef9c3d38e8a830487e7542b",
"android-icon-96x96.png": "f90af6d99dbb43a953c7e71346d1b221",
"android-icon-36x36.png": "7a3ed1f897481c3cc0c8eecfa62ae567",
"apple-icon-180x180.png": "9e21481ce56a156a7625640aa017c918",
"favicon-96x96.png": "f90af6d99dbb43a953c7e71346d1b221",
"manifest.json": "b58fcfa7628c9205cb11a1b2c3e8f99a",
"android-icon-48x48.png": "f835a18f20db422777a9e19e89906737",
"apple-icon-76x76.png": "8f092468d944def48c429f3d4a9eb7fa",
"apple-icon-60x60.png": "b49a2195b185b3723804d049dc7861d3",
"robots.txt": "96108642adb6973a93e0c4af826d1d11",
"assets/AssetManifest.json": "2efbb41d7877d10aac9d091f58ccd7b9",
"assets/NOTICES": "b02b0180192703f9350a512b8b74989e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/fonts/MaterialIcons-Regular.otf": "95db9098c58fd6db106f1116bae85a0b",
"browserconfig.xml": "653d077300a12f09a69caeea7a8947f8",
"android-icon-144x144.png": "f54f5b1857ae3a853ef12dd56ddae136",
"apple-icon-72x72.png": "eab03b12eef9c3d38e8a830487e7542b",
"apple-icon-120x120.png": "6a6631a85504ecd8ce2acc0c7d8017ab",
"favicon-32x32.png": "94ae0b030a7152d66e7d5776a687a954",
"ms-icon-70x70.png": "95209261ef3b3c216eca8677c9652157"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
