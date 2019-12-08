# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

inhibit_all_warnings!

target 'Backpackr' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Backpackr
  # ReactiveX
  pod 'ReactorKit', '~> 1.2'
  pod 'RxSwift', '~> 4.5'
  pod 'RxCocoa', '~> 4.5'
  pod 'RxDataSources', '~> 3.1'
  
  # Networking
  pod 'Moya', '~> 13.0'
  pod 'Moya/RxSwift', '~> 13.0'
  
  # Image Caching
  pod 'Kingfisher', '~> 5.11'
  
  # UI
  pod 'SnapKit', '~> 5.0'

  target 'BackpackrTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'RxBlocking', '~> 4.5'
    pod 'RxTest', '~> 4.5'
  end

  target 'BackpackrUITests' do
    # Pods for testing
  end

end
