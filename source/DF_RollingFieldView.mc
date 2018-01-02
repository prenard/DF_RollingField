using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;

class DF_RollingFieldView extends Ui.DataField
{
	var Device_Type;

    var Loop_Index;
    var Loop_Size;
	var Loop_Value = new [40];

    var Time_Value = 0;
    var Timer_Value = 0;
    var Distance_Value = 0;
    var TimeOfDay_Value = "";
    var TimeOfDay_Meridiem_Value = "";

	var CustomFont_Value = null;

    var Label_Field = null;
	var Label_Field_Font = Gfx.FONT_TINY;
	var Label_Field_x = 0;
	var Label_Field_y = 0;
		
    var Value_Field = null;
	var Value_Field_Font = Gfx.FONT_LARGE;
	var Value_Field_x = 0;
	var Value_Field_y = 0;

    var Unit_Field = null;
	var Unit_Field_Font = Gfx.FONT_XTINY;
	var Unit_Field_x = 0;
	var Unit_Field_y = 0;
		    
	var CustomFont_Value_00 = null;    
	var CustomFont_Value_01 = null;
	var CustomFont_Value_02 = null;
	var CustomFont_Value_03 = null;
	var CustomFont_Value_04 = null;
	var CustomFont_Value_05 = null;
	var CustomFont_Value_06 = null;
	var CustomFont_Value_07 = null;
	var CustomFont_Value_08 = null;
	var CustomFont_Value_09 = null;
	var CustomFont_Value_10 = null;
	
	var Font = new [11];

    function initialize(Args)
    {
		System.println("View - Initialize / Start - Used Memory = " + System.getSystemStats().usedMemory);
        DataField.initialize();

	    Device_Type = Ui.loadResource(Rez.Strings.Device);

		var Label_Value = Args[0];
		var Duration_Value = Args[1];

		Loop_Index = 0;
		Loop_Size = 0;

		//System.println(Label_Value.size());

		for (var i = 0; i < Label_Value.size() ; ++i)
       	{
			//System.println(Label_Value[i]);
       	   	if (Label_Value[i] != null)
       	   	{
				Initialize_Loop_Value(Label_Value[i],Duration_Value[i]);
       	   		Loop_Size += Duration_Value[i];
       	   	}
		}

		Loop_Index = 0;

		// Load Custom Fonts

		System.println("View - onLayout / Load F00 - Used Memory = " + System.getSystemStats().usedMemory);
     	CustomFont_Value_00 = Ui.loadResource(Rez.Fonts.Font_Value_00);
		System.println("View - onLayout / Load F00 - Used Memory = " + System.getSystemStats().usedMemory);
	   	CustomFont_Value_01 = Ui.loadResource(Rez.Fonts.Font_Value_01);
		System.println("View - onLayout / Load F00 - Used Memory = " + System.getSystemStats().usedMemory);
		CustomFont_Value_02 = Ui.loadResource(Rez.Fonts.Font_Value_02);
		CustomFont_Value_03 = Ui.loadResource(Rez.Fonts.Font_Value_03);
		CustomFont_Value_04 = Ui.loadResource(Rez.Fonts.Font_Value_04);
		CustomFont_Value_05 = Ui.loadResource(Rez.Fonts.Font_Value_05);
		CustomFont_Value_06 = Ui.loadResource(Rez.Fonts.Font_Value_06);
		CustomFont_Value_07 = Ui.loadResource(Rez.Fonts.Font_Value_07);
		CustomFont_Value_08 = Ui.loadResource(Rez.Fonts.Font_Value_08);
		CustomFont_Value_09 = Ui.loadResource(Rez.Fonts.Font_Value_09);
		CustomFont_Value_10 = Ui.loadResource(Rez.Fonts.Font_Value_10);
		System.println("View - onLayout / Load F09 - Used Memory = " + System.getSystemStats().usedMemory);
		
		Font[0] = CustomFont_Value_00;
		Font[1] = CustomFont_Value_01;
		Font[2] = CustomFont_Value_02;
		Font[3] = CustomFont_Value_03;
		Font[4] = CustomFont_Value_04;
		Font[5] = CustomFont_Value_05;
		Font[6] = CustomFont_Value_06;
		Font[7] = CustomFont_Value_07;
		Font[8] = CustomFont_Value_08;
		Font[9] = CustomFont_Value_09;
		Font[10] = CustomFont_Value_10;
		
		System.println("View - Initialize / End - Used Memory = " + System.getSystemStats().usedMemory);
    }

    function Initialize_Loop_Value(Value,Duration)
    {
		for (var i = 0; i < Duration; ++i)
       	{
       	   Loop_Value[Loop_Index] = Value;
       	   Loop_Index++;
		}
        return true;
	}

