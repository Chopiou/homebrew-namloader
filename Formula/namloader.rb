class Namloader < Formula
  desc "Namloader VST3 plugin - template reusable pour inference NAM"
  homepage "https://github.com/Chopiou/nam-vst3"
  url "https://github.com/Chopiou/nam-vst3/releases/download/v0.0.10/Namloader-v0.0.10-macos-universal.vst3.tar.gz"
  sha256 "c999ffe67bb7a295970258899d5b037492360b837f51ef868af06155872ecc9f"
  version "0.0.10"
  license "MIT"

  def install
    # Install the .vst3 bundle into the Cellar (sandbox-safe)
    # The buildpath IS the extracted NAMLoader.vst3 directory
    src = buildpath.to_s
    odie "NAMLoader.vst3 not found at #{src}" unless File.directory?(src)

    # Install to prefix/Namloader.vst3 (sandbox-safe)
    dest = prefix/"Namloader.vst3"
    FileUtils.rm_rf(dest) if File.exist?(dest)
    system "ditto", buildpath.to_s, dest

    # Create INSTALL_RECEIPT.json
    FileUtils.mkdir_p(prefix)
    File.write(File.join(prefix, "INSTALL_RECEIPT.json"),
      JSON.generate({
        "plugin" => "Namloader.vst3",
        "installed_to" => dest.to_s,
        "version" => version
      }))
  end

  def post_install
    # After installation (outside sandbox), create the VST3 folder and symlink
    # This runs outside the sandbox
    home = ENV["HOME"]
    dest = File.join(home, "Library", "Audio", "Plug-Ins", "VST3", "Chopiou", "Namloader.vst3")
    FileUtils.mkdir_p(File.dirname(dest))
    FileUtils.rm_rf(dest) if File.exist?(dest)
    FileUtils.ln_s(opt_prefix/"Namloader.vst3", dest)
  end

  def caveats
    <<~EOS
      Plugin installe dans ~/Library/Audio/Plug-Ins/VST3/Chopiou/Namloader.vst3
      Redemarrez votre DAW (Reaper, etc.) pour le detecter.
    EOS
  end

  def uninstall
    # Remove symlink on uninstall
    home = ENV["HOME"]
    dest = File.join(home, "Library", "Audio", "Plug-Ins", "VST3", "Chopiou", "Namloader.vst3")
    FileUtils.rm_f(dest) if File.symlink?(dest)
  end

  test do
    # Test that the plugin exists in the Cellar
    assert_predicate Dir, :directory?, opt_prefix/"Namloader.vst3"
  end
end
