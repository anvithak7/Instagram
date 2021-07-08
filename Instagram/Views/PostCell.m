//
//  PostCell.m
//  Instagram
//
//  Created by Anvitha Kachinthaya on 7/8/21.
//

#import "PostCell.h"
#import "UIImageView+AFNetworking.h"
#import "Post.h"
#import <DateTools/DateTools.h>


@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setPost:(Post *)post {
    PFUser *user = post[@"author"];
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject * _Nullable object, NSError * _Nullable error) {
        if (error) {
            
        } else {
            self.usernameLabel.text = user[@"username"];
        }
    }];
    self.postCaptionLabel.text = post[@"caption"];
    NSDate *createdDate = post.createdAt;
    //NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    //formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    //NSDate *date = [formatter dateFromString:createdAtOriginalString];
    // Configure output format
    //formatter.dateStyle = NSDateFormatterShortStyle;
    //formatter.timeStyle = NSDateFormatterShortStyle;
    // Convert Date to String
    self.timeSincePostedLabel.text = createdDate.timeAgoSinceNow;
    self.postImageView.file = post[@"image"];
    [self.postImageView loadInBackground];
}

@end
