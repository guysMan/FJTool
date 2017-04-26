Pod::Spec.new do |s|
    s.name         = 'FJTool'
    s.version      = '0.0.2'
    s.summary      = 'Common basic function'
    s.homepage     = 'https://github.com/jeffnjut/FJTool'
    s.license      = 'MIT'
    s.authors      = {'jeff_njut' => 'jeff_njut@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/jeffnjut/FJTool.git', :tag => s.version}
    s.source_files = 'FJTool/classes/*.h'
    s.resources    = "FJTool/resources/*.{storyboard,xcassets,xib,png,json}"
    s.requires_arc = true
    


    s.subspec 'Array' do |ss|
      ss.source_files = 'FJTool/classes/Array/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Array/**/*.h'
    end
    
    s.subspec 'Block' do |ss|
      ss.source_files = 'FJTool/classes/Block/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Block/**/*.h'
    end
    
    s.subspec 'Camera' do |ss|
      ss.source_files = 'FJTool/classes/Camera/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Camera/**/*.h'
      ss.dependency   'Masonry'
    end
    
    s.subspec 'CommonUI' do |ss|
      ss.source_files = 'FJTool/classes/CommonUI/**/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/CommonUI/**/*.h'
      ss.dependency   'CRToast'
      ss.dependency   'Toast'
      ss.dependency   'SVProgressHUD'
      ss.dependency   'SCAvatarBrowser'
    end

    s.subspec 'Contacts' do |ss|
      ss.source_files = 'FJTool/classes/Contacts/**/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Contacts/**/*.h'
    end

    s.subspec 'Color' do |ss|
      ss.source_files = 'FJTool/classes/Color/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Color/**/*.h'
    end

    s.subspec 'Cache' do |ss|
      ss.source_files = 'FJTool/classes/Cache/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Cache/**/*.h'
    end

    s.subspec 'Data' do |ss|
      ss.source_files = 'FJTool/classes/Data/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Data/**/*.h'
    end

    s.subspec 'Date' do |ss|
      ss.source_files = 'FJTool/classes/Date/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Date/**/*.h'
    end

    s.subspec 'Font' do |ss|
      ss.source_files = 'FJTool/classes/Font/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Font/**/*.h'
    end

    s.subspec 'Image' do |ss|
      ss.source_files = 'FJTool/classes/Image/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Image/**/*.h'
      ss.dependency   'SDWebImage'
    end

    s.subspec 'ImageView' do |ss|
      ss.source_files = 'FJTool/classes/ImageView/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/ImageView/**/*.h'
      ss.dependency   'CocoaSecurity'
    end

    s.subspec 'Macro' do |ss|
      ss.source_files = 'FJTool/classes/Macro/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Macro/**/*.h'
    end

    s.subspec 'Network' do |ss|
      ss.source_files = 'FJTool/classes/Network/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Network/**/*.h'
      ss.dependency   'AFNetworking'
    end

    s.subspec 'Pod' do |ss|
      ss.source_files = 'FJTool/classes/Pod/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Pod/**/*.h'
    end

    s.subspec 'Region' do |ss|
      ss.source_files = 'FJTool/classes/Region/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Region/**/*.h'
      ss.dependency   'JSONModel'
    end

    s.subspec 'Storage' do |ss|
      ss.source_files = 'FJTool/classes/Storage/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Storage/**/*.h'
      ss.dependency   'JSONModel'
    end

    s.subspec 'String' do |ss|
      ss.source_files = 'FJTool/classes/String/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/String/**/*.h'
    end

    s.subspec 'Translator' do |ss|
      ss.source_files = 'FJTool/classes/Translator/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Translator/**/*.h'
    end

    s.subspec 'Timer' do |ss|
      ss.source_files = 'FJTool/classes/Timer/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/Timer/**/*.h'
    end

    s.subspec 'UUID' do |ss|
      ss.source_files = 'FJTool/classes/UUID/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/UUID/**/*.h'
    end

    s.subspec 'View' do |ss|
      ss.source_files = 'FJTool/classes/View/*.{h,m}'
      ss.public_header_files = 'FJTool/classes/View/**/*.h'
    end
    
end
