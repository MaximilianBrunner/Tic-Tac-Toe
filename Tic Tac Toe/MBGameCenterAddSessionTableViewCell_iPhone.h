//
//  MBGameCenterAddSessionTableViewCell_iPhone.h
//  Tic Tac Toe
//
//  Created by Maximilian Brunner on 30.07.13.
//  Copyright (c) 2013 Maximilian Brunner. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MBGameCenterAddSessionTableViewCellDelegate;

@interface MBGameCenterAddSessionTableViewCell_iPhone : UITableViewCell {
    id <MBGameCenterAddSessionTableViewCellDelegate> delegate;
}

@property (assign) id <MBGameCenterAddSessionTableViewCellDelegate> delegate;

- (IBAction)addSession:(UIButton *)sender;

@end


@protocol MBGameCenterAddSessionTableViewCellDelegate <NSObject>
@required
- (void)addGameCenterSession:(MBGameCenterAddSessionTableViewCell_iPhone *)sender;
@end
