Pod::Spec.new do |s|
    s.name         = 'FJTool'
    s.version      = '0.0.1'
    s.summary      = 'Common basic function'
    s.homepage     = 'https://github.com/jeffnjut/FJTool'
    s.license      = 'MIT'
    s.authors      = {'jeff_njut' => 'jeff_njut@163.com'}
    s.platform     = :ios, '8.0'
    s.source       = {:git => 'https://github.com/jeffnjut/FJTool.git', :tag => s.version}
    s.source_files = 'FJTool/**/*.{h,m}'
    s.resources    = "FJTool/ImageView/images/*.png"
    s.requires_arc = true
end
