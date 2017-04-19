Pod::Spec.new do |s|
  s.name         = 'SCMapCatch-Swift'
  s.version      = '0.1'
  s.summary      = 'A simplified tool for UserDefaults , Dictionary.'
  s.homepage     = 'https://github.com/Chan4iOS/SCMapCatch-Swift'
  s.author       = "CT4 => 284766710@qq.com"
  s.source       = {:git => 'https://github.com/Chan4iOS/SCMapCatch.git', :tag => "#{s.version}"}
  s.source_files = "SCMapCatch-Swift/**/*.{swift}"
  s.requires_arc = true
  s.libraries = 'z'
  s.ios.deployment_target = '8.0'
  s.license = 'MIT'
end
