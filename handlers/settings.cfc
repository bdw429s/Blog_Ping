component{

	// DI
	property name="settingService" inject="settingService@cb";
	property name="cb" inject="cbHelper@cb";

	CRLF = chr(13)&chr(10);

	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	public void function index(event,rc,prc){	
		prc.xehSave = cb.buildModuleLink("blogping","settings.save"); // Exit handler
		prc.tabModules_blogping = true;
		var args = {name="blogping"};
		var setting = settingService.findWhere(criteria=args);
		prc.pingURLs = '';
		if( !isNull(setting) ){
			var pingURLsArray = deserializeJson(setting.getValue()).pingURLs;
			if( isArray(pingURLsArray) ) {
				for( var pingURL in pingURLsArray ) {
					prc.pingURLs &= pingURL & CRLF;
				}
			}
		}	
		event.setView("settings/index");
	}

	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	public function save(event, rc, prc) {
		prc.settings = {};
		prc.settings.pingURLs = listToArray(trim(rc.pingURLs), CRLF);
		
		// Save settings
		var args = {name="blogping"};
		var setting = settingService.findWhere(criteria=args);
		setting.setValue( serializeJSON( prc.settings ) );
		settingService.save( setting );
		//save to cachebox
		getColdboxOCM().set('modules-blogping-settings',event.getValue(name='settings',private=true,defaultValue={}),0,0);
		// Messagebox
		getPlugin("MessageBox").info("Settings Saved & Updated!");
		setNextEvent('cbadmin.module.blogping.settings');
	}
}