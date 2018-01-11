# symlink this file to ~/.nixpkgs/config.nix
{
  allowUnfree = true;

  packageOverrides = super: let self = super.pkgs; in with self; rec {

    # Purescript is a top-level Nix package (e.g., nix-env -iA
    # nixpkgs.purescript), but it is also a Haskell library. We can
    # plow ahead through dependency problems with `doJailbreak` here.
    purescript = super.haskell.lib.doJailbreak super.purescript;

    hello_world = stdenv.mkDerivation {
      name = "hello_world";
      src = ~/.dotfiles/src/hello_world;
      libmikey = libmikey;
      installPhase = ''
      mkdir -p $out/bin
      cp hello_world $out/bin/hello_world
      '';
    };

    libmikey = callPackage ~/.dotfiles/nix/pkgs/libmikey {};

    linuxOnly = buildEnv {
      name = "linuxOnly";
      paths = [
        # php development
        drush
        php

        # rust (not available on nix/darwin)
        rustPlatform.rustc
        rustPlatform.cargo

        # c
        clang
        libmjh

        # other
        mdk
      ];
    };

    linuxEnv = buildEnv {
      name = "linuxEnv";
      paths = [
        devEnv
        linuxOnly
      ];
    };

    phpEnv = buildEnv {
      name = "phpEnv";
      paths = [
        drush
        php
      ];
    };

    rEnv = super.rWrapper.override {
      packages = with self.rPackages; [
        ggplot2
        data_table
        plyr
        lubridate
        ascii
        plotly
      ];
    };

    # An example nix package that builds GNU's `hello'. See the
    # `example-pkg-hello' directory for how this is set up. Taken from
    # the Nix manual:
    # http://nixos.org/nix/manual/#chap-writing-nix-expressions
    #
    # to build, for instance:
    # $ nix-build "<nixpkgs>" -A example-pkg-hello
    example-pkg-hello = callPackage ~/.dotfiles/nix/pkgs/example-pkg-hello {};


    # ----------------
    # Haskell packages
    # ----------------
    #
    # Overrides to the nix Haskell package set.
    haskellPackages = super.haskellPackages.override {
      overrides = self: super: with haskell.lib; {
        # ----------------------------------
        # -- A little note to future self --
        # ----------------------------------
        #
        # Haskell packages will commonly fail with dependency or test
        # failures. Two functions help out here: `doJailbreak` and
        # `dontCheck`. `doJailbreak` essentially says, ignore all
        # dependency version constraints and try to compile
        # anyway. `dontCheck` does not run tests (of course it still
        # fails if compilation fails).
        #
        # If that doesn't work, and the package itself must be fixed,
        # the steps are:
        #
        # 1. Fork the package, download locally.
        # 2. Use cabal2nix --shell to generate a shell.nix file.
        # 3. nix-shell shell.nix. Try to get compiling again using just
        #    `cabal build`.
        # 4. Push up PR with fix.
        # 5. Meanwhile let's override the `src` in the original derivation.
        #    Use `nix-prefetch-git` to get the necessary info, e.g.:
        #
        #    $ nix-prefetch-git https://github.com/mjhoy/psc-package.git 039a42ba780a4f8e342e578177f584d13a6288a7
        #
        #    Now use the output from this in an override:
        #    psc-package = super.psc-package.overrideAttrs (oldAttrs: { src = fetchgit { ... } })

        # Heist's test suite is failing in OSX.
        # heist = dontCheck super.heist;

        # process-extras test suit fails on darwin. See:
        # https://github.com/seereason/process-extras/issues/10
        # process-extras = dontCheck super.process-extras;

        # hakyll's test suite requires `util-linux` for some silly
        # reason.
        # hakyll = dontCheck super.hakyll;

        # Point at current master, where dependency issues have been
        # fixed.
        snap-loader-dynamic = self.callPackage ~/.dotfiles/nix/pkgs/snap-loader-dynamic { };
      } // (if stdenv.isDarwin then {
        # macOS-specific overrides

        # https://github.com/NixOS/nixpkgs/issues/29724
        foundation = dontCheck super.foundation;
      } else {});
    };

    nodejsEnv = with pkgs; buildEnv {
      name = "nodeEnv";
      paths = [
        nodejs-0_10
      ];
    };


    # ---------------------
    # Developer environment
    # ---------------------
    #
    # To install all at once:
    # $ nix-env -iA nixpkgs.devEnv

    devEnv = buildEnv {
      name = "devEnv";
      paths = [
        myHaskellEnv
        cabal2nix

        # diagrams-builder

        # coq
        # emacs24Packages.proofgeneral

        # useful tools
        ag
        cloc
        cmake
        emacs
        git
        htop
        lynx
        mu
        nasm
        parallel
        pass
        psc-package
        ripgrep
        tmux
        wget
        nix-prefetch-git

        # aspell dictionaries
        aspell
        aspellDicts.en
        aspellDicts.es
      ];
    };

    # haskell environment
    myHaskellEnv = haskellPackages.ghcWithHoogle (p: with p; [
      cabal-install
      ghc-mod
      hlint
      QuickCheck
      hspec
      hasktags

      # useful libraries...
      # MonadCatchIO-transformers # Dependency problem
      Crypto
      HaXml
      MonadRandom
      Unixutils
      aeson
      array
      aws
      base64-bytestring
      blaze-html
      bytestring
      containers
      digestive-functors
      digestive-functors-snap
      digestive-functors-heist
      extra
      filepath
      hakyll
      HandsomeSoup
      hscurses
      hsexif
      hspec
      hspec-core
      hxt
      io-streams
      lens
      mtl
      optparse-applicative
      pandoc
      parsec
      postgresql-simple
      process
      readable
      regex-applicative
      regex-base
      regex-compat
      regex-posix
      regex-tdfa
      scotty
      shakespeare
      snap
      snap-loader-dynamic
      snap-loader-static
      snap-templates
      snaplet-postgresql-simple
      split
      text
      time
      transformers
      turtle
      unordered-containers
      uuid
      vector
      wreq
    ]);

    myPythonEnv = self.myEnvFun {
      name = "mypython3";
      buildInputs = [
        python3
        python3Packages.matplotlib
      ];
    };

    # build emacs from source
    emacs-master = pkgs.stdenv.lib.overrideDerivation pkgs.emacs (oldAttrs: {
      name = "emacs-master";
      src = ~/src/emacs;
      buildInputs = oldAttrs.buildInputs ++ [
        pkgs.autoconf pkgs.automake
      ];
      doCheck = false;
    });
  };
}
