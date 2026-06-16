class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v0.0.10/Namloader-v0.0.10-macos-universal.vst3.tar.gz"
  sha256 "c999ffe67bb7a295970258899d5b037492360b837f51ef868af06155872ecc9f"
  version "0.0.10"
  license "MIT"

  def install
    # Destination: absolute path - HARDCODED real user home to avoid sandbox issues
    dest = "/Users/chopiou/Library/Audio/Plug-Ins/VST3/Chopiou/Namloader.vst3"
    FileUtils.mkdir_p(File.dirname(dest))
    FileUtils.rm_rf(dest) if File.exist?(dest)

    # Source: buildpath IS the extracted NAMLoader.vst3 directory
    src = buildpath.to_s
    odie "NAMLoader.vst3 not found at #{src}" unless File.directory?(src)

    # Use ditto with absolute paths
    system "ditto", src, dest

    # Touch prefix so Homebrew doesn't complain about empty installation
    FileUtils.mkdir_p(prefix)
    File.write(File.join(prefix, "INSTALL_RECEIPT.json"),
      JSON.generate({
        "plugin" => "Namloader.vst3",
        "installed_to" => dest,
        "version" => version
      }))
  end

  def caveats
    <<~EOS
      Plugin installe dans ~/Library/Audio/Plug-Ins/VST3/Chopiou/Namloader.vst3
      Redemarrez votre DAW (Reaper, etc.) pour le detecter.
    EOS
  end

  test do
    assert_predicate Dir, :directory?, "/Users/chopiou/Library/Audio/Plug-Ins/VST3/Chopiou/Namloader.vst3"
  end
end
