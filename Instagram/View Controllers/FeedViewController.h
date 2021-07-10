//
//  FeedViewController.h
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/7/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface FeedViewController : UIViewController
@property (strong, nonatomic) PFUser* user;

@end

NS_ASSUME_NONNULL_END
