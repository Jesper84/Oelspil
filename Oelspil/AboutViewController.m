//
//  AboutViewController.m
//  Oelspil
//
//  Created by Jesper Nielsen on 26/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AboutViewController.h"

@implementation AboutViewController
@synthesize contentTableView;
@synthesize contactCell,copyrightCell,baseretCell,versionCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Om", @"Om");
        self.tabBarItem.image = [UIImage imageNamed:@"id-card"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - UITableView methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            baseretCell.textLabel.text = @"Baseret på bogen 'Ølspil' af Anders Højberg Byrgesen";
            baseretCell.textLabel.numberOfLines = 2;
            baseretCell.textLabel.textAlignment = NSTextAlignmentCenter;
            return baseretCell;
            break;
        case 1:
            contactCell.textLabel.text = @"contact@tallisoft.dk";
            contactCell.textLabel.textAlignment = NSTextAlignmentCenter;
            return contactCell;
            break;
        case 2:
            copyrightCell.textLabel.text = @"© Tallisoft.dk 2012";
            copyrightCell.textLabel.textAlignment = NSTextAlignmentCenter;
            return copyrightCell;
            break;
        case 3:
            versionCell.textLabel.text = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
            return versionCell;
            break;
        default:
            break;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        [mailController setSubject:@"Ang. Ølspil"];
        mailController.mailComposeDelegate = self;
        [self presentViewController:mailController animated:YES completion:nil];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Ide";
            break;
        case 1:
            return @"Kontakt";
            break;
        case 2:
            return @"Copyright";
            break;
        case 3:
            return @"Version";
            break;
        default:
            break;
    }
    return @"";
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 88;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

#pragma mark - Message methods

- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    UIAlertView *alertView = [[UIAlertView new] initWithTitle:@"" message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    switch (result) {
        case MessageComposeResultSent:
            alertView.title = NSLocalizedString(@"Sendt", nil);
            alertView.message = NSLocalizedString(@"Mailen blev sendt", nil);
            [alertView show];
            break;
        case MessageComposeResultFailed:
            alertView.title = NSLocalizedString(@"Fejl", nil);
            alertView.message = NSLocalizedString(@"Kunne ikke sende mail", nil);
            [alertView show];
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"Default.png"]];
    self.contentTableView.backgroundView = nil;
}

- (void)viewDidUnload
{
    [self setContentTableView:nil];
    [self setBaseretCell:nil];
    [self setCopyrightCell:nil];
    [self setContactCell:nil];
    [self setVersionCell:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
