using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;


public class KiipEventListener : MonoBehaviour
{
#if UNITY_IPHONE || UNITY_ANDROID

    // 0 is refered as default notification type
    // 1 is refered as custom notification type
    private int notificationType = 0;

    public void SetNotificationType(int value)
    {
        notificationType = value;
    }
    
    void OnEnable()
	{
		// Listen to all events for illustration purposes
		Kiip.sessionFailedToStartEvent += sessionFailedToStartEvent;
		Kiip.sessionStartedEvent += sessionStartedEvent;
		Kiip.onSaveMomentFailedEvent += onSaveMomentFailedEvent;
		Kiip.onSaveMomentFinishedEvent += onSaveMomentFinishedEvent;
		Kiip.onContentEvent += onContentEvent;
		Kiip.onShowNotificationEvent += onShowNotificationEvent;
		Kiip.onClickNotificationEvent += onClickNotificationEvent;
		Kiip.onDismissNotificationEvent += onDismissNotificationEvent;
		Kiip.onShowModalEvent += onShowModalEvent;
		Kiip.onDismissModalEvent += onDismissModalEvent;
		Kiip.onShowPoptartEvent += onShowPoptartEvent;
		Kiip.onDismissPoptartEvent += onDismissPoptartEvent;
		Kiip.onVideoShowEvent += onVideoShowEvent;
		Kiip.onVideoDismissEvent += onVideoDismissEvent;
	}


	void OnDisable()
	{
		// Remove all event handlers
		Kiip.sessionFailedToStartEvent -= sessionFailedToStartEvent;
		Kiip.sessionStartedEvent -= sessionStartedEvent;
		Kiip.onSaveMomentFailedEvent -= onSaveMomentFailedEvent;
		Kiip.onSaveMomentFinishedEvent -= onSaveMomentFinishedEvent;
		Kiip.onContentEvent -= onContentEvent;
		Kiip.onShowNotificationEvent -= onShowNotificationEvent;
		Kiip.onClickNotificationEvent -= onClickNotificationEvent;
		Kiip.onDismissNotificationEvent -= onDismissNotificationEvent;
		Kiip.onShowModalEvent -= onShowModalEvent;
		Kiip.onDismissModalEvent -= onDismissModalEvent;
		Kiip.onShowPoptartEvent -= onShowPoptartEvent;
		Kiip.onDismissPoptartEvent -= onDismissPoptartEvent;
		Kiip.onVideoShowEvent -= onVideoShowEvent;
		Kiip.onVideoDismissEvent -= onVideoDismissEvent;
	}



	void sessionFailedToStartEvent( string param )
	{
		Debug.Log( "sessionFailedToStartEvent: " + param );
	}


	void sessionStartedEvent()
	{
		Debug.Log( "sessionStartedEvent" );
	}


	void onSaveMomentFailedEvent( string param )
	{
		Debug.Log( "onSaveMomentFailedEvent: " + param );
	}


	void onSaveMomentFinishedEvent(bool flag)
	{
		if (flag) {

            if (notificationType == 0)
                Kiip.showPoptart(); // show kiip default notification
            else
                GameObject.Find("ui").SendMessage("ShowNotification"); //show custom notificatino
        }
		Debug.Log( "onSaveMomentFinishedEvent ---- " + flag);
	}


	void onContentEvent( Kiip.Content content )
	{
		Debug.Log( "onContentEvent: " + content );
	}

	void onShowNotificationEvent()
	{
		Debug.Log( "onShowNotificationEvent" );
	}


	void onClickNotificationEvent()
	{
		Debug.Log( "onClickNotificationEvent" );
	}


	void onDismissNotificationEvent()
	{
		Debug.Log( "onDismissNotificationEvent" );
	}


	void onShowModalEvent()
	{
		Debug.Log( "onShowModalEvent" );
	}


	void onDismissModalEvent()
	{
		Debug.Log( "onDismissModalEvent" );
	}
	
	
	void onShowPoptartEvent()
	{
		Debug.Log( "onShowPoptartEvent" );
	}
	
	
	void onDismissPoptartEvent()
	{
		Debug.Log( "onDismissPoptartEvent" );
	}

	void onVideoShowEvent()
	{
		Debug.Log( "onVideoShowEvent" );
	}

	void onVideoDismissEvent()
	{
		Debug.Log( "onVideoDismissEvent" );
	}
#endif
}


