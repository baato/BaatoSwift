# BaatoSwift
BaatoSwift is an umbrella framework for consuming <a href="https://docs.baato.io/#/v1/about/getting_started">baato api</a> easily. This framework helps to integrate the following: 
* Baato search api
* Baato reverse geocoding api
* Baato places api
* Baato Directions api

This framework is available through pods. To add BaatoSwift to your project, add the following to your podfile

```
source 'https://github.com/baato/BaatoPodSpec.git'
target '${YourApp}' do
  use_frameworks!

  # Pods for ${YourApp}
  pod 'BaatoSwift', '~> ${LatestVersion}'
  
end

```
Follow <a href = "https://cocoapods.org/"> official cocoapods </a> for setting pod to your project.

## Getting Started

#### Initializing

You will need a token to start. Create an account in <a href = "https://baato.io/"> baato.io </a> for token.  
```
import BaatoSwift

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    // Set token
     let baato = BaatoSwift.API.init(token: "BaatoToken")
     
     // Can also change baseURL,
     /*
      baseURLProd = "https://api.baato.io/api/v1"
      baseURLStag = "https://api-staging.baato.io/api/v1"
      let baato = BaatoSwift.API.init(baseURL: baseURL, token: "BaatoToken")
      */
      }
  }
}
```

#### Integrating Search

```
      // required parameters for search
      baato.searchQuery = "SearchQuery"
      
      // optional parameters
      
      // number of search result 
      baato.searchLimit = 10
      
      // search result base co-ordinate
      baato.searchLat= 27.7172 
      baato.searchLon= 85.3240 
      
      // search type
      baato.searchType= "hospital" //optional type
      
      // search around certain radius from base co-ordinate
      baato.searchRadius= 50 // optional
      
      
      //search result
      baato.getSearch { (data) in
                // data is the list of search result object.
                print(data?.first?.address, data?.first?.address)
      }
```

#### Integrating Place

```
      // required param for place
      baato.placeId = placeId
      
      //place result
      baato.getPlaces { (data) in
                // data is the place object.
                print(data?.address, data?.centroid)
      }
      
```
#### Integrating Reverse Geo-code
```
      // required parameters for reverse
      baato.reverseLat = latitude
      baato.reverseLon = longitude
      
      //place result
      baato.reverseLon { (data) in
                // data is the place object.
                print(data?.address, data?.name)
      }
      
```

#### Integrating Drections
```
      // required parameters for reverse
      baato.startLat = startingLatitude
      baato.startLon = startingLongitude
      baato.destLat = destinationLatitude
      baato.destLon = destinationLongitude
      
      // optional parameters
      
      // Mode is an enum defined in BaatoSwift
      baato.navMode = BaatoSwift.NavigationMode.bike
      
      baato.navAlternatives = false
      baato.navInstructions = true
    
      
      
      //Direction results
      baato.getDirections { (data) in
                // NavigationResponse Object
      }
      
```
