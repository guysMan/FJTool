Pod::Spec.new do |s|
    s.name         = 'FJTool'
    s.version      = '0.0.1'
    s.summary      = 'Common basic function'
    s.homepage     = 'https://github.com/jeffnjut/FJTool'
    s.license      = 'MIT'
    s.authors      = {'jeff_njut' => 'jeff_njut@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/jeffnjut/FJTool.git', :tag => s.version}
    s.source_files = 'FJTool/classes/*.h'
    s.resources    = "FJTool/resources/*.{storyboard,xcassets,xib,png,json}"
    s.ios.resource_bundle = { 'FJTool' => 'FJTool/resources/*.json' }
    s.dependency   'AFNetworking'
    s.dependency   'JSONModel'
    s.dependency   'SDWebImage'
    s.dependency   'CocoaSecurity'
    s.requires_arc = true
    s.subspec 'Appstore' do |ss|
      ss.source_files = 'FJTool/classes/Appstore/*.{h,m}'
    end
    s.subspec 'Array' do |ss|
      ss.source_files = 'FJTool/classes/Array/*.{h,m}'
    end
    s.subspec 'Block' do |ss|
      ss.source_files = 'FJTool/classes/Block/*.{h,m}'
    end
    s.subspec 'Color' do |ss|
      ss.source_files = 'FJTool/classes/Color/*.{h,m}'
    end
    s.subspec 'Data' do |ss|
      ss.source_files = 'FJTool/classes/Data/*.{h,m}'
    end
    s.subspec 'Date' do |ss|
      ss.source_files = 'FJTool/classes/Date/*.{h,m}'
    end
    s.subspec 'Image' do |ss|
      ss.source_files = 'FJTool/classes/Image/*.{h,m}'
    end
    s.subspec 'ImageView' do |ss|
      ss.source_files = 'FJTool/classes/ImageView/*.{h,m}'
    end
    s.subspec 'Font' do |ss|
      ss.source_files = 'FJTool/classes/Font/*.{h,m}'
    end
    s.subspec 'Network' do |ss|
      ss.source_files = 'FJTool/classes/Network/*.{h,m}'
    end
    s.subspec 'Storage' do |ss|
      ss.source_files = 'FJTool/classes/Storage/*.{h,m}'
    end
    s.subspec 'String' do |ss|
      ss.source_files = 'FJTool/classes/String/*.{h,m}'
    end
    s.subspec 'Translator' do |ss|
      ss.source_files = 'FJTool/classes/Translator/*.{h,m}'
    end
    s.subspec 'UUID' do |ss|
      ss.source_files = 'FJTool/classes/UUID/*.{h,m}'
    end
    s.subspec 'View' do |ss|
      ss.source_files = 'FJTool/classes/View/*.{h,m}'
    end
    s.subspec 'Cache' do |ss|
      ss.source_files = 'FJTool/classes/Cache/*.{h,m}'
    end
    s.subspec 'Timer' do |ss|
      ss.source_files = 'FJTool/classes/Timer/*.{h,m}'
    end
    s.subspec 'Macro' do |ss|
      ss.source_files = 'FJTool/classes/Macro/*.{h,m}'
    end
    s.subspec 'Region' do |ss|
      ss.source_files = 'FJTool/classes/Region/*.{h,m}'
    end
    s.subspec 'Pod' do |ss|
      ss.source_files = 'FJTool/classes/Pod/*.{h,m}'
    end
end
