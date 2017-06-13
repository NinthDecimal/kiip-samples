//
//  KiipBinding.m
//  Unity-iPhone
//
//  Created by Mike Desaro on 11/6/12.
//
//

#import "KiipManager.h"
#import "KiipSDK.h"


// Converts NSString to C style string by way of copy (Mono will free it)
#define MakeStringCopy( _x_ ) ( _x_ != NULL && [_x_ isKindOfClass:[NSString class]] ) ? strdup( [_x_ UTF8String] ) : NULL

// Converts C style string to NSString
#define GetStringParam( _x_ ) ( _x_ != NULL ) ? [NSString stringWithUTF8String:_x_] : [NSString stringWithUTF8String:""]

// Converts C style string to NSString as long as it isnt empty
#define GetStringParamOrNil( _x_ ) ( _x_ != NULL && strlen( _x_ ) ) ? [NSString stringWithUTF8String:_x_] : nil



void _kiipInit( const char * appKey, const char * appSecret )
{
	Kiip *kiip = [[Kiip alloc] initWithAppKey:GetStringParam( appKey ) andSecret:GetStringParam( appSecret )];
	kiip.delegate = [KiipManager sharedManager];
	[Kiip setSharedInstance:kiip];
}


void _kiipSaveMoment( const char * momentId, double val )
{
	[[KiipManager sharedManager] saveMoment:GetStringParam( momentId ) value:val];
}

void _kiipShowPoptart()
{
	[[KiipManager sharedManager] showRemotePoptart];
}

void _kiipSetShouldAutorotate( bool shouldAutorotate )
{
	[Kiip sharedInstance].shouldAutoRotate = shouldAutorotate;
}

void _kiipSetTestMode( bool testMode )
{
    [Kiip sharedInstance].testMode = testMode;
}


void _kiipSetInterfaceOrientation( int orientation )
{
	[Kiip sharedInstance].interfaceOrientation = (UIInterfaceOrientation)orientation;
}


void _kiipSetEmail( const char * email )
{
	[Kiip sharedInstance].email = GetStringParam( email );
}

void _kiipSetGender( const char * gender )
{
	[Kiip sharedInstance].gender = GetStringParam( gender );
}


void _kiipSetBirthday( int birthday )
{
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:birthday];
	[Kiip sharedInstance].birthday = date;
}
