//
//  KiipManager.m
//  Unity-iPhone
//
//  Created by Mike Desaro on 11/6/12.
//
//

#import "KiipManager.h"


void UnitySendMessage( const char * className, const char * methodName, const char * param );
void UnityPause( int pause );
UIViewController *UnityGetGLViewController();

@interface KiipManager ()

@property (strong, nonatomic) KPPoptart *localPoptart;

@end

@implementation KiipManager

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark NSObject

+ (KiipManager*)sharedManager
{
	static dispatch_once_t pred;
	static KiipManager *_sharedInstance = nil;

	dispatch_once( &pred, ^{ _sharedInstance = [[self alloc] init]; } );
	return _sharedInstance;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Private

- (void)showPoptart:(KPPoptart*)poptart
{
	if( !poptart )
	{
		NSLog( @"no poptart to show" );
		return;
	}

	poptart.delegate = self;

	if( poptart.notification )
	{
		poptart.notification.delegate = self;
	}

	if( poptart.modal )
	{
		poptart.modal.delegate = self;
	}

	[poptart show];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

- (void) showRemotePoptart
{
	if (self.localPoptart) {
		[self showPoptart:self.localPoptart];
		self.localPoptart = nil;
	}
}

- (void)saveMoment:(NSString*)momentId value:(double)value
{
	if( value > 0 )
	{
		[[Kiip sharedInstance] saveMoment:momentId value:value withCompletionHandler:^( KPPoptart *poptart, NSError *error )
		{
			if( error )
			{
				UnitySendMessage( "Kiip", "onSaveMomentFailed", [error localizedDescription].UTF8String );
			}
			else
			{
                self.localPoptart = nil;
				if (poptart) {
                    self.localPoptart = poptart;
					UnitySendMessage( "Kiip", "onSaveMomentFinished", "true" );
				} else {
					UnitySendMessage( "Kiip", "onSaveMomentFinished", "false" );
				}
			}
		}];
	}
	else
	{
		[[Kiip sharedInstance] saveMoment:momentId withCompletionHandler:^( KPPoptart *poptart, NSError *error )
		{
			if( error )
			{
				UnitySendMessage( "Kiip", "onSaveMomentFailed", [error localizedDescription].UTF8String );
			}
			else
			{
                self.localPoptart = nil;
				if (poptart) {
                    self.localPoptart = poptart;
					UnitySendMessage( "Kiip", "onSaveMomentFinished", "true" );
				} else {
					UnitySendMessage( "Kiip", "onSaveMomentFinished", "false" );
				}
			}
		}];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - KiipDelegate

- (void)kiip:(Kiip*)kiip didStartSessionWithPoptart:(KPPoptart*)poptart error:(NSError*)error
{
	if( error )
	{
		UnitySendMessage( "Kiip", "sessionFailedToStart", [error localizedDescription].UTF8String );
	}
	else
	{
		UnitySendMessage( "Kiip", "sessionStarted", "" );
		[self showPoptart:poptart];
	}
}


- (void)kiip:(Kiip*)kiip didEndSessionWithError:(NSError*)error
{
	NSLog( @"session ended with error: %@", error );
}


- (void)kiip:(Kiip*)kiip didStartSwarm:(NSString*)momentId
{
	UnitySendMessage( "Kiip", "onSwarm", momentId.UTF8String );
}


- (void)kiip:(Kiip*)kiip didReceiveContent:(NSString*)content quantity:(int)quantity transactionId:(NSString*)transactionId signature:(NSString*)signature
{
	NSString *str = [NSString stringWithFormat:@"%@,%i,%@,%@", content, quantity, transactionId, signature];
	UnitySendMessage( "Kiip", "onContent", str.UTF8String );
}

- (void)kiipVideoPlaybackDidBegin:(Kiip *)kiip
{
    UnitySendMessage( "Kiip", "onVideoShow", "");
}

- (void)kiipVideoPlaybackDidEnd:(Kiip *)kiip
{
    UnitySendMessage( "Kiip", "onVideoDismiss", "");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - KiipModalDelegate

- (void)willPresentModal:(KPModal*)modal
{
	UnitySendMessage( "Kiip", "onShowModal", "" );
}


- (void)didDismissModal:(KPModal*)modal;
{
	UnitySendMessage( "Kiip", "onDismissModal", "" );
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - KiipNotificationDelegate

- (void)willPresentNotification:(KPNotification*)notification
{
	UnitySendMessage( "Kiip", "onShowNotification", "" );
}


- (void)didDismissNotification:(KPNotification*)notification
{
	UnitySendMessage( "Kiip", "onDismissNotification", "" );
}


- (void)didDismissNotificationWithClick:(KPNotification*)notification
{
	UnitySendMessage( "Kiip", "onClickNotification", "" );
}


///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - KiipPoptartDelegate

- (void)willPresentPoptart:(KPPoptart*)poptart
{
	UnitySendMessage( "Kiip", "onShowPoptart", "" );
}


- (void)didDismissPoptart:(KPPoptart*)poptart
{
	UnitySendMessage( "Kiip", "onDismissPoptart", "" );
}

@end
