# Prepare source code for CRAN release

## Preparation steps

1. Discard all changes made to meet CRAN rules
```sh
git reset --hard
```

2. Pull latest changes from the repository
```sh
git pull origin latest
```

3. Run Code Patches to meet CRAN rules
Run the following code from the root directory of the package.
```sh
R -f "inst/patch_highs.R"
```

## Update HiGHS options
```sh
R -f parse_highs_options.R
```


