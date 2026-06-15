class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v0.0.10/Namloader-v0.0.10-macos-universal.vst3.tar.gz"
  sha256 "c999ffe67bb7a295970258899d5b037492360b837f51ef868af06155872ecc9f"
  version "0.0.10"
  license "MIT"

  def install
    # Destination: ~/Library/Audio/Plug-Ins/VST3/Namloader.vst3
    vst3_dir = Pathname.new(Dir.home)/"Library/Audio/Plug-Ins/VST3"
    vst3_dir.mkpath
    dest = vst3_dir/"Namloader.vst3"

    # Source: buildpath/NAMLoader.vst3 (extracted directly from tarball)
    src = buildpath/"NAMLoader.vst3"
    odie "NAMLoader.vst3 not found at #{src}" unless src.exist?

    # Remove old version if present, then copy
    dest.rmtree if dest.exist?
    src.cp_r(dest)

    # Touch prefix so Homebrew doesn't complain about empty installation
    (prefix/"INSTALL_RECEIPT.json").write(
      JSON.generate({
        "plugin" => "Namloader.vst3",
        "installed_to" => dest.to_s,
        "version" => version
      })
    )
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
