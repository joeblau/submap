# Submap

Open-source iOS multi-modal agent

## Developer Setup

Prerequisites: [Homebrew](https://brew.sh)

```sh
# Clone repository
git clone https://github.com/joeblau/submap.git
cd submap

# Bootstrap Project Dependencies
brew bundle --file=./.github/Brewfile

# Start Project
xcodegen
```

Add `.env` with API KEYS

```dotenv
OPENAI_API_KEY=""
```