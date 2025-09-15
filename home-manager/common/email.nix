# EMail (Thunderbird)
{
  pkgs,
  config,
  lib,
  ...
}: {
  accounts.email.accounts = {
    "me@kiranshila.com" = {
      primary = lib.mkDefault true;
      thunderbird.enable = lib.mkDefault true;
      address = "me@kiranshila.com";
      userName = "me@kiranshila.com";
      realName = "Kiran Shila";
      imap = {
        host = "imap.migadu.com";
        port = 993;
      };
      smtp = {
        host = "smtp.migadu.com";
        port = 465;
      };
    };
    "kshila@caltech.edu" = {
      thunderbird = {
        enable = true;
        settings = id: {
          # Use OAuth2 for IMAP and SMTP
          "mail.server.server_${id}.authMethod" = 10;
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
      address = "kshila@caltech.edu";
      userName = "kshila@caltech.edu";
      realName = "Kiran Shila";
      imap = {
        host = "outlook.office365.com";
        port = 993;
      };
      smtp = {
        host = "smtp.office365.com";
        port = 587;
        tls.useStartTls = true;
      };
    };
  };

  # Thunderbird configuration
  programs.thunderbird = {
    package = config.lib.nixGL.wrap pkgs.thunderbird;
    enable = true;
    profiles.default = {
      isDefault = true;
      withExternalGnupg = true;
    };
    settings = {
      "privacy.donottrackheader.enabled" = true;
      "mailnews.start_page.enabled" = false;
      "mailnews.default_view_flags" = 0; # Unthreaded
      "mailnews.default_sort_order" = 1; # Sort ascending (new messages at bottom)
      "mail.threadpane.listview" = 1; # List view instead of pane-view
      "mail.default_send_format" = 1; # Plaintext only
      "mail.identity.default.reply_on_top" = 0; # Bottom-reply always
      "mail.identity.default.compose_html" = false; # Never compose HTML
    };
  };
}
