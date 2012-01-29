//
//  MasterViewController.m
//  Galery
//
//  Created by Yuliya Khokhlova on 17.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "TextedView.h"

@implementation MasterViewController

@synthesize detailViewController = _detailViewController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Master", @"Master");
    }
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    imagesPath = [[[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Images"] retain];
    imagesName = [[fileManager contentsOfDirectoryAtPath:imagesPath error:nil] retain];
    
    images = [[NSMutableArray array] retain];
    scrollSubviews = [[NSMutableArray array] retain];
    
    for (NSString * name in imagesName)
    {
        NSString * fileName = [imagesPath stringByAppendingPathComponent:name];
        UIImage * image = [UIImage imageWithContentsOfFile:fileName];
        
        CGSize destSize = CGSizeMake(30, 40);
        UIGraphicsBeginImageContext(destSize);
        [image drawInRect:CGRectMake(0, 0, destSize.width, destSize.height)];
        UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        [images addObject:newImage];
    }
    
    return self;
}
							
- (void)dealloc
{
    [imagesPath release];
    [scrollSubviews release];
    [images release];
    [imagesName release];
    [_detailViewController release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [imagesName count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"Cell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    // Configure the cell.
    NSString * imageName = [imagesName objectAtIndex:indexPath.row];
    cell.textLabel.text = [imageName substringToIndex:imageName.length - 4];
    cell.imageView.image = [images objectAtIndex:indexPath.row];
    
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
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) 
    {
        self.detailViewController = [[[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil] autorelease];
        [self.detailViewController.view setNeedsDisplay];
        self.detailViewController.scrollView.pagingEnabled = YES;
        self.detailViewController.scrollView.showsVerticalScrollIndicator = NO;
        self.detailViewController.scrollView.showsHorizontalScrollIndicator = NO;
        
        CGFloat width = 0.0f;
        CGFloat height = 0.0f;
        NSUInteger subviewsCount = 3;
        for (NSUInteger i = 0; i < subviewsCount; i++ )
        {            
            TextedView * view = [[[NSBundle mainBundle] loadNibNamed:@"TextedView" owner:nil options:nil] objectAtIndex:0];
            
            [self.detailViewController.scrollView addSubview:view];
            [scrollSubviews addObject:view];
            
            width = view.bounds.size.width;
            height = view.bounds.size.height;
            view.frame = CGRectMake(i * width, 0, width, height);
        }
        
        [self.detailViewController.scrollView setContentSize:CGSizeMake(width * subviewsCount, height)];
    }
    
    currentItem = indexPath.row;
    int j = 0;
    int iMin = indexPath.row - 1;
    if (iMin < 0)
    {
        iMin = indexPath.row;
        j = 1;
    }
    
    int iMax = indexPath.row + 1;
    if (iMax >= images.count)
    {
        iMax = indexPath.row;
    }
    
    for (int i = iMin; i <= iMax; ++i)
    {
        NSString * name = [imagesName objectAtIndex:i];
        NSString * fileName = [imagesPath stringByAppendingPathComponent:name];
        UIImage * image = [UIImage imageWithContentsOfFile:fileName];        

        TextedView * currentView = [scrollSubviews objectAtIndex:j];
        currentView.imageView.image = image;
        currentView.textField.text = [imagesName objectAtIndex:i];
        j++;
    }
    
    [self.detailViewController.scrollView setContentOffset:CGPointMake(self.detailViewController.scrollView.bounds.size.width, 0)];
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

- (void)updateScrollViewWithDirection:(NSInteger)direction
{
    // direction = +1 <=> right
    // direction = -1 <=> left
    if (direction == 0)
        return;
    
    TextedView * view1 = [scrollSubviews objectAtIndex:1];
    TextedView * view2 = [scrollSubviews objectAtIndex:1 + direction];
    UIImage * tempImage = view2.imageView.image;
    
    view2.imageView.image = view1.imageView.image;
    view1.imageView.image = tempImage;
    
    NSInteger newItem = currentItem + 2 * direction;
    if (newItem < 0)
    {
        newItem = 0;
    }
    else if (newItem >= images.count)
    {
        newItem = images.count - 1;
    }
    
    NSUInteger index = 0;
    if (direction > 0)
    {
        index = 2;
    } 
    
    NSString * name = [imagesName objectAtIndex:newItem];
    NSString * fileName = [imagesPath stringByAppendingPathComponent:name];
    UIImage * image = [UIImage imageWithContentsOfFile:fileName];

    TextedView * view = [scrollSubviews objectAtIndex:index];
    view.imageView.image = image;
    
    currentItem = currentItem + direction;
    if (currentItem < 0)
    {
        currentItem = 0;
    }
    else if (currentItem >=images.count)
    {
        currentItem = images.count;
    }
}

@end