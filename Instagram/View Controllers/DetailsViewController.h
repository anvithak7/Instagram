//
//  DetailsViewController.h
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController
@property (strong, nonatomic) Post* post;

@end

NS_ASSUME_NONNULL_END
