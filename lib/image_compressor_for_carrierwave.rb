require 'png_quantizator'
require 'image_compressor_for_carrierwave/carrierwave_extension'

module ImageCompressorForCarrierwave
  class << self
    def optimize(path, opts={})
      return true if Rails.env.test?
      output = optimize_for(path, opts)
      puts output if opts[:verbose]
      true
    end

    def pngquant(path)
      PngQuantizator::Image.new(path).quantize!
    end

    private

    def optimize_for(path, opts)
      human_size = number_to_human_size(File.open(path).size)
      file_size_digit = human_size.to_i
      file_size_unit = human_size.chomp[-2..-1]

      return if skip_compression file_size_unit, file_size_digit

      case mimetype(path)
      when 'png', 'gif' then optimize_png(path, opts)
      when 'jpeg' then optimize_jpg(path, opts)
      end
    end

    def skip_compression(file_size_unit, file_size_digit)
      return file_size_unit.downcase == 'kb' && file_size_digit <= 500 ||
        file_size_digit <= ENV['SKIP_COMPRESSION_IMAGE_FILE_IN_KB'].to_i
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
