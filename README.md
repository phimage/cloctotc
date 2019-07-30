# CLOC TO TC

Convert [CLOC](https://github.com/AlDanial/cloc) JSON result to Teamcity custom statistiques

## Usage

### Launch cloc

```
<path/to/cloc>/cloc-1.82.pl <your directory with code --json > output.json
```

### Launch cloctotc

```
<path/to/cloctotc>/cloctotc output.json > teamcity-info.xml
```

## Install

### Using Homebrew (swiftbrew)

If not already installed yet, install [Swiftbrew](https://github.com/swiftbrew/Swiftbrew) with [Homebrew](https://brew.sh/index_fr)

```
brew install swiftbrew/tap/swiftbrew
```

then type 
```
swift brew install phimage/cloctotc
```
