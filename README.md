# image_compressor_for_carrierwave

Based on piet gem https://github.com/albertbellonch/piet (changed to use pngquantizer as default for PNG images),
On your CarrierWave uploader, include the extension:

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  ...
  include ImageCompressorForCarrierwave::CarrierWaveExtension
  ...
end
```

call the optimize method on the uploader:
```ruby
class ImageUploader < CarrierWave::Uploader::Base
  ...
  process :optimize
  ...
end
```

passing parameters to encoders only used for the jpeg compression:

```ruby
process optimize: [{ verbose: false, quality: 65 }]
```

Won't process images smaller than 500KB or as established in the ENV SKIP_COMPRESSION_IMAGE_FILE_IN_KB.
