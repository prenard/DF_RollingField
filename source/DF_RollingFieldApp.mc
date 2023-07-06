// 
// Prod id = 49260F391C39471F863791C9B9C55F7D
// Dev id  = 19f099f43c8b428f88576cd9c879b40d
//

// History:
//
// 2018-02-11: Version 1.11
//
//		* Create Development branch
//
// 2017-12-27: Version 1.10
//
//		* CIQ 2.41 to support Edge 1030
//      * 1030 support
//

using Toybox.Application as App;
using Toybox.WatchUi as Ui;

var AppVersion="1.24-04";

class DF_RollingFieldApp extends App.AppBase
{

	//var Garmin_Device_Type;
	var deviceFamily;

    function initialize()
    {
        AppBase.initialize();

        deviceFamily = Toybox.WatchUi.loadResource(Rez.Strings.deviceFamily);
        System.println("deviceFamily = " + deviceFamily);

		System.println("Device Part Number = " + System.getDeviceSettings().partNumber);
		System.println("Device Firmware Version = " + System.getDeviceSettings().firmwareVersion);

        //Garmin_Device_Type = Ui.loadResource(Rez.Strings.Device);
        //System.println("Device Type = " + Ui.loadResource(Rez.Strings.Device));

		System.println("Battery Level = " + System.getSystemStats().battery);
		System.println("Total Memory = " + System.getSystemStats().totalMemory);
		System.println("Used Memory = " + System.getSystemStats().usedMemory);
    }

    //! onStart() is called on application start up
    function onStart(state)
    {
    }

    //! onStop() is called when your application is exiting
    function onStop(state)
    {
    }

    //! Return the initial view of your application here
    function getInitialView()
    {
        //var AppVersion = Ui.loadResource(Rez.Strings.AppVersion);
		System.println("AppVersion = " + AppVersion);
		setProperty("App_Version", AppVersion);

		var Args = new [4];

		// var T;
		
		var Label_Value = new [10];
		var Duration_Value = new [10];

		for (var i = 0; i < Label_Value.size() ; ++i)
       	{
       	   Label_Value[i] = null;
       	   Duration_Value[i] = 0;
		}


		Label_Value[0] = getProperty("Field_Time_Label");
		Duration_Value[0] =  readPropertyKeyInt("Field_Time_Duration",2);

		Label_Value[1] = getProperty("Field_Timer_Label");
		Duration_Value[1] = readPropertyKeyInt("Field_Timer_Duration",2);

		Label_Value[2] = getProperty("Field_Distance_Label");
		Duration_Value[2] = readPropertyKeyInt("Field_Distance_Duration",2);

		Label_Value[3] = getProperty("Field_TimeOfDay_Label");
		Duration_Value[3] = readPropertyKeyInt("Field_TimeOfDay_Duration",2);

		Label_Value[4] = getProperty("Field_DistanceToDestination_Label");
		Duration_Value[4] = readPropertyKeyInt("Field_DistanceToDestination_Duration",0);
				
		//T  = getProperty("DF_Title");

		Args[0] = Label_Value;
		Args[1] = Duration_Value;
		
		//System.println(D_Time + " / " + D_Distance);

		//return [ new DF_RollingFieldView(Label_Value, Duration_Value, T, V) ];
		return [ new DF_RollingFieldView(Args) ];
	
    }

	function readPropertyKeyInt(key,thisDefault)
	{
		//var value = getProperty(key);
		var value = Application.Properties.getValue(key);
		
		
        if(value == null || !(value instanceof Number))
        {
        	if(value != null)
        	{
            	value = value.toNumber();
        	}
        	else
        	{
                value = thisDefault;
        	}
		}
		return value;
	}

}