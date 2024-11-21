class InlineSassGenerator < Jekyll::Generator
  require 'digest/md5'

  SASS_FILE = './assets/main.scss'

  def generate(site)
    site.find_converter_instance(Jekyll::Converters::Scss)
        .convert(File.read(SASS_FILE))
        .tap { |styles| site.data['md5'] = Digest::MD5.hexdigest(styles)[0,6] }
  end
end