    function onLayout(dc)
    {
		System.println("View - onLayout / Start - Used Memory = " + System.getSystemStats().usedMemory);

    	System.println("DC Height  = " + dc.getHeight());
      	System.println("DC Width  = " + dc.getWidth());

    	//! The given info object contains all the current workout
    	//! information. Calculate a value and return it in this method.
	   	View.setLayout(Rez.Layouts.MainLayout(dc));

		
		// Get Fields

       	Label_Field = View.findDrawableById("Label");
       	Value_Field = View.findDrawableById("Value");
       	Unit_Field = View.findDrawableById("Unit");

		// Manage Label Field

		Label_Field_x = dc.getWidth() /2;
		Label_Field_y = 1;
      	Label_Field.setFont(Label_Field_Font);
       	Label_Field.setJustification(Gfx.TEXT_JUSTIFY_CENTER);
       	Label_Field.setLocation(Label_Field_x,Label_Field_y);

		//System.println("Label Field - Font Height = " + Gfx.getFontHeight(Label_Field_Font));

		// Manage Value Field

		//
		// Set Font Size for Field value
		//
		//		- Large except Timer = Medium
		//

	   	// Edge 1000 -> problem with custom font rotation !!!

       	//if (Device_Type.equals("edge_520") or Device_Type.equals("edge_820") or Device_Type.equals("edge_1030"))
		if (Device_Type.equals("edge_1000") == false)
       	{
			Value_Field_Font = CustomFont_Value_00;
       	}

    }
    
    
    function compute(info)
    {
        // See Activity.Info in the documentation for available information.

		if( info.elapsedTime != null )
            {
                Time_Value = TimeFormat(info.elapsedTime);
            }
		
		if( info.timerTime != null )
            {
                Timer_Value = TimeFormat(info.timerTime);
            }

		if( info.elapsedDistance != null )
    	    {
        	    Distance_Value = (info.elapsedDistance / 1000);
            }

		/* Time Of Day value */
		
		var time = Time.now().value() + System.getClockTime().timeZoneOffset;
    	var hour = (time / 3600) % 24;
		var min = (time / 60) % 60;
		var sec = time % 60;
		
		// Process 12/24 hr differences
		var meridiemTxt = "";

		if (System.getDeviceSettings().is24Hour)
		 {
			if(0 == time)
			 {
				hour = 24;
			 }
			else 
			 {
				hour = hour % 24;
			 }
		 }
		else
		 {
			if(12 > hour)
			 {
				meridiemTxt = "AM";
			 }
			else
			 {
				meridiemTxt = "PM";
			 }
			hour = 1 + (hour + 11) % 12;
		 }

		// Format time
    	var timeStr = format("$1$:$2$", [hour.format("%01d"), min.format("%02d")]);
		
		
		TimeOfDay_Value = timeStr;
		TimeOfDay_Meridiem_Value = meridiemTxt;
		
        return true;
    }

    function TimeFormat(milliseconds)
    {
      //elapsedTime is in ms.
      var Seconds = milliseconds / 1000;
      var Rest;
               
      var Hour   = (Seconds - Seconds % 3600) / 3600; 
      Rest = Seconds - Hour * 3600;
      var Minute = (Rest - Rest % 60) / 60;
      var Second = Rest - Minute * 60; 

      var Return_Value = Hour.format("%d") + ":" + Minute.format("%02d") + ":" + Second.format("%02d");
      return Return_Value;
    }

