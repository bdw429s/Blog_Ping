<cfoutput>
<!--============================Sidebar============================-->
<div class="sidebar">
	<!--- Info Box --->
	<div class="small_box expose">
		<div class="header">
			<img src="#prc.cbroot#/includes/images/info.png" alt="info" width="24" height="24" />Need Help?
		</div>
		<div class="body">
			<p>
				<strong>Blog Ping</strong> - This is a ContentBox module to automatically and asynchronously ping blog aggregators after you post new entries.
			</p>
		</div>
	</div>

</div>
<!--End sidebar-->
<!--============================Main Column============================-->
<div class="main_column">
	<div class="box">
		<!--- Body Header --->
		<div class="header">
			Blog Ping Settings
		</div>
		<!--- Body --->
		<div class="body" id="mainBody">
			#getPlugin("MessageBox").renderit()#
			#html.startForm(action=prc.xehSave,name="settingsForm")#

			<div class="body_vertical_nav clearfix">
				<div class="main_column">
				<!-- Content area that will show the form and stuff -->
				<div class="panes_vertical">

				<!--- Settings --->
				<div>
				<fieldset>
				<legend><i class="icon-cogs"></i> <strong>Settings</strong></legend>
					<p>Specify the ping URLs, one per line.</p>


					#html.textArea(name="pingURLS",value=prc.pingURLS,required=true,rows=10)#							
				</fieldset>
				</div>

				</div> <!--- end vertical panes --->
				</div> <!--- end main_column --->

			</div> <!--- End vertical nav --->

			<!--- Submit --->
            <div class="actionBar center">
                    #html.submitButton(value="Save Settings",class="buttonred",title="Save settings")#
            </div>

			#html.endForm()#

		</div>
	</div>
</div>
</cfoutput>
