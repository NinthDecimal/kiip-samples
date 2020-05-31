using UnityEngine;
using System;
using System.Collections;
using System.Collections.Generic;


#if UNITY_ANDROID
using KiipShim = Kiip.KiipAndroid;
#elif UNITY_IPHONE
using KiipShim = Kiip.KiipiOS;
#endif


public partial class Kiip : MonoBehaviour
{
	public string iOSappKey;
	public string iOSappSecret;
	public string androidAppKey;
	public string androidAppSecret;
	
	private static Kiip _instance = null;
	public static Kiip instance { get { return _instance; } }
	
	
#if UNITY_ANDROID || UNITY_IPHONE
	
	#region Kiip property setters
	
	public bool shouldAutoRotate
	{
		set
		{
			if( _instance != null )
				KiipShim.setShouldAutorotate( value );
		}
	}
	
	public DeviceOrientation interfaceOrientation
	{
		set
		{
			if( _instance != null )
				KiipShim.setInterfaceOrientation( value );
		}
	}
	
	public string email
	{
		set
		{
			if( _instance != null )
				KiipShim.setEmail( value );
		}
	}

	public string userId 
	{
		set 
		{
			if( _instance != null )
				KiipShim.setUserId( value );
		}
	}

	public string gender
	{
		set
		{
			if( _instance != null )
				KiipShim.setGender( value );
		}
	}
	
	public DateTime birthday
	{
		set
		{
			// convert to epoch time
			var t = ( value - new DateTime( 1970, 1, 1 ) );
     		var timestamp  = (int)t.TotalSeconds;
			
			if( _instance != null )
				KiipShim.setBirthday( timestamp );
		}
	}

	public bool testMode 
	{
		set 
		{
			if( _instance != null )
				KiipShim.setTestMode( value );
		}
	}

	#endregion
	
	
	#region Monobehaviour
	
	void Awake()
	{
		// collect our key and secret
		string appKey = string.Empty;
		string appSecret = string.Empty;
		
#if UNITY_ANDROID
		appKey = androidAppKey;
		appSecret = androidAppSecret;
#elif UNITY_IPHONE
		appKey = iOSappKey;
		appSecret = iOSappSecret;
#endif
		
		if( appKey.Length == 0 || appSecret.Length == 0 )
		{
			Debug.LogError( "Enter your appKey and appSecret in the Kiip inspector for any platforms you support!" );
			Destroy( gameObject );
			return;
		}
		
		// enforce one Kiip object
		var kiipObjects = FindObjectsOfType( typeof( Kiip ) );
		if( kiipObjects.Length > 1 )
		{
			Destroy( gameObject );
			return;
		}
		
		_instance = this;
		DontDestroyOnLoad( gameObject );
		name = "Kiip";
		
		// start up the SDK
		KiipShim.init( appKey, appSecret );
	}
	
	
	void OnApplicationPause( bool didPause )
	{
		if( didPause )
		{
			if( _instance != null )
				KiipShim.endSession();
		}
		else
		{
			if( _instance != null )
				KiipShim.startSession();
		}
	}
	
	#endregion
	
	
	#region Public

	public static void saveMoment( string momentId )
	{
		if( _instance != null )
			saveMoment( momentId, double.MinValue );
	}
		
	
	public static void saveMoment( string momentId, double val )
	{
		if( _instance != null )
			KiipShim.saveMoment( momentId, val );
	}

	public static void showPoptart()
	{
		if( _instance != null )
			KiipShim.showPoptart();
	}

	#endregion

#endif

}