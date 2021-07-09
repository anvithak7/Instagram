//
//  PostCell.h
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import <UIKit/UIKit.h>
#import "Post.h"
@import Parse;

NS_ASSUME_NONNULL_BEGIN

@class PostCell;

@protocol PostCellDelegate

- (void) profilePicTap:(PostCell*) postCell didTap:(PFUser*) postUser;

@end

@interface PostCell : UITableViewCell

@property (strong, nonatomic) Post *post;
@property (weak, nonatomic) IBOutlet UIImageView *userProfileView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *postCaptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UILabel *timeSincePostedLabel;
@property (weak, nonatomic) IBOutlet UIButton *segueToProfileButton;
@property (weak, nonatomic) id<PostCellDelegate> delegate;
@property (nonatomic, strong) PFUser *postUser;

@end

NS_ASSUME_NONNULL_END
