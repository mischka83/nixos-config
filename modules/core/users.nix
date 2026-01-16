{ pkgs, users, ... }:

let user = users.defaultUser; in
{

  users.users.${user.name} = {
    isNormalUser = true;
    description = user.fullName;
    extraGroups = user.groups;
    shell = pkgs.${user.shell};
    ignoreShellProgramCheck = true;
    packages = with pkgs; [ ];
    home = user.home;
  };
}
