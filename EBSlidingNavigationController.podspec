Pod::Spec.new do |s|

  s.name         = "EBSlidingNavigationController"
  s.version      = "0.1.2"
  s.summary      = "Simple Sliding Navigation"
  s.homepage     = "https://github.com/embinder/EBSlidingNavigationController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "embinder" => "email@address.com" }
  s.source       = { :git => "https://github.com/embinder/EBSlidingNavigationController.git", :tag => "0.1" }
  s.platform = :ios, '5.0'
  s.source_files  = 'EBSlidingNavigationController', 'EBSlidingNavigationController/**/*.{h,m}'
  s.requires_arc = true

end
