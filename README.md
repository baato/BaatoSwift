# Baato Swift Library

<div style="max-width:600px;">

The Baato Swift library makes it easy to integrate the [Baato](https://baato.io) API into existing Android projects.

This library is available as a CocoaPod. To integrate BaatoSwift to your project, add the following to your Podfile:

</div>

<pre><code class="language-swift">source 'https://github.com/baato/BaatoPodSpec.git'
target '${YourApp}' do
  use_frameworks!

  # Pods for ${YourApp}
  pod 'BaatoSwift', '~> ${LatestVersion}'
  
end
</code></pre>


### Usage examples

Helper methods in BaatoSwift make it easy to perform API requests to Baato.

<div style="max-width:600px; margin-top:30px; ">

#### Search API

After initializing Baato with your access token, the `getSearch` method can be used to make requests to the Search API.

</div>

<pre><code class="language-swift">// Initialize Baato with your token
let baatoClient = BaatoSwift.API.init(token: "YOUR_BAATO_ACCESS_TOKEN")

// searchQuery is a required parameter
baatoClient.searchQuery = "SearchQuery"

// optional parameters
// number of results to return 
baatoClient.searchLimit = 10

// latitude and longitude coordinates, for providing additional geographical context to the search. 
baatoClient.searchLat= 27.7172 
baatoClient.searchLon= 85.3240 

// The type or category of results that the request should return. For example: hospital, cafe etc.
baatoClient.searchType= "hospital"

// radius, in kilometers from the specified lat/lon pair within which to look for results. Only integer values supported.
baatoClient.searchRadius= 50 


// Perform the search
baatoClient.getSearch { (data) in
    // response is a [SearchResult?] 
    print(data?.first?.address, data?.first?.address)
}
</code></pre>


<div style="max-width:600px; margin-top:30px; ">

#### Reverse Search API

After initializing Baato with your access token, the `getReverse` method can be used to make requests to the Reverse Search API.

</div>

<pre><code class="language-swift">// Initialize Baato with your token
let baatoClient = BaatoSwift.API.init(token: "YOUR_BAATO_ACCESS_TOKEN")

// reverseLat and reverseLon are required parameters
baatoClient.reverseLat = latitude
baatoClient.reverseLon = longitude

// Perform the reversh search request
baatoClient.getReverse { (data) in
        // response is a Place object
        print(data?.address, data?.name)
}
</code></pre>


#### Places API

After initializing Baato with your access token, the `getPlaces` method can be used to make requests to the Places API.

</div>

<pre><code class="language-swift">// Initialize Baato with your token
let baatoClient = BaatoSwift.API.init(token: "YOUR_BAATO_ACCESS_TOKEN")

// placeId is a required parameter
baatoClient.placeId = placeId

// Perform the place lookup
baatoClient.getPlaces { (data) in
        // response is a Place object
        print(data?.address, data?.centroid)
}
      

</code></pre>

#### Directions API

After initializing Baato with your access token, the `getDirections` method can be used to make requests to the Directions API.

</div>

<pre><code class="language-swift">// Initialize Baato with your token
let baatoClient = BaatoSwift.API.init(token: "YOUR_BAATO_ACCESS_TOKEN")

// startLat, startLon, destLat, destLon, navMode are all required parameters
baatoClient.startLat = 27.73405
baatoClient.startLon = 85.33685
baatoClient.destLat = 27.7177
baatoClient.destLon = 85.3278

// Mode is the vehicle profilespecified is an enum with the following values: bike, car and foot
baatoClient.navMode = BaatoSwift.NavigationMode.bike

// specify if you need alternative routes (ounly spports two points), or instructions to be included in your responce 
baatoClient.navAlternatives = false
baatoClient.navInstructions = true


// Perform the directions request
baatoClient.getDirections { (data) in
        // response is a NavigationResponse object
}
</code></pre>
