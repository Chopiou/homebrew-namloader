class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v#{version}/Namloader-v#{version}-macos-universal.vst3.tar.gz"
  sha256 "dab4f31e1515ca056748c369a72b74b8147b42ca17949d50e022508812987894"
  version "0.0.7"
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
