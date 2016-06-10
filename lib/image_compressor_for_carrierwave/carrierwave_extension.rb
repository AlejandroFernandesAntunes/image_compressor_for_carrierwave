module ImageCompressorForCarrierwave
  module CarrierWaveExtension
    def optimize(opts = {})
      ::ImageCompressorForCarrierwave.optimize(current_path, opts)
    end

    def pngquant
      ::ImageCompressorForCarrierwave.pngquant(current_path)
    end
  end
end
