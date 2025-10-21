{
  DisableTelemetry = true;
  DNSOverHTTPS = {
    Enabled = true;
    ProviderURL = "https://dns.mullvad.net/dns-query";
  };
  EnableTrackingProtection = {
    Value = true;
    Locked = false;
    Cryptomining = true;
    Fingerprinting = true;
  };

  # Disables the “Import data from another browser” option in the bookmarks window.
  DisableProfileImport = true;
  DisablePocket = true;
  DisableFirefoxStudies = true;
  DisableFirefoxScreenshots = true;
  DontCheckDefaultBrowser = true;
  OfferToSaveLogins = false;
  SearchSuggestEnabled = false;

  # Turn off all the bullshit suggestions
  FirefoxSuggest = {
    Locked = true;
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
  };

  DisplayMenuBar = "default-off";

  # Home only shows search
  FirefoxHome = {
    Search = true;
    Locked = false;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    SponsoredPocket = false;
    Snippets = false;
  };

  DisplayBookmarksToolbar = "never"; # I don't even really use bookmarks

  OverrideFirstRunPage = "";
  PictureInPicture.Enabled = false; # I don't ever want this

  HardwareAcceleration = true;
  TranslateEnabled = true;

  # Default start page of previous session
  Homepage.StartPage = "previous-session";

  UserMessaging = {
    UrlbarInterventions = false;
    SkipOnboarding = true;
  };
}
