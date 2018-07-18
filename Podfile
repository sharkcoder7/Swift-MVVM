platform :ios, '9.0'

source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!
target "TestDogsApp" do
#Reactive
    pod 'RxSwift',          '~> 4.1.2'
    pod 'RxCocoa',          '~> 4.1.2'
    pod 'Kingfisher', '~> 4.8.0'
    pod 'UIScrollView-InfiniteScroll', '~> 1.0.0'
end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
