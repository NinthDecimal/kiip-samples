using UnityEngine;
using System;
using System.Runtime.InteropServices;
using System.Collections;
using System.Collections.Generic;



public partial class Kiip : MonoBehaviour
{

	#region Internal Android shim
#if UNITY_ANDROID
	
	internal class KiipAndroid
	{
		private static AndroidJavaObject _plugin;
		
		
		static KiipAndroid()
		{
			if( Application.platform == RuntimePlatform.Android )
			{
				// find the plugin instance and store it
				using( var pluginClass = new AndroidJavaClass( "com.kiip.KiipPlugin" ) )
					_plugin = pluginClass.CallStatic<AndroidJavaObject>( "instance" );
			}
		}
		
		
		#region Properties
		
		public static void setShouldAutorotate( bool shouldAutorotate )
		{
		}
		
		
		public static void setInterfaceOrientation( DeviceOrientation orientation )
		{
		}
		
		
		public static void setEmail( string email )
		{
			if( Application.platform != RuntimePlatform.Android )
				return;
			
			_plugin.Call( "setEmail", email );
		}
		
		public static void setGender( string gender )
		{
			if( Application.platform != RuntimePlatform.Android )
				return;
			
			_plugin.Call( "setGender", gender );
		}
		
		
		public static void setBirthday( int birthday )
		{
			if( Application.platform != RuntimePlatform.Android )
				return;
			
			_plugin.Call( "setBirthday", birthday );
		}

		public static void setTestMode( bool testMode )
		{
			if( Application.platform != RuntimePlatform.Android )
				return;
			
			_plugin.Call( "setTestMode", testMode );
		}

		public static void setUserId( string userId )
		{
			if( Application.platform != RuntimePlatform.Android )
				return;

			_plugin.Call( "setUserId", userId );
		}

		#endregion
		
		
		public static void init( string appKey, string appSecret )
		{
			if( Application.platform != RuntimePlatform.Android )
				return;
			
			_plugin.Call( "init", appKey, appSecret );
		}
		
		
		public static void startSession()
		{
			if( Application.platform != RuntimePlatform.Android )
				return;
			
			_plugin.Call( "startSession" );
		}
		
		
		public static void endSession()
		{
			if( Application.platform != RuntimePlatform.Android )
				return;

			_plugin.Call( "endSession" );
		}

		
		public static void saveMoment( string momentId, double val )
		{
			if( Application.platform != RuntimePlatform.Android )
				return;
			
			_plugin.Call( "saveMoment", momentId, val );
		}

		public static void showPoptart() 
		{
			if( Application.platform != RuntimePlatform.Android )
				return;

			_plugin.Call ( "showPoptart" );
		}
		
	}
	
#endif
	#endregion
	
	
	#region Internal iOS shim
#if UNITY_IPHONE
	
	internal class KiipiOS
	{
		#region Properties

		[DllImport("__Internal")]
		private static extern void _kiipSetShouldAutorotate( bool shouldAutorotate );

		public static void setShouldAutorotate( bool shouldAutorotate )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipSetShouldAutorotate( shouldAutorotate );
		}


		[DllImport("__Internal")]
		private static extern void _kiipSetTestMode( bool testMode );
		
		public static void setTestMode( bool testMode )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipSetTestMode( testMode );
		}

		public static void setUserId( string userId )
		{
			if (Application.platform == RuntimePlatform.IPhonePlayer)
				Debug.Log ("'setUserId' Yet to implement for iOS");
				return;
		}


		[DllImport("__Internal")]
		private static extern void _kiipSetInterfaceOrientation( int orientation );

		public static void setInterfaceOrientation( DeviceOrientation orientation )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
			{
				// only allow valid orientations
				if( orientation == DeviceOrientation.Unknown || orientation == DeviceOrientation.FaceUp || orientation == DeviceOrientation.FaceDown )
				{
					Debug.LogError( "Invalid orientation specified: " + orientation );
				}
				else
				{
					_kiipSetInterfaceOrientation( (int)orientation );
				}
			}
		}


		[DllImport("__Internal")]
		private static extern void _kiipSetEmail( string email );

		public static void setEmail( string email )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipSetEmail( email );
		}

		[DllImport("__Internal")]
		private static extern void _kiipSetGender( string gender );

		public static void setGender( string gender )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipSetGender( gender );
		}


		[DllImport("__Internal")]
		private static extern void _kiipSetBirthday( int birthday );

		public static void setBirthday( int birthday )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipSetBirthday( birthday );
		}
		
		#endregion
		
		[DllImport("__Internal")]
		private static extern void _kiipInit( string appKey, string appSecret );

		public static void init( string appKey, string appSecret )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipInit( appKey, appSecret );
		}


		[DllImport("__Internal")]
		private static extern void _kiipSaveMoment( string momentId, double val );

		public static void saveMoment( string momentId, double val )
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipSaveMoment( momentId, val );
		}
		
		[DllImport("__Internal")]
		private static extern void _kiipShowPoptart();

		public static void showPoptart()
		{
			if( Application.platform == RuntimePlatform.IPhonePlayer )
				_kiipShowPoptart();
		}

		public static void startSession()
		{}
		
		
		public static void endSession()
		{}


	}
	
#endif
	#endregion

}