    function onUpdate(dc)
    {
		System.println("View - onUpdate / Start - Used Memory = " + System.getSystemStats().usedMemory);
		
        // Set the background color
        View.findDrawableById("Background").setColor(getBackgroundColor());

        var Label = View.findDrawableById("Label");
        //var Value = View.findDrawableById("Value");
        var Unit = View.findDrawableById("Unit");

        if (getBackgroundColor() == Gfx.COLOR_BLACK)
        {
            Label.setColor(Gfx.COLOR_WHITE);
            Value_Field.setColor(Gfx.COLOR_WHITE);
            Unit.setColor(Gfx.COLOR_WHITE);
        }
        else
        {
            Label.setColor(Gfx.COLOR_BLACK);
            Value_Field.setColor(Gfx.COLOR_BLACK);
            Unit.setColor(Gfx.COLOR_BLACK);
        }


  	    Loop_Index = (Loop_Index + 1) % Loop_Size;
  	   
  	    var Field = Loop_Value[Loop_Index];
  	    var Value_Picked = "";
  	    var Value_Unit_Picked = "";
  	      	    
   	    Label.setText(Field);

		if (Field.equals(Ui.loadResource(Rez.Strings.Field_Time_Label_Title)))
		//if (Field.equals("Time"))
		{
            Value_Picked = Time_Value.toString();
			Value_Unit_Picked = "";
		}

		if (Field.equals(Ui.loadResource(Rez.Strings.Field_Timer_Label_Title)))
		//if (Field.equals("Timer"))
		{
            Value_Picked = Timer_Value.toString();
			Value_Unit_Picked = "";
		}
		
		if (Field.equals(Ui.loadResource(Rez.Strings.Field_Distance_Label_Title)))
		//if (Field.equals("Distance")) 
		{

			if (System.getDeviceSettings().distanceUnits == System.UNIT_METRIC)
			  {
				Value_Unit_Picked = "km";
			  }
			 else
			 {
				var km_mi_conv = 0.621371;
				Value_Unit_Picked = "mi";
				Distance_Value = Distance_Value * km_mi_conv;
			 }
			//System.println(Distance_Value);
            Value_Picked = Distance_Value.format("%.1f").toString();
		}

		if (Field.equals(Ui.loadResource(Rez.Strings.Field_TimeOfDay_Label_Title)))
		//if (Field.equals("Time of Day")) 
		{
            Value_Picked = TimeOfDay_Value.toString();
            Value_Unit_Picked = TimeOfDay_Meridiem_Value.toString();
		}

		//System.println(Field);
		//System.println(Value_Picked);

		// Edge 1000 -> problem with custom font rotation !!!

        //if (Device_Type.equals("edge_520") or Device_Type.equals("edge_820"))

   		Value_Field.setFont(Value_Field_Font);


		if (Device_Type.equals("edge_1000"))
        {
			Value_Field_Font = Gfx.FONT_LARGE;
        }
        else
        {

			var Value_Pattern = Value_Picked;

// Start - Test with Pattern
/*
	    	System.println("DC Height  = " + dc.getHeight());
    	  	System.println("DC Width  = " + dc.getWidth());
			
			if (Field.equals(Ui.loadResource(Rez.Strings.Field_Time_Label_Title)))
			{
				Value_Pattern = "88:88:88";
			}
			else
			if (Field.equals(Ui.loadResource(Rez.Strings.Field_Timer_Label_Title)))
			{
				Value_Pattern = "88:88:88";
			}
			else
			if (Field.equals(Ui.loadResource(Rez.Strings.Field_Distance_Label_Title)))
			{
				Value_Pattern = "888.8";
			}
			if (Field.equals(Ui.loadResource(Rez.Strings.Field_TimeOfDay_Label_Title)))
			{
				Value_Pattern = "88:88";
			}
*/
// End - Test with Pattern

       		Value_Field.setText(Value_Pattern);
      
       		for (var i = Font.size() - 1; i >= 0 ; --i)
       		{
				System.println("i = " + i);
       			Value_Field_Font = Font[i];
				System.println(Field + " - Font Height = " + Gfx.getFontHeight(Value_Field_Font));
				System.println(Field + " - Font Max Height = " + (dc.getHeight() - Gfx.getFontHeight(Label_Field_Font) - 5));
				System.println(Field + " - Field Width in Pixels = " + dc.getTextWidthInPixels(Value_Pattern, Value_Field_Font));
				System.println(Field + " - Field Max Width in Pixels = " + (dc.getWidth() - 2 * dc.getTextWidthInPixels(Value_Unit_Picked, Unit_Field_Font) - 6));

				if (
					(Gfx.getFontHeight(Value_Field_Font) <= dc.getHeight() - Gfx.getFontHeight(Label_Field_Font) - 5)
					&
					(dc.getTextWidthInPixels(Value_Pattern, Value_Field_Font) <= dc.getWidth() - 2 * dc.getTextWidthInPixels(Value_Unit_Picked, Unit_Field_Font) - 6)
				   )
				{
					System.println(Field + " Font = " + i);
					break;
				}
       		}

        }


		Value_Field_x = dc.getWidth() / 2;
		Value_Field_y = Gfx.getFontHeight(Label_Field_Font) + (dc.getHeight() - Gfx.getFontHeight(Label_Field_Font)) / 2 - Gfx.getFontHeight(Value_Field_Font) /2;

		System.println("Value Field x = " + Value_Field_x);
		System.println("Value Field y = " + Value_Field_y);
			
		Value_Field.setJustification(Gfx.TEXT_JUSTIFY_CENTER);
		Value_Field.setLocation(Value_Field_x,Value_Field_y);

        Value_Field.setFont(Value_Field_Font);

        Value_Field.setText(Value_Picked);

		System.println(Field + " - Value Field - Width in Pixels = " + dc.getTextWidthInPixels(Value_Picked, Value_Field_Font));
		System.println(Field + " - Value Field - Font Height = " + Gfx.getFontHeight(Value_Field_Font));

		Unit_Field_x = Value_Field_x + dc.getTextWidthInPixels(Value_Picked, Value_Field_Font) / 2 + 2;
		Unit_Field_y = Value_Field_y; // + Gfx.getFontHeight(Value_Field_Font) / 1;

		System.println("Unit Field x = " + Unit_Field_x);
		System.println("Unit Field y = " + Unit_Field_y);

		//System.println("Unit Field - Font Height = " + Gfx.getFontHeight(Unit_Field_Font));
       	Unit_Field.setFont(Unit_Field_Font);
       	Unit_Field.setJustification(Gfx.TEXT_JUSTIFY_LEFT);
       	Unit_Field.setLocation(Unit_Field_x,Unit_Field_y);

        Unit.setText(Value_Unit_Picked);

		
        // Call parent's onUpdate(dc) to redraw the layout
        View.onUpdate(dc);
	}
}