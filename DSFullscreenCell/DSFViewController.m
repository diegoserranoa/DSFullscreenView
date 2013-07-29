//
//  DSFViewController.m
//  DSFullscreenCell
//
//  Created by Diego Serrano on 7/29/13.
//  Copyright (c) 2013 Brounie. All rights reserved.
//

#import "DSFViewController.h"
#import "DSFullscreenView.h"
#import "DSFTableCell.h"

@interface DSFViewController (){
    DSFullscreenView *fullscreenView;
}

@end

@implementation DSFViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(fullscreenViewDismissed:)
                                                 name:@"fullscreenViewDismissed"
                                               object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    DSFTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Background %i.png", indexPath.row + 1]];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"Background %i", indexPath.row + 1];
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Navigation

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Disable scroll on tableview
    self.tableView.scrollEnabled = NO;
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    fullscreenView = [self.storyboard instantiateViewControllerWithIdentifier:@"FullscreenView"];
    [fullscreenView.view setFrame:cell.frame];
    
    fullscreenView.backgroundImage.image = [UIImage imageNamed:[NSString stringWithFormat:@"Background %i.png", indexPath.row + 1]];
    fullscreenView.previousViewOriginX = cell.frame.origin.x;
    fullscreenView.previousViewOriginY = cell.frame.origin.y;
    fullscreenView.previousViewSizeWidth = cell.frame.size.width;
    fullscreenView.previousViewSizeHeight = cell.frame.size.height;
    fullscreenView.label.text = @"Fullscreen View";
    
    fullscreenView.mainView.layer.opacity = 0.0f;
    
    [self.view addSubview:fullscreenView.view];
    
    [UIView animateWithDuration:1.0f animations:^{
        CGRect theFrame = fullscreenView.view.frame;
        theFrame.size.height = self.view.frame.size.height;
        theFrame.origin.y = self.tableView.contentOffset.y;
        fullscreenView.view.frame = theFrame;
    } completion:^(BOOL finished) {
        if (finished) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"animationFinished" object:self];
        }
    }];
}

/*

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

- (void) fullscreenViewDismissed:(NSNotification *)notification
{
    if ([[notification name] isEqualToString:@"fullscreenViewDismissed"]){
        NSLog(@"Fullscreen View dismissed. Remove subview. Enable scroll on tableview.");
        [fullscreenView.view removeFromSuperview];
        self.tableView.scrollEnabled = YES;
    }
}

@end
