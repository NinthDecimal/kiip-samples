using UnityEngine;
using System.Collections;
using System;



public partial class Kiip : MonoBehaviour
{
	// class used to hold the details of a reward from the onContent callback
	public class Content
	{
		public string momentId;
		public int quantity;
		public string transactionId;
		public string signature;
		
		
		public static Content fromCommaDelimitedString( string commaString )
		{
			var c = new Content();
			
			var parts = commaString.Split( new string[] { "," }, StringSplitOptions.None );
			if( parts.Length == 4 )
			{
				c.momentId = parts[0];
				c.quantity = int.Parse( parts[1] );
				c.transactionId = parts[2];
				c.signature = parts[3];
			}
			
			return c;
		}
		
		
		public override string ToString()
		{
			return string.Format( "[Content] momentId: {0}, quantity: {1}, transactionId: {2}, signature: {3}", momentId, quantity, transactionId, signature );
		}
		
	}
	
	
	// Fired when the session fails to start
	public static event Action<string> sessionFailedToStartEvent;

	// Fired when a session starts
	public static event Action sessionStartedEvent;

	// Fired when a moment fails to save
	public static event Action<string> onSaveMomentFailedEvent;

	// Fired when a moment is successfully saved
	public static event Action<bool> onSaveMomentFinishedEvent;

	// Fired when a Content object is received
	public static event Action<Content> onContentEvent;

	// Fired when a notification is shown
	public static event Action onShowNotificationEvent;

	// Fired when a notification is clicked
	public static event Action onClickNotificationEvent;

	// Fired when a notification is dismissed
	public static event Action onDismissNotificationEvent;

	// Fired when a modal is shown
	public static event Action onShowModalEvent;

	// Fired when a modal is dismissed
	public static event Action onDismissModalEvent;
	
	// Fired when a poptart is shown
	public static event Action onShowPoptartEvent;
	
	// Fired when a poptart is dismissed
	public static event Action onDismissPoptartEvent;

	// Fired when a video is shown
	public static event Action onVideoShowEvent;

	// Fired when a video is dismissed
	public static event Action onVideoDismissEvent;
	
	
	
	public void sessionFailedToStart( string param )
	{
		if( sessionFailedToStartEvent != null )
		{
			if ( string.IsNullOrEmpty( param ) ) { param = "Kiip Error"; }
			sessionFailedToStartEvent( param );
		}
	}


	public void sessionStarted( string empty )
	{
		if( sessionStartedEvent != null )
			sessionStartedEvent();
	}


	public void onSaveMomentFailed( string param )
	{
		if( onSaveMomentFailedEvent != null )
		{
			if ( string.IsNullOrEmpty( param ) ){ param = "Kiip Error"; }
			onSaveMomentFailedEvent( param );
		}
	}


	public void onSaveMomentFinished( string param )
	{
		if( onSaveMomentFinishedEvent != null ) 
		{
			if ( string.IsNullOrEmpty( param ) ){ param = "false"; }
			if ( param == "true") {
				onSaveMomentFinishedEvent(true);
			} else {
				onSaveMomentFinishedEvent(false);
			}
		}
	}


	public void onContent( string commaDelimitedString )
	{
		if( onContentEvent != null )
			onContentEvent( Content.fromCommaDelimitedString( commaDelimitedString ) );
	}
	
	public void onShowNotification( string empty )
	{
		if( onShowNotificationEvent != null )
			onShowNotificationEvent();
	}


	public void onClickNotification( string empty )
	{
		if( onClickNotificationEvent != null )
			onClickNotificationEvent();
	}


	public void onDismissNotification( string empty )
	{
		if( onDismissNotificationEvent != null )
			onDismissNotificationEvent();
	}


	public void onShowModal( string empty )
	{
		if( onShowModalEvent != null )
			onShowModalEvent();
	}


	public void onDismissModal( string empty )
	{
		if( onDismissModalEvent != null )
			onDismissModalEvent();
	}
	
	
	public void onShowPoptart( string empty )
	{
		if( onShowPoptartEvent != null )
			onShowPoptartEvent();
	}
	
	
	public void onDismissPoptart( string empty )
	{
		if( onDismissPoptartEvent != null )
			onDismissPoptartEvent();
	}

	public void onVideoShow( string empty )
	{
		if( onVideoShowEvent != null )
			onVideoShowEvent();
	}

	public void onVideoDismiss( string empty )
	{
		if( onVideoDismissEvent != null )
			onVideoDismissEvent();
	}
}
