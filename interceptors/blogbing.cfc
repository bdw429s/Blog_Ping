component {

	property name="settingService" inject="settingService@cb";
	property name="cacheBox" inject="coldbox:cacheManager";
	
	public void function cbui_beforeHeadEnd(event, interceptData) {
	    var prc = event.getCollection(private = true);
		prc.snowSettings = {};
		
		//check if settings in coldbox cache
		if (getColdboxOCM().lookup('modules-let-it-snow-settings') eq false){
			var args = {name="LetItSnow"};
			var setting = settingService.findWhere(criteria=args);			
			if( !isNull(setting) ){
				prc.snowSettings = deserializeJson(setting.getValue());
			}else{
				prc.snowSettings = getModuleSettings("letitsnow").settings;
			}
			//save to cachebox
			getColdboxOCM().set('modules-let-it-snow-settings',prc.snowSettings,0,0);
		}else{
			prc.snowSettings = getColdboxOCM().get('modules-let-it-snow-settings');
		}	
		if (not structisEmpty(prc.snowSettings)){
			//render the cached snowstorm template
			appendToBuffer( renderview(view='settings/template',module='LetItSnow') );		
		}
	}
}
