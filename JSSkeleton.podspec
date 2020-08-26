
Pod::Spec.new do |s|
  s.name         = "JSSkeleton"
  s.version      = "0.0.4"
  s.summary      = "骨架屏"
  s.homepage     = "https://github.com/jiasongs/JSSkeleton"
  s.author       = { "jiasong" => "593908937@qq.com" }
  s.platform     = :ios, "9.0"
  s.swift_versions = ["4.2", "5.0"]
  s.source       = { :git => "https://github.com/jiasongs/JSSkeleton.git", :tag => "#{s.version}" }
  s.frameworks   = 'Foundation', 'UIKit'
  s.source_files = "JSSkeleton", "JSSkeleton/*.{h,m}"
  s.license      = "MIT"
  s.requires_arc = true
end
