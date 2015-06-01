Pod::Spec.new do |s|
	s.name         = 'LiferayScreensThemeDemo'
	s.version      = '0.1'
	s.summary      = 'A sample theme for Liferay Screens'
	s.homepage     = 'https://www.liferay.com/liferay-screens'
	s.documentation_url = 'https://github.com/liferay/liferay-screens'
	s.license = { 
		:type => 'LGPL 2.1', 
		:file => 'LICENSE.md'
	}
	s.source = {
		:git => 'https://github.com/jmnavarro/liferay-screens-themes.git',
		:tag => 'v0.1'
	}
	s.authors = {
		'Jose Manuel Navarro' => 'jose.navarro@liferay.com'
	}
	s.social_media_url = 'http://twitter.com/jmnavarro'
	
	s.platform = :ios, '8.0'
	s.requires_arc = true

	s.source_files = 'Source/DemoTheme/**/*.{h,m,swift}'
	s.resources = 'Source/DemoTheme/**/*.{xib,png,plist,lproj}'
	
	s.dependency 'LiferayScreens'

end