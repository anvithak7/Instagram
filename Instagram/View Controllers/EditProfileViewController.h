//
//  EditProfileViewController.h
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/9/21.
//

#import <UIKit/UIKit.h>
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface EditProfileViewController : UIViewController
@property (strong, nonatomic) PFUser *user;
@end

NS_ASSUME_NONNULL_END
