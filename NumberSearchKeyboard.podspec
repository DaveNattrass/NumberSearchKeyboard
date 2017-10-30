Pod::Spec.new do |s|
  s.name         = "NumberSearchKeyboard"
  s.version      = "1.1"
  s.summary      = "A numeric keyboard with a search button."

  s.description  = "A numeric keyboard with a search button, styled to be similar to an apple standard keyboard."

  s.homepage     = "https://github.com/DaveNattrass/NumberSearchKeyboard"

  s.license      = "MIT"

  s.author       = { "Dave Nattrass" => "david.nattrass@ctt.co.uk" }

  s.source       = { :git => "https://github.com/DaveNattrass/numbersearchkeyboard.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "8.3"
  s.source_files  = "NumberSearchKeyboard", "NumberSearchKeyboard/**/*.{swift}"
  s.resources = ["NumberSearchKeyboard/**/*.xib", "NumberSearchKeyboard/**/*.xcassets"]

end
