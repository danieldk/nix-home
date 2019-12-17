self: super:

{
  rocm = super.rocm // {
    hip = super.rocm.hip.overrideAttrs (attrs: rec {
      patches = attrs.patches or [] ++ [
        # Fixes race condition in hipEventRecord, remove with ROCM 3.0.
        # https://github.com/ROCm-Developer-Tools/HIP/pull/1620
        (super.fetchpatch {
          name = "fix-hipEventRecord-race.patch";
          url = "https://patch-diff.githubusercontent.com/raw/ROCm-Developer-Tools/HIP/pull/1620.patch";
          sha256 = "1v81ss1ls6jyg2mfspz6zq8a4ajkz5qfhgfwvqrsaih9rbjy8n76";
        })
      ];
    });
  };
}
