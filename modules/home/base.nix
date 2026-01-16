{ pkgs, users, versions, ... }:

let user =  users.defaultUser; in
{
  home = {
    username = user.name;
    homeDirectory = user.home;
    stateVersion = versions.homeStateVersion;
  };
}
