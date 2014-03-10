Pod::Spec.new do |s|
  s.name         = "DPBasicOutlineView"
  s.version      = "0.0.3"
  s.summary      = "DPBasicOutlineView"
  s.homepage     = "http://dpostigo.com"
  s.license      = 'BSD'
  s.author       = { "Dani Postigo" => "dani@firstperson.is" }


  s.source       = { :git => "https://github.com/dpostigo/DPBasicOutlineView.git", :tag => s.version.to_s }
  s.platform     = :osx, '10.7'

  s.dependency     'DPKit-Utils'
  s.dependency     'NSView-DPFrameUtils'
  s.frameworks   = 'Foundation', 'QuartzCore'
  s.requires_arc = true

  s.source_files = 'DPBasicOutlineView/*.{h,m}'



  
end
