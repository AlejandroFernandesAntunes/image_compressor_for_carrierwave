require 'png_quantizator'
require 'image_compressor_for_carrierwave/carrierwave_extension'

module ImageCompressorForCarrierwave
  class << self
    def optimize(path, opts={})
      output = optimize_for(path, opts)
      puts output if opts[:verbose]
      true
    end

    def pngquant(path)
      PngQuantizator::Image.new(path).quantize!
    end

    private

    def optimize_for(path, opts)
      case mimetype(path)
      when 'png', 'gif' then optimize_png(path, opts)
      when 'jpeg' then optimize_jpg(path, opts)
      end
    end

    def mimetype(path)
      IO.popen(['file', '--brief', '--mime-type', path], in: :close, err: :close){|io| io.read.chomp.sub(/image\//, '')}
    end

    def optimize_png(path, opts)
      pngquant(path)
    rescue Exception => error
      puts "Toubles applying quantizer:  #{error}"
    end

    def optimize_jpg(path, opts)
      quality = (0..100).include?(opts[:quality]) ? opts[:quality] : 100
      vo = opts[:verbose] ? '-v' : '-q'
      path.gsub!(/([\(\)\[\]\{\}\*\?\\])/, '\\\\\1')
      `#{command_path("jpegoptim")} -f -m#{quality} --strip-all #{opts[:command_options]} #{vo} #{path}`
    end

    def command_path(command)
      command
    end

  end
end
