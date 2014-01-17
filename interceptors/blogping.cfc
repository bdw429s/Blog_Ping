component {

	property name="settingService" inject="settingService@cb";
	property name="cacheBox" inject="coldbox:cacheManager";
	
	public void function cbadmin_postEntrySave(event, interceptData) async=true {
	    var prc = event.getCollection(private = true);
		prc.blogPingSettings = getColdboxOCM().get('modules-blogping-settings');
		
		if( !structKeyExists(prc, "blogPingSettings") ) {
			var args = {name="blogping"};
			var setting = settingService.findWhere(criteria=args);			
			if( !isNull(setting) ){
				prc.blogPingSettings = deserializeJson(setting.getValue());
			}else{
				prc.blogPingSettings = getModuleSettings("letitsnow").settings;
			}
			getColdboxOCM().set('modules-blogping-settings',prc.blogPingSettings,0,0);
		}
					
		if ( arrayLen(prc.blogPingSettings.pingURLs) ){
			for( var pingURL in prc.blogPingSettings.pingURLs ) {
				new http(url=pingURL, timeout=30).send();
			}
		}
	}
}
