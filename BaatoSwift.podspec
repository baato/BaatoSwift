
Pod::Spec.new do |spec|

  spec.name         = "BaatoSwift"
  spec.version      = "0.1.8"
  spec.summary      = "This framework help to consume baato api."
  spec.description  = <<-DESC
  Baato Swift is a framework developed for consuming the baato api efficiently.
                   DESC

  spec.homepage     = "https://github.com/baato/BaatoSwift"
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Bhawak Pokhrel" => "bhawak.pokhrel@gmail.com" }

  spec.platform     = :ios, "10.3"

  spec.source       = { :git => "https://github.com/baato/BaatoSwift.git", :tag => "#{spec.version}" }

  spec.source_files  = "BaatoSwift/**/*.{swift}"
#  spec.resources = "BaatoSwift/**/*.{plist}"

  spec.requires_arc = true
  spec.swift_version = "5"
# spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  spec.dependency "Alamofire", "~> 5.2"
  spec.dependency "GEOSwift"
  spec.dependency "geos"

end
