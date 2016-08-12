## Usage

1. Get an API key-> <a href="themoviedb.org">themoviedb.org</a>
<blockquote>
<p>"A TMDb user account is required to request an API key."</p>
</blockquote>
<br>

To run the tests project, clone the repo, and run `pod install` from the main directory first.

## Installation

To install it, simply add the following line to your Podfile:
```ruby
pod "TheMovieDbApi", :git => 'https://github.com/alexnaldo/themoviedbapi.git'
```

## Unit Tests

  Please, read the unit tests project for usage examples

### Code

```swift

func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {

    // configure api from your AppDelegate.swift
    TheMovieDbApi.configure(apiKey: "your the movie db key")

    return true
  }

```

## Resources

Current available api:
* [Configuration](#configuration)
* [Certifications](#certifications)
* [Discover](#discover)
* [Movie](#movie)
* [TV](#tv)

### Configuration

```swift

  let api = TheMovieDbApi.instance
  api.commands.configuration().execute { (result:TheMovieDbResult<TheMovieDbConfigurationModel>) in

      switch result {
      case .success(let model):

      // here you have all model data, like
      print(model.image_url)

      case .failure(let error):
        print("\(error)")
      }
  }

```

### Certifications

```swift

  let api = TheMovieDbApi.instance
  api.commands.certification(.movie).execute { (result:TheMovieDbResult<TheMovieDbCertificationListModel>) in

      switch result {
      case .success(let model):

      // here you have all model data, like
      print(model.items)

      case .failure(let error):
        print("\(error)")
      }
  }

```

### Discover

```swift

  let api = TheMovieDbApi.instance
  api.commands.discover(.movie).execute { (result:TheMovieDbResult<TheMovieDbDiscoverListModel>) in

      switch result {
      case .success(let model):

      // here you have all model data, like
      print(model.items)

      case .failure(let error):
        print("\(error)")
      }
  }

```

### Movie

```swift

  let code = 76341 // Mad Max: Fury Road
  let api = TheMovieDbApi.instance
  api.commands.movie(code).execute { (result:TheMovieDbResult<TheMovieDbMovieModel>) in

      switch result {
      case .success(let model):

      // here you have all model data, like

      print(model.title)

      case .failure(let error):
        print("\(error)")
      }
  }

```

### TV

```swift

  let code = 39272 // Once Upon a Time
  let api = TheMovieDbApi.instance
  api.commands.tv(code).execute { (result:TheMovieDbResult<TheMovieDbMovieModel>) in

      switch result {
      case .success(let model):

      // here you have all model data, like

      print(model.name)

      case .failure(let error):
        print("\(error)")
      }
  }

```

##Compatibility
iOS 9.0 +

##Dependencies
* SwiftyJSON
* Alamofire

## Author
Alexnaldo Santos

## License
TheMovieDbApi is available under the MIT license. See the LICENSE file for more info.
