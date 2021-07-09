//
//  PostUserViewController.h
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/9/21.
//

#import <UIKit/UIKit.h>
#import "Parse/Parse.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostUserViewController : UIViewController
@property (strong, nonatomic) PFUser *user;
@end

NS_ASSUME_NONNULL_END
