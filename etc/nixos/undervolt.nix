{ config, pkgs, ... }:

let
  # Profilj na čorno-pomarančevomu
  profileXml = ''
<?xml version="1.0"?>
<PROFILE active="true" name="_global_" exe="_global_">
	<CPU active="false" physicalId="0">
		<CPU_CPUFREQ_MODE active="true" mode="CPU_CPUFREQ">
			<NOOP active="false" />
			<CPU_CPUFREQ active="true" scalingGovernor="performance" eppHint="power" />
		</CPU_CPUFREQ_MODE>
		<CPU_USAGE active="true" />
		<CPU_FREQ_PACK active="true" />
	</CPU>
	<GPU active="true" index="0" deviceid="7480" revision="CF">
		<AMD_PM_PERFMODE active="true" mode="AMD_PM_ADVANCED">
			<NOOP active="false" />
			<AMD_PM_ADVANCED active="true">
				<AMD_PM_OVERDRIVE active="true">
					<AMD_PM_FREQ_RANGE active="true" id="sclk">
						<STATE index="0" freq="255" />
						<STATE index="1" freq="2600" />
					</AMD_PM_FREQ_RANGE>
					<AMD_PM_FREQ_RANGE active="true" id="mclk">
						<STATE index="0" freq="97" />
						<STATE index="1" freq="1125" />
					</AMD_PM_FREQ_RANGE>
					<AMD_PM_VOLT_OFFSET active="true" value="-50" />
				</AMD_PM_OVERDRIVE>
				<AMD_PM_POWER_PROFILE active="true" mode="3D_FULL_SCREEN" />
				<AMD_PM_POWERCAP active="true" value="150" />
			</AMD_PM_ADVANCED>
			<AMD_PM_FIXED active="false" mode="low" />
			<AMD_PM_AUTO active="false" />
		</AMD_PM_PERFMODE>
		<AMD_FAN_SPEED_RPM active="true" />
		<AMD_ACTIVITY active="true" />
		<AMD_POWER active="true" />
		<AMD_FAN_MODE active="true" mode="AMD_OD_FAN_CURVE">
			<NOOP active="false" />
			<AMD_OD_FAN_CURVE active="true" stop="true" stopTemp="50">
				<CURVE>
					<POINT temp="35" speed="20" />
					<POINT temp="50" speed="35" />
					<POINT temp="60" speed="55" />
					<POINT temp="70" speed="75" />
					<POINT temp="80" speed="100" />
				</CURVE>
			</AMD_OD_FAN_CURVE>
			<AMD_OD_FAN_AUTO active="false" />
		</AMD_FAN_MODE>
		<AMD_GPU_VOLT active="true" />
		<AMD_GPU_MEMORY_TEMP active="true" />
		<AMD_MEM_USAGE active="true" />
		<AMD_GPU_JUNCTION_TEMP active="true" />
		<AMD_GPU_TEMP active="true" />
		<AMD_MEM_FREQ active="true" />
		<AMD_GPU_FREQ active="true" />
	</GPU>
</PROFILE>
  '';

  # Skrypt arxivuvannja
  underljarvosProfile = pkgs.runCommand "_global_.ccpro" { 
    nativeBuildInputs = [ pkgs.zip ]; 
  } ''
    mkdir -p temp
    echo '${profileXml}' > temp/profile.xml
    cd temp
    zip -r $out profile.xml
  '';
in

{

  # Stvorennja arxivu profilju dlja CoreCtrl za dyrektorijeju
  home-manager.users.kvarnitz = {
    xdg.configFile."corectrl/profiles/underljarvos.ccpro".source = underljarvosProfile;
    systemd.user.services.corectrl = {
      Unit = {
        Description = "CoreCtrl GPU zajob";
        After = [ "basic.target" ];
      };
      Service = {
        Type = "simple";
        ExecStartPre = "${pkgs.coreutils}/bin/sleep 5";
        ExecStart = "${pkgs.corectrl}/bin/corectrl --minimize-systray";
        Environment = [
          "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
          "QT_QPA_PLATFORM=offscreen"
        ];
        Restart = "on-failure";
        RestartSec = "5s";
      };
      Install = {
        WantedBy = [ "default.target" ];
      };
    };
  };

  # Rozblokuvannja dostupu keruvannja AMD vidikom ta pocykom
  boot.kernelModules = [ "msr" ];
  boot.kernelParams = [ "msr.allow_writes=on" ];

  # Uvimknennja vyrodkiv dlja Undervolt
  programs.corectrl.enable = true;
  hardware.amdgpu.overdrive = {
    enable = true;
    ppfeaturemask = "0xffffffff";
  };
  environment.systemPackages = with pkgs; [ amdctl ];

  # Undervolt amdctl (dlja procyka)
  systemd.services.cpu-undervolt = {
      description = "Vstanovlennja zajobu Ryzen 5 3600 Undervolt (1050mV)";
      after = [ "multi-user.target" ];
      wantedBy = [ "multi-user.target" ];
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.amdctl}/bin/amdctl -m -p 0 -v 80";
        RemainAfterExit = true;
      };
    };

  # Prava CoreCtrl (ŝoby poxuj bulo)
  users.users.kvarnitz.extraGroups = [ "corectrl" ];
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if ((action.id == "org.corectrl.helper.init" ||
             action.id == "org.corectrl.helperkiller.init" ||
             action.id == "org.corectrl.helper.check" ||
             action.id == "org.corectrl.helper.control") &&
            subject.isInGroup("users")) {
            return polkit.Result.YES;
        }
    });
  '';
}
