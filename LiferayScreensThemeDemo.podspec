Pod::Spec.new do |s|
	s.name         = 'LiferayScreensThemeDemo'
	s.module_name  = 'LiferayScreensThemeDemo'
	s.version      = '1.0.0'
	s.summary      = 'A sample theme for Liferay Screens'
	s.homepage     = 'https://www.liferay.com/liferay-screens'
	s.license = { 
		:type => 'LGPL 2.1', 
		:file => 'LICENSE.md'
	}
	s.source = {
		:git => 'https://github.com/jmnavarro/liferay-screens-themes.git',
		:tag => s.version.to_s
	}
	s.authors = {
		'Jose Manuel Navarro' => 'jose.navarro@liferay.com'
	}
	
	s.platform = :ios, '9.0'
	s.requires_arc = true

	s.source_files = 'Source/DemoTheme/**/*.{h,m,swift}'
	s.resources = 'Source/DemoTheme/**/*.{xib,png,plist,lproj}'
	
	s.dependency 'LiferayScreens'

end
