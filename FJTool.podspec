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
    
    s.subspec 'Appstore' do |Appstore|
      Appstore.source_files = 'FJTool/classes/Appstore/*.{h,m}'
      Appstore.public_header_files = 'FJTool/classes/Appstore/**/*.h'
    end

    s.subspec 'Array' do |Array|
      ss.source_files = 'FJTool/classes/Array/*.{h,m}'
      Array.public_header_files = 'FJTool/classes/Array/**/*.h'
    end
    
    s.subspec 'Block' do |Block|
      Block.source_files = 'FJTool/classes/Block/*.{h,m}'
      Block.public_header_files = 'FJTool/classes/Block/**/*.h'
    end
    
    s.subspec 'Camera' do |Camera|
      Camera.source_files = 'FJTool/classes/Camera/*.{h,m}'
      Camera.public_header_files = 'FJTool/classes/Camera/**/*.h'
      Camera.dependency   'Masonry'
    end
    
    s.subspec 'CommonUI' do |CommonUI|
      CommonUI.source_files = 'FJTool/classes/CommonUI/**/*.{h,m}'
      CommonUI.public_header_files = 'FJTool/classes/CommonUI/**/*.h'
      CommonUI.dependency   'CRToast'
      CommonUI.dependency   'Toast'
      CommonUI.dependency   'SVProgressHUD'
      CommonUI.dependency   'SCAvatarBrowser'
    end

    s.subspec 'Contacts' do |Contacts|
      Contacts.source_files = 'FJTool/classes/Contacts/**/*.{h,m}'
      Contacts.public_header_files = 'FJTool/classes/Contacts/**/*.h'
    end

    s.subspec 'Color' do |Color|
      Color.source_files = 'FJTool/classes/Color/*.{h,m}'
      Color.public_header_files = 'FJTool/classes/Color/**/*.h'
    end

    s.subspec 'Cache' do |Cache|
      Cache.source_files = 'FJTool/classes/Cache/*.{h,m}'
      Cache.public_header_files = 'FJTool/classes/Cache/**/*.h'
    end

    s.subspec 'Data' do |Data|
      Data.source_files = 'FJTool/classes/Data/*.{h,m}'
      Data.public_header_files = 'FJTool/classes/Data/**/*.h'
    end

    s.subspec 'Date' do |Date|
      Date.source_files = 'FJTool/classes/Date/*.{h,m}'
      Date.public_header_files = 'FJTool/classes/Date/**/*.h'
    end

    s.subspec 'Font' do |Font|
      Font.source_files = 'FJTool/classes/Font/*.{h,m}'
      Font.public_header_files = 'FJTool/classes/Font/**/*.h'
    end

    s.subspec 'Image' do |Image|
      Image.source_files = 'FJTool/classes/Image/*.{h,m}'
      Image.public_header_files = 'FJTool/classes/Image/**/*.h'
      Image.dependency   'SDWebImage'
    end

    s.subspec 'ImageView' do |ImageView|
      ImageView.source_files = 'FJTool/classes/ImageView/*.{h,m}'
      ImageView.public_header_files = 'FJTool/classes/ImageView/**/*.h'
      ImageView.dependency   'CocoaSecurity'
    end

    s.subspec 'Macro' do |Macro|
      Macro.source_files = 'FJTool/classes/Macro/*.{h,m}'
      Macro.public_header_files = 'FJTool/classes/Macro/**/*.h'
    end

    s.subspec 'Network' do |Network|
      Network.source_files = 'FJTool/classes/Network/*.{h,m}'
      Network.public_header_files = 'FJTool/classes/Network/**/*.h'
      Network.dependency   'AFNetworking'
    end

    s.subspec 'Pod' do |Pod|
      Pod.source_files = 'FJTool/classes/Pod/*.{h,m}'
      Pod.public_header_files = 'FJTool/classes/Pod/**/*.h'
    end

    s.subspec 'Region' do |Region|
      Region.source_files = 'FJTool/classes/Region/*.{h,m}'
      Region.public_header_files = 'FJTool/classes/Region/**/*.h'
      Region.dependency   'JSONModel'
    end

    s.subspec 'Storage' do |Storage|
      Storage.source_files = 'FJTool/classes/Storage/*.{h,m}'
      Storage.public_header_files = 'FJTool/classes/Storage/**/*.h'
      Storage.dependency   'JSONModel'
    end

    s.subspec 'String' do |String|
      String.source_files = 'FJTool/classes/String/*.{h,m}'
      String.public_header_files = 'FJTool/classes/String/**/*.h'
    end

    s.subspec 'Translator' do |Translator|
      Translator.source_files = 'FJTool/classes/Translator/*.{h,m}'
      Translator.public_header_files = 'FJTool/classes/Translator/**/*.h'
    end

    s.subspec 'Timer' do |Timer|
      Timer.source_files = 'FJTool/classes/Timer/*.{h,m}'
      Timer.public_header_files = 'FJTool/classes/Timer/**/*.h'
    end

    s.subspec 'UUID' do |UUID|
      UUID.source_files = 'FJTool/classes/UUID/*.{h,m}'
      UUID.public_header_files = 'FJTool/classes/UUID/**/*.h'
    end

    s.subspec 'View' do |View|
      View.source_files = 'FJTool/classes/View/*.{h,m}'
      View.public_header_files = 'FJTool/classes/View/**/*.h'
    end
    
end
