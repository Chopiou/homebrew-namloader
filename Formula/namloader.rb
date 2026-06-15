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
    
    # Debug: check what's in the build directory
    system "ls", "-la", buildpath
    
    # Find the extracted .vst3 bundle
    src = nil
    # Search in current directory
    Dir.glob("**/NAMLoader.vst3").each do |f|
      src = Pathname.new(f) if File.directory?(f)
    end
    # Search in buildpath
    Dir.glob(File.join(buildpath, "**", "NAMLoader.vst3")).each do |f|
      src = Pathname.new(f) if File.directory?(f)
    end
    # Search for Namloader.vst3 too
    Dir.glob("**/Namloader.vst3").each do |f|
      src = Pathname.new(f) if File.directory?(f)
    end
    Dir.glob(File.join(buildpath, "**", "Namloader.vst3")).each do |f|
      src = Pathname.new(f) if File.directory?(f)
    end
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
