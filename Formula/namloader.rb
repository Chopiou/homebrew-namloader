class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v0.0.10/Namloader-v0.0.10-macos-universal.vst3.tar.gz"
  sha256 "c999ffe67bb7a295970258899d5b037492360b837f51ef868af06155872ecc9f"
  version "0.0.10"
  license "MIT"

  def install
    # Destination: ~/Library/Audio/Plug-Ins/VST3/Namloader.vst3
    # Use Pathname for proper home expansion in Homebrew sandbox
    dest = Pathname.new("~").expand_path + "Library/Audio/Plug-Ins/VST3/Namloader.vst3"
    vst3_dir = dest.dirname
    FileUtils.mkdir_p(vst3_dir)

    # Source: buildpath IS the extracted NAMLoader.vst3 directory
    src = buildpath.to_s
    odie "NAMLoader.vst3 not found at #{src}" unless File.directory?(src)

    # Remove old version if present, then copy via system cp
    FileUtils.rm_rf(dest) if File.exist?(dest)
    FileUtils.mkdir_p(dest.dirname)
    
    # Use explicit absolute paths for both src and dest
    system "cp", "-pR", src, dest.to_s

    # Touch prefix so Homebrew doesn't complain about empty installation
    FileUtils.mkdir_p(prefix)
    File.write(prefix/"INSTALL_RECEIPT.json",
      JSON.generate({
        "plugin" => "Namloader.vst3",
        "installed_to" => dest.to_s,
        "version" => version
      }))
  end

  def caveats
    <<~EOS
      Plugin installe dans ~/Library/Audio/Plug-Ins/VST3/Namloader.vst3
      Redemarrez votre DAW (Reaper, etc.) pour le detecter.
    EOS
  end

  test do
    assert_predicate Dir, :directory?, Pathname.new("~").expand_path + "Library/Audio/Plug-Ins/VST3/Namloader.vst3"
  end
end
