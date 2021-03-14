#
# Be sure to run `pod lib lint KBStickerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KBStickerView'
  s.version          = '0.1.1'
  s.summary          = 'A view that shows Stickers as an InputView (Keyboard).'



  s.description      = <<-DESC
This view will show Stickers at the bottom as an InputView (Keyboard).
you can add your own stickers using a Remote URL, or just as a local asset file.
                       DESC

  s.homepage         = 'https://github.com/3llomi/KBStickerView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '3llomi' => 'contact@devlomi.com' }
  s.source           = { :git => 'https://github.com/3llomi/KBStickerView.git', :tag => s.version.to_s }
   s.social_media_url = 'https://twitter.com/3llomi'

  s.ios.deployment_target = '9.0'
  s.swift_version = '5.0'

  s.source_files = 'Classes/**/*'
  

end
