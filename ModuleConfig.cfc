component {
	// Module Properties
	this.title 				= "dotenvsettings";
	this.author 			= "Sean Daniels";
	this.description 		= "Based on Eric Peterson's CommandBox Module. This module reads values from your .env (or other secrets config file) and adds the values to ColdBox settings.";
	this.version			= "1.0.0+0001";

	function configure() {
	}

	function onLoad() {
		// parse parent settings
		parseParentSettings();

		var oConfig = controller.getConfigSettings();
		var envFilePath = '#oConfig.ApplicationPath##controller.getSetting("dotenv").fileName#';

		if (fileExists(envFilePath)) {
			var envStruct = {};

			var envFile = fileRead(envFilePath);
			if (isJSON(envFile)) {
				envStruct = deserializeJSON(envFile);
			}
			else { // assume it is a .properties file
				var properties = createObject('java', 'java.util.Properties').init();
				properties.load(CreateObject('java', 'java.io.FileInputStream').init(envFilePath));
				envStruct = properties;
			}

			// Append to Settings
			for (var key in envStruct) {
				controller.setSetting(key, envStruct[key]);
				log.info("Added environment secret #key# to settings");
			}
		} else {
			log.warn("No environment settings file detected at #envFilePath#");
		}
	}

	private function parseParentSettings(){
		var oConfig 		= controller.getSetting( "ColdBoxConfig" );
		var configStruct 	= controller.getConfigSettings();
		var dotenv 			= oConfig.getPropertyMixin( "dotenv", "variables", structnew() );

		//defaults
		configStruct.dotenv = {
			// The .env file location, relative to parent app root
			"fileName" : ".env"
		};

		// incorporate settings
		structAppend( configStruct.dotenv, dotenv, true );
	}
}