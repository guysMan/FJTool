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
    
    s.subspec 'Appstore' do |appstore|
      appstore.source_files = 'FJTool/classes/Appstore/*.{h,m}'
      appstore.public_header_files = 'FJTool/classes/Appstore/**/*.h'
    end

    s.subspec 'Array' do |array|
      array.source_files = 'FJTool/classes/Array/*.{h,m}'
      array.public_header_files = 'FJTool/classes/Array/**/*.h'
    end
    
    s.subspec 'Block' do |block|
      block.source_files = 'FJTool/classes/Block/*.{h,m}'
      block.public_header_files = 'FJTool/classes/Block/**/*.h'
    end
    
    s.subspec 'Camera' do |camera|
      camera.source_files = 'FJTool/classes/Camera/*.{h,m}'
      camera.public_header_files = 'FJTool/classes/Camera/**/*.h'
      camera.dependency   'Masonry'
    end
    
    s.subspec 'CommonUI' do |commonUI|
      commonUI.source_files = 'FJTool/classes/CommonUI/**/*.{h,m}'
      commonUI.public_header_files = 'FJTool/classes/CommonUI/**/*.h'
      commonUI.dependency   'CRToast'
      commonUI.dependency   'Toast'
      commonUI.dependency   'SVProgressHUD'
      commonUI.dependency   'SCAvatarBrowser'
    end

    s.subspec 'Contacts' do |contacts|
      contacts.source_files = 'FJTool/classes/Contacts/**/*.{h,m}'
      contacts.public_header_files = 'FJTool/classes/Contacts/**/*.h'
    end

    s.subspec 'Color' do |color|
      color.source_files = 'FJTool/classes/Color/*.{h,m}'
      color.public_header_files = 'FJTool/classes/Color/**/*.h'
    end

    s.subspec 'Cache' do |cache|
      cache.source_files = 'FJTool/classes/Cache/*.{h,m}'
      cache.public_header_files = 'FJTool/classes/Cache/**/*.h'
    end

    s.subspec 'Data' do |data|
      data.source_files = 'FJTool/classes/Data/*.{h,m}'
      data.public_header_files = 'FJTool/classes/Data/**/*.h'
    end

    s.subspec 'Date' do |date|
      date.source_files = 'FJTool/classes/Date/*.{h,m}'
      date.public_header_files = 'FJTool/classes/Date/**/*.h'
    end

    s.subspec 'Font' do |font|
      font.source_files = 'FJTool/classes/Font/*.{h,m}'
      font.public_header_files = 'FJTool/classes/Font/**/*.h'
    end

    s.subspec 'Image' do |image|
      image.source_files = 'FJTool/classes/Image/*.{h,m}'
      image.public_header_files = 'FJTool/classes/Image/**/*.h'
      image.dependency   'SDWebImage'
    end

    s.subspec 'ImageView' do |imageView|
      imageView.source_files = 'FJTool/classes/ImageView/*.{h,m}'
      imageView.public_header_files = 'FJTool/classes/ImageView/**/*.h'
      imageView.dependency   'CocoaSecurity'
    end

    s.subspec 'Macro' do |macro|
      macro.source_files = 'FJTool/classes/Macro/*.{h,m}'
      macro.public_header_files = 'FJTool/classes/Macro/**/*.h'
    end

    s.subspec 'Network' do |network|
      network.source_files = 'FJTool/classes/Network/*.{h,m}'
      network.public_header_files = 'FJTool/classes/Network/**/*.h'
      network.dependency   'AFNetworking'
    end

    s.subspec 'Pod' do |pod|
      pod.source_files = 'FJTool/classes/Pod/*.{h,m}'
      pod.public_header_files = 'FJTool/classes/Pod/**/*.h'
    end

    s.subspec 'Region' do |region|
      region.source_files = 'FJTool/classes/Region/*.{h,m}'
      region.public_header_files = 'FJTool/classes/Region/**/*.h'
      region.dependency   'JSONModel'
    end

    s.subspec 'Storage' do |storage|
      storage.source_files = 'FJTool/classes/Storage/*.{h,m}'
      storage.public_header_files = 'FJTool/classes/Storage/**/*.h'
      storage.dependency   'JSONModel'
    end

    s.subspec 'String' do |string|
      string.source_files = 'FJTool/classes/String/*.{h,m}'
      string.public_header_files = 'FJTool/classes/String/**/*.h'
    end

    s.subspec 'Translator' do |translator|
      translator.source_files = 'FJTool/classes/Translator/*.{h,m}'
      translator.public_header_files = 'FJTool/classes/Translator/**/*.h'
    end

    s.subspec 'Timer' do |timer|
      timer.source_files = 'FJTool/classes/Timer/*.{h,m}'
      timer.public_header_files = 'FJTool/classes/Timer/**/*.h'
    end

    s.subspec 'UUID' do |uuid|
      uuid.source_files = 'FJTool/classes/UUID/*.{h,m}'
      uuid.public_header_files = 'FJTool/classes/UUID/**/*.h'
    end

    s.subspec 'View' do |view|
      view.source_files = 'FJTool/classes/View/*.{h,m}'
      view.public_header_files = 'FJTool/classes/View/**/*.h'
    end
    
end
