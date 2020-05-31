using UnityEngine;
using System.Collections.Generic;
using UnityEngine.UI;

public class KiipGUIManager : MonoBehaviour
{
    public InputField momentText, momentValue;
    public Button notification;

    void Start()
    {
        HideNotificaition();
    }

#if UNITY_ANDROID || UNITY_IPHONE
    void OnGUI()
	{
		float yPos = 5.0f;
		float xPos = 5.0f;
		float width = ( Screen.width >= 960 || Screen.height >= 960 ) ? 320 : 160;
		float height = ( Screen.width >= 960 || Screen.height >= 960 ) ? 80 : 40;
		float heightPlus = height + 10.0f;
	
	
		if( GUI.Button( new Rect( xPos, yPos, width, height ), "Save Moment with Default Notification" ) )
		{
            HideNotificaition(); // hide custom notification

            GameObject.Find("KiipEventListener").SendMessage("SetNotificationType", "default"); // set default notification

            if (momentText.text != "" && momentText != null)
                Kiip.saveMoment(momentText.text);
        }
	
		
		if( GUI.Button( new Rect( xPos, yPos += heightPlus, width, height ), "Save Another Moment with Custom Notification" ) )
		{
            HideNotificaition(); // hide custom notification

            GameObject.Find("KiipEventListener").SendMessage("SetNotificationType", "custom"); // set custom notification

            if (momentText.text != "" && momentText != null)
                Kiip.saveMoment(momentText.text);
        }
		
	
		if( GUI.Button( new Rect( xPos, yPos += heightPlus, width, height ), "Save Moment with Value with Custom Notification") )
		{
            HideNotificaition(); // hide custom notification

            GameObject.Find("KiipEventListener").SendMessage("SetNotificationType", "custom"); // set custom notification

            if (momentText.text != "" && momentText.text != null && momentValue.text != "" && momentValue != null)
                Kiip.saveMoment(momentText.text, double.Parse(momentValue.text));
        }
	
	
		if( GUI.Button( new Rect( xPos, yPos += heightPlus, width, height ), "Set Kiip Properties" ) )
		{
			Kiip.instance.gender = "Male";
			Kiip.instance.testMode = true;
			Kiip.instance.birthday = System.DateTime.Now;
			Kiip.instance.email = "someemail@email.net";
			
			// these next two are iOS only
			Kiip.instance.interfaceOrientation = DeviceOrientation.LandscapeLeft;
			Kiip.instance.shouldAutoRotate = true;
		}
        
    }

    public void ShowNotification()
    {
        if (notification != null)
            notification.gameObject.SetActive(true);
    }

    public void HideNotificaition()
    {
        if (notification != null)
            notification.gameObject.SetActive(false);
    }

    public void OnNotificationClick()
    {
        HideNotificaition();
        Kiip.showPoptart();
    }
#endif
}
