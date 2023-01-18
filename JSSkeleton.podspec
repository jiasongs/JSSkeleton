
Pod::Spec.new do |s|
  s.name         = "JSSkeleton"
  s.version      = "0.2.5"
  s.summary      = "骨架屏"
  s.homepage     = "https://github.com/jiasongs/JSSkeleton"
  s.author       = { "jiasong" => "593908937@qq.com" }
  s.platform     = :ios, "12.0"
  s.swift_versions = ["4.2", "5.0"]
  s.source       = { :git => "https://github.com/jiasongs/JSSkeleton.git", :tag => "#{s.version}" }
  s.frameworks   = "Foundation", "UIKit"
  s.license      = "MIT"
  s.requires_arc = true
  s.source_files = "Sources", "Sources/*.{h,m}"

  s.dependency "JSCoreKit", "~> 0.2.7"

  s.default_subspec = "Core"
  s.subspec "Core" do |ss|
    ss.source_files = "Sources/**/*.{h,m,swift}"
    ss.private_header_files = "Sources/Extension/Private/*.{h,m,swift}"
  end
end
