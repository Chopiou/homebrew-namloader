class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v#{version}/Namloader-v#{version}-macos-universal.vst3.tar.gz"
  sha256 "5d783733dc371e92a8de98afffb271862687c42769affa0594ab957bab2e69ef"
  version "0.0.9"
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
