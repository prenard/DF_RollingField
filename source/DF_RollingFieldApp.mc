using Toybox.Application as App;

class DF_RollingFieldApp extends App.AppBase {

    function initialize()
    {
        AppBase.initialize();
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
		var Args = new [4];

		var T, V;
		
		var Label_Value = new [10];
		var Duration_Value = new [10];

		for (var i = 0; i < Label_Value.size() ; ++i)
       	{
       	   Label_Value[i] = null;
       	   Duration_Value[i] = 0;
		}


		Label_Value[0] = getProperty("Field_Time_Label");
		Duration_Value[0] = getProperty("Field_Time_Duration");

		Label_Value[1] = getProperty("Field_Timer_Label");
		Duration_Value[1] = getProperty("Field_Timer_Duration");

		Label_Value[2] = getProperty("Field_Distance_Label");
		Duration_Value[2] = getProperty("Field_Distance_Duration");

		Label_Value[3] = getProperty("Field_TimeOfDay_Label");
		Duration_Value[3] = getProperty("Field_TimeOfDay_Duration");
				
		T  = getProperty("DF_Title");
		V  = getProperty("App_Version");

		Args[0] = Label_Value;
		Args[1] = Duration_Value;
		Args[2] = T;
		Args[3] = V;
		
		//System.println(D_Time + " / " + D_Distance);

		//return [ new DF_RollingFieldView(Label_Value, Duration_Value, T, V) ];
		return [ new DF_RollingFieldView(Args) ];
		
		//return [ new DF_RollingFieldView(D_Time,L_Time,D_Timer,L_Timer,D_Distance,L_Distance,D_TimeOfDay,L_TimeOfDay,T,V) ];
        // return [ new DF_RollingFieldView(D_Time,L_Time,D_Timer,L_Timer,D_Distance,L_Distance,D_TimeOfDay,L_TimeOfDay,T,V) ];
    }

}