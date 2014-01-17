/********************************************************************************
Blog Ping - This is a ContentBox module to automatically and asynchronously 
			ping blog aggregators after you post new entries.  
Copyright 2014 by Alagukannan Alagappan http://www.alagukannan.com
********************************************************************************
Apache License, Version 2.0

Copyright Since [2014] [Brad Wood]

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
********************************************************************************/


component {

	// Module Properties
	this.title 			    = "Blog Ping";
	this.author 			= "Brad Wood";
	this.webURL 			= "http://www.codersrevolution.com";
	this.description 		= "This is a ContentBox module to automatically and asynchronously ping blog aggregators after you post new entries.";
	this.version			= "1.0";
	// If true, looks for views in the parent first, if not found, then in the module. Else vice-versa
	this.viewParentLookup 	= true;
	// If true, looks for layouts in the parent first, if not found, then in module. Else vice-versa
	this.layoutParentLookup = true;
	// Module Entry Point
	this.entryPoint			= "blogping";


	//------------------------------------------------------------------------------------------------
	//------------------------------------------------------------------------------------------------
	function configure() {

		// parent settings
		parentSettings = {};

		// module settings - stored in modules.name.settings
		settings = {
			pingURLs = []
		};

		// Layout Settings
		layoutSettings = {
			defaultLayout = ""
		};

		// datasources
		datasources = {};

		// web services
		webservices = {};

		// SES Routes
		routes = [
			// Module Entry Point
			{pattern="/", handler="home",action="index"},
			// Convention Route
			{pattern="/:handler/:action?"}
		];

		// Custom Declared Points
		interceptorSettings = {
		};

		// Custom Declared Interceptors
		interceptors = [
			{class="#moduleMapping#.interceptors.blogping", name="blogping@blogping"}
		];
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is registered and activated.
	//------------------------------------------------------------------------------------------------
	function onLoad() {
		// Let's add ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Add Menu Contribution
		menuService.addSubMenu(topMenu = menuService.MODULES, name = "blogping", label = "Blog Ping", href = "#menuService.buildModuleLink('blogping','settings')#");	
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is activated by ContentBox
	//------------------------------------------------------------------------------------------------
	function onActivate() {
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		// store default settings
		var args = {name="blogping", value=serializeJSON( settings )};
		var pingSettings = settingService.new(properties=args);
		settingService.save( pingSettings );		
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is unregistered and unloaded
	//------------------------------------------------------------------------------------------------
	function onUnload() {
		// Let's remove ourselves to the main menu in the Modules section
		var menuService = controller.getWireBox().getInstance("AdminMenuService@cb");
		// Remove Menu Contribution
		menuService.removeSubMenu(topMenu=menuService.MODULES,name="blogping");
	}

	//------------------------------------------------------------------------------------------------
	// Fired when the module is deactivated by ContentBox
	//------------------------------------------------------------------------------------------------
	function onDeactivate() {
		var settingService = controller.getWireBox().getInstance("SettingService@cb");
		var args = {name="blogping"};
		var setting = settingService.findWhere(criteria=args);
		if( !isNull(setting) ){
			settingService.delete( setting );
		}
	}

}