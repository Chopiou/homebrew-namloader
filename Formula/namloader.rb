class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v#{version}/Namloader-v#{version}-macos-universal.vst3.tar.gz"
  sha256 "09b7abbe5d593af238a2e38c4f5271fb237b98cca7048a5b9613f8cf4bb67063"
  version "0.0.8"
  license "MIT"

  def install
    vst3_dir = Pathname.new(Dir.home)/"Library/Audio/Plug-Ins/VST3"
    vst3_dir.mkpath
    cp_r "Namloader.vst3", vst3_dir
  end

  def caveats
    <<~EOS
      Plugin installe dans ~/Library/Audio/Plug-Ins/VST3/Namloader.vst3
      Redemarrez votre DAW (Reaper, etc.) pour le detecter.
    EOS
  end

  test do
    assert_predicate Pathname.new(Dir.home)/"Library/Audio/Plug-Ins/VST3/Namloader.vst3", :exist?
  end
end
