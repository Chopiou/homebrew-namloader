# chopiou/namloader

Homebrew tap for [Namloader VST3](https://github.com/Chopiou/nam-vst3) — plugin audio pour inference NAM.

## Installation

```bash
brew tap chopiou/namloader
brew install namloader
```

Le plugin sera installe dans `~/Library/Audio/Plug-Ins/VST3/Namloader.vst3`.
Redemarrez votre DAW (Reaper, etc.) pour le detecter.

## Mise a jour

```bash
brew upgrade namloader
```

## Build status

[![Build VST3 macOS Universal](https://github.com/Chopiou/nam-vst3/actions/workflows/build.yml/badge.svg)](https://github.com/Chopiou/nam-vst3/actions/workflows/build.yml)

## Pour les developpeurs

Ce tap est mis a jour automatiquement par la CI de `nam-vst3`:

1. Un tag `vX.Y.Z` est pousse sur `Chopiou/nam-vst3`
2. La CI build le plugin (universal ARM64 + x86_64), ad-hoc sign, package en `.tar.gz`
3. Le SHA256 est calcule et la Formula est mise a jour automatiquement dans ce repo
4. Les utilisateurs font `brew upgrade namloader`
