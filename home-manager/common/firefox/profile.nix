{
  lib,
  pkgs,
  config,
  ...
}: {
  id = 0;
  isDefault = true;

  settings = {
    "browser.profiles.enabled" = false; # FIXME: https://github.com/nix-community/home-manager/issues/6934
    "privacy.resistFingerprinting" = false;
    "privacy.clearOnShutdown.history" = false;
    "privacy.clearOnShutdown.downloads" = false;
    "browser.startup.page" = 3;
    "middlemouse.paste" = false;
    "general.autoScroll" = true;
    "identity.fxaccounts.enabled" = true;

    "browser.download.autohideButton" = true;
    "browser.aboutConfig.showWarning" = false;
    "browser.urlbar.keepPanelOpenDuringImeComposition" = true;
    "browser.newtabpage.activity-stream.showSearch" = false;

    # Auto enable the extensions
    "extensions.autoDisableScopes" = 0;
    "extensions.update.autoUpdateDefault" = false;
    "extensions.update.enabled" = false;

    # Enable custom stylesheet
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "layout.css.has-selector.enabled" = true;

    # Calculator in URL bar
    "browser.urlbar.suggest.calculator" = true;
    "browser.urlbar.unitConversion.enabled" = true;

    # Rouund
    "widget.gtk.rounded-bottom-corners.enabled" = true;

    "browser.compactmode.show" = true;
    "browser.tabs.allow_transparent_browser" = true;
    "browser.uidensity" = 1;

    # Sidebar
    "sidebar.revamp" = true;
    "sidebar.verticalTabs" = true;
    "sidebar.animation.expand-on-hover.duration-ms" = 100;
    "sidebar.animation.duration-ms" = 100;

    # Sync
    "services.sync.username" = "me@kiranshila.com";
    # Only sync history, bookmarks, tabs
    "services.sync.declinedEngines" = "addresses,addons,passwords,creditcards,prefs";
    "services.sync.engine.addons" = false;
    "services.sync.engine.addresses" = false;
    "services.sync.engine.prefs" = false;
    "services.sync.engine.creditcards" = false;
    "services.sync.engine.passwords" = false; # We're using Pass
  };

  search = {
    force = true;
    default = "ddg";
    privateDefault = "ddg";
    engines = {
      # Disable all the stupid "This time, search with" icons
      ddg.metaData.hidden = true;
      bing.metaData.hidden = true;
      ebay.metaData.hidden = true;
      amazondotcom.metaData.hidden = true;
      wikipedia.metaData.hidden = true;
    };
  };

  extensions = {
    force = true;
    packages = with pkgs.nur.repos.rycee.firefox-addons; [
      ublock-origin
      return-youtube-dislikes
      sponsorblock
      duckduckgo-privacy-essentials
      facebook-container
      zotero-connector
      privacy-badger
      firefox-color
      browserpass
      container-proxy
    ];
    # Extension-specific settings
    settings = {};
  };
}
