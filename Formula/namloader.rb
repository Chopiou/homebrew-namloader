class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v0.0.10/Namloader-v0.0.10-macos-universal.vst3.tar.gz"
  sha256 "c999ffe67bb7a295970258899d5b037492360b837f51ef868af06155872ecc9f"
  version "0.0.10"
  license "MIT"

  def install
    vst3_dir = Pathname.new(Dir.home)/"Library/Audio/Plug-Ins/VST3"
    vst3_dir.mkpath
    
    # Debug: print current directory and buildpath
    system "pwd"
    system "ls", "-la"
    system "ls", "-la", buildpath
    
    # The tarball extracts to a .vst3 bundle directory - find it
    src = Pathname.glob("**/NAMLoader.vst3").first
    src ||= Pathname.glob("**/Namloader.vst3").first
    src ||= Pathname.glob(buildpath/"**/NAMLoader.vst3").first
    src ||= Pathname.glob(buildpath/"**/Namloader.vst3").first
    raise "NAMLoader.vst3 not found in extracted archive" unless src
    
    # Copy the entire .vst3 bundle
    cp_r src, vst3_dir/"Namloader.vst3"
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
